"""Exercise the real hook and Git repository, replacing only curl's network I/O."""

import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]
SCRIPT = ROOT / "scripts/upload_boox.py"
HOOK = ROOT / ".githooks/post-commit"
FAKE_CURL = r'''#!/usr/bin/env python3
import json, os, re, sys
from pathlib import Path
args = sys.argv[1:]
form = args[args.index("--form") + 1]
match = re.fullmatch(r'file=@"((?:\\.|[^"\\])*)";type=application/pdf', form)
if not match:
    sys.exit(99)
path = Path(re.sub(r'\\(.)', r'\1', match[1]))
record = {
    "name": path.name, "content": path.read_bytes().decode(),
    "fields": [args[i + 1] for i, arg in enumerate(args) if arg == "--form-string"],
    "url": args[args.index("--url") + 1],
    "connect_timeout": args[args.index("--connect-timeout") + 1],
    "upload_timeout": args[args.index("--max-time") + 1],
}
with open(os.environ["TEST_UPLOAD_LOG"], "a") as log:
    log.write(json.dumps(record) + "\n")
mode = os.environ.get("TEST_CURL_MODE", "ok")
if mode == "offline":
    sys.exit(7)
if mode == "partial" and path.name != "a.pdf":
    sys.exit(22)
if mode == "rejected":
    print('{"successful":false,"code":1}')
elif mode == "html":
    print('<html>Device unavailable</html>')
else:
    print('{"successful":true,"code":0}')
'''


class BooxUploadTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="boox test ")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.env = {k: v for k, v in os.environ.items()
                    if not k.startswith(("BOOX_", "GIT_", "TEST_CURL_"))}
        self.env.update({
            "BOOX_UPLOAD_URL": "http://device.example:8085/api/storage/upload",
            "BOOX_REMOTE_DIR": "/device/Notes with spaces",
            "TEST_UPLOAD_LOG": str(self.root / "uploads.jsonl"),
        })
        binary_dir = self.root / "bin"
        binary_dir.mkdir()
        curl = binary_dir / "curl"
        curl.write_text(FAKE_CURL)
        curl.chmod(0o755)
        self.env["PATH"] = str(binary_dir) + os.pathsep + self.env["PATH"]
        self.git("init", "-q")
        self.git("config", "user.email", "test@example.invalid")
        self.git("config", "user.name", "Upload test")
        self.git("config", "core.hooksPath", ".githooks")
        self.write("output/lectures/a.pdf", "%PDF-1.4\nfirst\n")
        self.write("output/exercises/b.pdf", "%PDF-1.4\nsecond\n")
        self.write("output/ignored.txt", "not a PDF")
        self.commit()

    def git(self, *args):
        return subprocess.run(["git", *args], cwd=self.root, env=self.env,
                              check=True, capture_output=True, text=True)

    def write(self, name, text):
        path = self.root / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(text)

    def commit(self):
        self.git("add", "output")
        return self.git("commit", "-qm", "Update notes")

    def run_upload(self, *args):
        result = subprocess.run(["python3", str(SCRIPT), *args], cwd=self.root,
                                env=self.env, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        return result

    def uploads(self):
        log = self.root / "uploads.jsonl"
        return [json.loads(line) for line in log.read_text().splitlines()] if log.exists() else []

    def test_first_sync_then_only_changed_committed_pdf(self):
        self.env.update(BOOX_CONNECT_TIMEOUT="0.4", BOOX_UPLOAD_TIMEOUT="3")
        self.run_upload()
        uploads = self.uploads()
        self.assertEqual({r["name"] for r in uploads}, {"a.pdf", "b.pdf"})
        for record in uploads:
            folder = "lectures" if record["name"] == "a.pdf" else "exercises"
            self.assertEqual(record["fields"],
                             [f"dir=/device/Notes with spaces/{folder}", "sender=web"])
            self.assertEqual(record["url"], self.env["BOOX_UPLOAD_URL"])
            self.assertEqual(record["connect_timeout"], "0.4")
            self.assertEqual(record["upload_timeout"], "3.0")
        self.run_upload()
        self.assertEqual(len(self.uploads()), 2)
        self.write("output/lectures/a.pdf", "%PDF-1.4\ncommitted revision\n")
        self.commit()
        self.write("output/lectures/a.pdf", "%PDF-1.4\nunstaged edit\n")
        self.run_upload()
        self.assertEqual(len(self.uploads()), 3)
        self.assertEqual(self.uploads()[-1]["content"], "%PDF-1.4\ncommitted revision\n")

    def test_offline_stops_after_one_attempt_and_retries_pending(self):
        self.env["TEST_CURL_MODE"] = "offline"
        self.run_upload()
        self.assertEqual(len(self.uploads()), 1)
        self.env["TEST_CURL_MODE"] = "ok"
        self.run_upload()
        self.assertEqual({r["name"] for r in self.uploads()[1:]}, {"a.pdf", "b.pdf"})

    def test_working_tree_uploads_edits_and_untracked_pdfs_then_skips_unchanged(self):
        self.run_upload()
        self.write("output/lectures/a.pdf", "%PDF-1.4\ndraft\n")
        self.write("output/lectures/new.pdf", "%PDF-1.4\nnew draft\n")
        self.run_upload("--working-tree")
        self.assertEqual([r["content"] for r in self.uploads()[2:]],
                         ["%PDF-1.4\ndraft\n", "%PDF-1.4\nnew draft\n"])
        self.run_upload("--working-tree")
        self.assertEqual(len(self.uploads()), 4)
        self.run_upload()
        self.assertEqual(self.uploads()[-1]["content"], "%PDF-1.4\nfirst\n")
        self.assertEqual(len(self.uploads()), 5)

    def test_committing_uploaded_draft_does_not_resend_it(self):
        self.write("output/lectures/a.pdf", "%PDF-1.4\ndraft\n")
        self.run_upload("--working-tree")
        self.commit()
        self.run_upload()
        self.assertEqual(len(self.uploads()), 2)

    def test_working_tree_supports_ignored_build_directory_and_skips_symlinks(self):
        self.write(".gitignore", "build/\n")
        self.write("build/lectures/draft.pdf", "%PDF-1.4\nbuild draft\n")
        (self.root / "build/lectures/link.pdf").symlink_to("draft.pdf")
        (self.root / "build/linked").symlink_to(self.root / "output", target_is_directory=True)
        self.env["BOOX_PDF_DIR"] = "build"
        self.run_upload("--working-tree")
        self.assertEqual([r["name"] for r in self.uploads()], ["draft.pdf"])
        self.assertEqual(self.uploads()[0]["fields"][0],
                         "dir=/device/Notes with spaces/lectures")

    def test_working_tree_retries_failed_draft(self):
        self.env["TEST_CURL_MODE"] = "offline"
        self.write("output/lectures/a.pdf", "%PDF-1.4\ndraft\n")
        self.run_upload("--working-tree")
        self.env["TEST_CURL_MODE"] = "ok"
        self.run_upload("--working-tree")
        self.assertEqual([r["content"] for r in self.uploads()[:2]],
                         ["%PDF-1.4\ndraft\n", "%PDF-1.4\ndraft\n"])
        self.run_upload("--working-tree")
        self.assertEqual(len(self.uploads()), 3)

    def test_development_command_builds_before_upload_and_stops_on_build_failure(self):
        shutil.copy2(ROOT / "Makefile", self.root / "Makefile")
        scripts = self.root / "scripts"
        scripts.mkdir()
        shutil.copy2(SCRIPT, scripts / "upload_boox.py")
        self.write("build.sh", '#!/usr/bin/env python3\nfrom pathlib import Path\n'
                   'Path("output/lectures/a.pdf").write_text("%PDF-1.4\\nfresh build\\n")\n')
        (self.root / "build.sh").chmod(0o755)
        result = subprocess.run(["make", "upload-boox-dev", "PYTHON=python3"],
                                cwd=self.root, env=self.env, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.uploads()[0]["content"], "%PDF-1.4\nfresh build\n")
        self.write("output/lectures/a.pdf", "%PDF-1.4\nunbuilt edit\n")
        self.write("build.sh", "#!/bin/sh\nexit 1\n")
        result = subprocess.run(["make", "upload-boox-dev", "PYTHON=python3"],
                                cwd=self.root, env=self.env, capture_output=True, text=True)
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(len(self.uploads()), 2)

    def test_partial_success_is_saved_without_resending_it(self):
        self.env["TEST_CURL_MODE"] = "partial"
        self.run_upload()
        self.env["TEST_CURL_MODE"] = "ok"
        self.run_upload()
        self.assertEqual([r["name"] for r in self.uploads()].count("a.pdf"), 1)
        self.assertEqual([r["name"] for r in self.uploads()].count("b.pdf"), 2)

    def test_json_failure_and_non_json_response_are_not_success(self):
        for mode in ("rejected", "html"):
            with self.subTest(mode=mode):
                self.env["TEST_CURL_MODE"] = mode
                self.run_upload()
                self.assertFalse((self.root / ".git/boox-upload.json").exists())
        self.env["TEST_CURL_MODE"] = "ok"
        self.run_upload()
        self.assertEqual(len(self.uploads()), 4)

    def test_unconfigured_upload_and_empty_scope_do_no_network_io(self):
        self.env.pop("BOOX_UPLOAD_URL")
        self.run_upload()
        self.env["BOOX_UPLOAD_URL"] = "http://device.example/upload"
        self.env["BOOX_PDF_DIR"] = "no-pdfs"
        self.run_upload()
        self.assertEqual(self.uploads(), [])

    def test_destination_change_resends_pdfs(self):
        self.run_upload()
        self.env["BOOX_REMOTE_DIR"] = "/device/Other folder"
        self.run_upload()
        self.assertEqual(len(self.uploads()), 4)

    def test_alternate_config_state_and_pdf_directory(self):
        self.env.pop("BOOX_REMOTE_DIR")
        self.env["BOOX_ENV_FILE"] = "local/config.env"
        self.write("local/config.env", 'BOOX_REMOTE_DIR="/device/Selected"\n'
                   'BOOX_PDF_DIR="output/lectures"\nBOOX_STATE_FILE="local/state.json"\n')
        self.run_upload()
        self.assertEqual([r["name"] for r in self.uploads()], ["a.pdf"])
        self.assertTrue((self.root / "local/state.json").is_file())
        self.run_upload()
        self.assertEqual(len(self.uploads()), 1)

    def test_invalid_configuration_does_not_attempt_upload(self):
        for setting in ({"BOOX_CONNECT_TIMEOUT": "nan"},
                        {"BOOX_UPLOAD_TIMEOUT": "0"},
                        {"BOOX_PDF_DIR": "../outside"},
                        {"BOOX_UPLOAD_URL": "file:///tmp/unexpected"}):
            with self.subTest(setting=setting):
                original = self.env.copy()
                self.env.update(setting)
                self.run_upload()
                self.assertEqual(self.uploads(), [])
                self.env = original

    def test_same_filename_in_separate_directories_is_preserved(self):
        self.write("output/other/a.pdf", "%PDF-1.4\ncollision\n")
        self.commit()
        self.run_upload()
        self.assertEqual(len(self.uploads()), 3)
        destinations = {r["fields"][0]: r["content"] for r in self.uploads()
                        if r["name"] == "a.pdf"}
        self.assertEqual(destinations, {
            "dir=/device/Notes with spaces/lectures": "%PDF-1.4\nfirst\n",
            "dir=/device/Notes with spaces/other": "%PDF-1.4\ncollision\n",
        })

    def test_nested_paths_and_root_pdfs_use_relative_parent_directories(self):
        self.write("output/archive/week 1/a.pdf", "%PDF-1.4\nnested\n")
        self.write("output/index.pdf", "%PDF-1.4\nroot\n")
        self.commit()
        self.run_upload()
        destinations = {(r["name"], r["fields"][0]) for r in self.uploads()}
        self.assertIn(("a.pdf", "dir=/device/Notes with spaces/archive/week 1"), destinations)
        self.assertIn(("index.pdf", "dir=/device/Notes with spaces"), destinations)
        self.run_upload()
        self.assertEqual(len(self.uploads()), 4)

    def test_old_flat_upload_state_resends_to_subdirectories(self):
        blobs = {path: self.git("rev-parse", "HEAD:" + path).stdout.strip()
                 for path in ("output/lectures/a.pdf", "output/exercises/b.pdf")}
        self.write(".git/boox-upload.json", json.dumps({
            "destination": [self.env["BOOX_UPLOAD_URL"], self.env["BOOX_REMOTE_DIR"], "output"],
            "uploaded": blobs,
        }))
        self.run_upload()
        self.assertEqual(len(self.uploads()), 2)
        self.assertTrue(all(r["fields"][0].endswith(("/lectures", "/exercises"))
                            for r in self.uploads()))
        self.run_upload()
        self.assertEqual(len(self.uploads()), 2)

    def test_rejected_subdirectory_does_not_fall_back_to_flat_upload(self):
        self.env["TEST_CURL_MODE"] = "rejected"
        self.run_upload()
        self.assertEqual(len(self.uploads()), 1)
        self.assertTrue(self.uploads()[0]["fields"][0].endswith("/lectures"))
        self.assertFalse((self.root / ".git/boox-upload.json").exists())

    def test_special_filename_and_symlink(self):
        self.write('output/lectures/c; "quoted" Ś.pdf', "%PDF-1.4\nspecial\n")
        (self.root / "output/lectures/link.pdf").symlink_to("a.pdf")
        self.commit()
        self.run_upload()
        self.assertEqual({r["name"] for r in self.uploads()}, {"a.pdf", "b.pdf", 'c; "quoted" Ś.pdf'})

    def test_post_commit_uses_local_config_and_never_blocks_commit(self):
        hooks = self.root / ".githooks"
        hooks.mkdir()
        shutil.copy2(HOOK, hooks / "post-commit")
        scripts = self.root / "scripts"
        scripts.mkdir()
        shutil.copy2(SCRIPT, scripts / "upload_boox.py")
        self.env.pop("BOOX_UPLOAD_URL")
        self.env.pop("BOOX_REMOTE_DIR")
        self.write(".env.boox", 'BOOX_UPLOAD_URL="http://device.example/upload"\n'
                   'BOOX_REMOTE_DIR="/device/From config"\n')
        self.env["TEST_CURL_MODE"] = "offline"
        self.write("output/lectures/a.pdf", "%PDF-1.4\nnew version\n")
        result = self.commit()
        self.assertIn("BOOX", result.stdout + result.stderr)
        self.env["TEST_CURL_MODE"] = "ok"
        self.run_upload()
        self.assertEqual(len(self.uploads()), 3)
        self.assertEqual(self.uploads()[-1]["fields"][0], "dir=/device/From config/exercises")

    def test_config_is_data_and_exported_environment_takes_precedence(self):
        self.write(".env.boox", 'BOOX_REMOTE_DIR="/device/$(touch unexpected)"\n')
        self.env.pop("BOOX_REMOTE_DIR")
        self.run_upload()
        self.assertFalse((self.root / "unexpected").exists())
        self.assertEqual(self.uploads()[0]["fields"][0], "dir=/device/$(touch unexpected)/lectures")
        self.env["BOOX_UPLOAD_URL"] = ""
        self.run_upload()
        self.assertEqual(len(self.uploads()), 2)


if __name__ == "__main__":
    unittest.main()
