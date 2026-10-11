import contextlib
import importlib.util
import io
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch


SCRIPT = Path(__file__).resolve().parents[1] / "download_lectures.py"
spec = importlib.util.spec_from_file_location("download_lectures", SCRIPT)
lectures = importlib.util.module_from_spec(spec)
spec.loader.exec_module(lectures)
PDF = b"%PDF-1.4\nfixture\n%%EOF\n"


class LectureDownloadTests(unittest.TestCase):
    def test_links_resolve_deduplicate_and_filter(self):
        html = b'''<a href="lectures/duality.pdf">PDF</a>
        <a href="lectures/duality.pdf">Duplicate</a>
        <a href="https://example.com/duality.pdf">External</a>
        <a href="lectures/sets.pdf?download=1">Query</a>
        <a href="lectures/sets.pdf#page=1">Fragment</a>'''
        self.assertEqual(lectures.links(html, lectures.UCLA, lectures.UCLA + "lectures/"),
                         [lectures.UCLA + "lectures/duality.pdf"])

    def test_mit_complete_set_and_existing_names(self):
        html = "".join(f'<a href="{lectures.MIT}resources/mit6_251jf09_lec{i:02d}/">PDF</a>'
                       for i in reversed(range(1, 26))).encode()
        with patch.object(lectures, "html_page", return_value=html):
            files = list(lectures.lecture_links("mit"))
        self.assertEqual(len(files), 25)
        names = {name for url, name in files}
        self.assertIn("mit-6-251j-2009-lecture-10-polyhedral-representation.pdf", names)
        self.assertIn("mit-6-251j-2009-lecture-25.pdf", names)
        resource = lectures.MIT + "resources/mit6_251jf09_lec10/"
        pdf = lectures.MIT + "ab890d20b071105239fe0b9bcf599f57_MIT6_251JF09_lec10.pdf"
        with patch.object(lectures, "html_page", return_value=f'<a href="{pdf}">Download</a>'.encode()):
            self.assertEqual(lectures.pdf_url(resource), pdf)

    def test_ucla_current_chapters_and_background(self):
        stems = ["intro", "sets", "functions", "problems", "duality", "approx",
                 "stat", "geom", "unconstrained", "equality", "barrier", "num-lin-alg"]
        html = "".join(f'<a href="lectures/{stem}.pdf">PDF</a>' for stem in stems).encode()
        with patch.object(lectures, "html_page", return_value=html):
            files = list(lectures.lecture_links("ucla"))
        self.assertEqual(len(files), 12)
        self.assertIn((lectures.UCLA + "lectures/duality.pdf", "ece236b-2026-duality.pdf"), files)
        self.assertIn((lectures.UCLA + "lectures/num-lin-alg.pdf", "ece236b-2023-num-lin-alg.pdf"), files)

    def test_empty_or_ambiguous_indexes_fail(self):
        with patch.object(lectures, "html_page", return_value=b"<html>Maintenance</html>"):
            for provider in ("mit", "ucla"):
                with self.assertRaises(ValueError):
                    list(lectures.lecture_links(provider))
            with self.assertRaises(ValueError):
                lectures.pdf_url(lectures.MIT + "resources/example/")

    def test_curl_uses_https_and_bounded_retries(self):
        with patch.object(lectures.subprocess, "run") as run:
            lectures.fetch("https://example.com/lecture.pdf", Path("/tmp/lecture.pdf"))
        args = run.call_args.args[0]
        self.assertEqual(args[0:2], ["curl", "--disable"])
        self.assertEqual(args[args.index("--proto") + 1], "=https")
        self.assertEqual(args[args.index("--proto-redir") + 1], "=https")
        self.assertEqual(args[args.index("--retry") + 1], "2")
        self.assertEqual(args[args.index("--max-time") + 1], "30")
        self.assertEqual(args[-2:], ["--url", "https://example.com/lecture.pdf"])
        self.assertTrue(run.call_args.kwargs["check"])
        self.assertEqual(run.call_args.kwargs["timeout"], 95)

    def test_atomic_download_and_skip(self):
        with tempfile.TemporaryDirectory() as scratch:
            target = Path(scratch) / "mit" / "lecture.pdf"
            with patch.object(lectures, "fetch", side_effect=lambda url, path: path.write_bytes(PDF)) as fetch:
                lectures.download("https://example.com/lecture.pdf", target)
                lectures.download("https://example.com/lecture.pdf", target)
            self.assertEqual(fetch.call_count, 1)
            self.assertEqual(target.read_bytes(), PDF)
            self.assertEqual(list(target.parent.iterdir()), [target])

    def test_failure_keeps_existing_file_and_removes_partial(self):
        with tempfile.TemporaryDirectory() as scratch:
            target = Path(scratch) / "lecture.pdf"
            target.write_bytes(b"previous incomplete file")
            for response in (b"<html>error</html>", b"%PDF-1.4\ntruncated"):
                with patch.object(lectures, "fetch", side_effect=lambda url, path: path.write_bytes(response)):
                    with self.assertRaises(ValueError):
                        lectures.download("https://example.com/lecture.pdf", target)
                self.assertEqual(target.read_bytes(), b"previous incomplete file")
                self.assertEqual(list(target.parent.iterdir()), [target])
            with patch.object(lectures, "fetch", side_effect=subprocess.CalledProcessError(6, "curl")):
                with self.assertRaises(subprocess.CalledProcessError):
                    lectures.download("https://example.com/lecture.pdf", target)
            self.assertEqual(list(target.parent.iterdir()), [target])

    def test_symlink_is_not_replaced(self):
        with tempfile.TemporaryDirectory() as scratch:
            existing = Path(scratch) / "original.pdf"
            existing.write_bytes(PDF)
            target = Path(scratch) / "lecture.pdf"
            target.symlink_to(existing)
            with self.assertRaises(ValueError):
                lectures.download("https://example.com/lecture.pdf", target)
            self.assertEqual(existing.read_bytes(), PDF)

    def test_main_continues_after_one_resource_failure(self):
        with tempfile.TemporaryDirectory() as scratch:
            files = [("bad", "bad.pdf"), ("good", "good.pdf")]
            def resolve(url):
                if url == "bad":
                    raise ValueError("unavailable")
                return "https://example.com/good.pdf"
            with patch("sys.argv", [str(SCRIPT), "--dest", scratch]), \
                    patch.object(lectures, "lecture_links", return_value=files), \
                    patch.object(lectures, "pdf_url", side_effect=resolve), \
                    patch.object(lectures, "fetch", side_effect=lambda url, path: path.write_bytes(PDF)), \
                    contextlib.redirect_stdout(io.StringIO()), contextlib.redirect_stderr(io.StringIO()):
                self.assertEqual(lectures.main(), 1)
            for provider in ("mit", "ucla"):
                self.assertEqual((Path(scratch) / provider / "good.pdf").read_bytes(), PDF)

    def test_dry_run_creates_no_files(self):
        with tempfile.TemporaryDirectory() as scratch:
            target = Path(scratch) / "not-created"
            with patch("sys.argv", [str(SCRIPT), "--dest", str(target), "--dry-run"]), \
                    patch.object(lectures, "lecture_links", return_value=[("https://example.com/lecture.pdf", "lecture.pdf")]), \
                    patch.object(lectures, "fetch") as fetch, contextlib.redirect_stdout(io.StringIO()):
                self.assertEqual(lectures.main(), 0)
            self.assertFalse(target.exists())
            fetch.assert_not_called()

    def test_cli_downloads_both_sets_from_another_directory_and_reuses_files(self):
        stems = ["intro", "sets", "functions", "problems", "duality", "approx",
                 "stat", "geom", "unconstrained", "equality", "barrier", "num-lin-alg"]
        with tempfile.TemporaryDirectory() as scratch:
            root = Path(scratch)
            urls = {}
            resources = [lectures.MIT + f"resources/mit6_251jf09_lec{i:02d}/" for i in range(1, 26)]
            urls[lectures.MIT + "pages/lecture-notes/"] = "".join(f'<a href="{url}">PDF</a>' for url in resources)
            for i, resource in enumerate(resources, 1):
                pdf = lectures.MIT + f"fixture_MIT6_251JF09_lec{i:02d}.pdf"
                urls[resource] = f'<a href="{pdf}">PDF</a><a href="{pdf}">Download</a>'
                urls[pdf] = PDF.decode()
            urls[lectures.UCLA] = "".join(f'<a href="lectures/{stem}.pdf">PDF</a>' for stem in stems)
            urls.update({lectures.UCLA + f"lectures/{stem}.pdf": PDF.decode() for stem in stems})
            fixture = root / "responses.json"
            fixture.write_text(json.dumps(urls))
            log = root / "requests.log"
            curl = root / "curl"
            curl.write_text('''#!/usr/bin/env python3
import json, os, sys
from pathlib import Path
url = sys.argv[sys.argv.index("--url") + 1]
target = sys.argv[sys.argv.index("--output") + 1]
with open(os.environ["LECTURE_TEST_LOG"], "a") as stream:
    stream.write(url + "\\n")
Path(target).write_text(json.loads(Path(os.environ["LECTURE_TEST_RESPONSES"]).read_text())[url])
''')
            curl.chmod(0o755)
            destination = root / "source copies"
            env = dict(os.environ, PATH=str(root) + os.pathsep + os.environ["PATH"],
                       LECTURE_SOURCES_DIR=str(destination), LECTURE_TEST_RESPONSES=str(fixture),
                       LECTURE_TEST_LOG=str(log))
            for attempt in range(2):
                result = subprocess.run([sys.executable, str(SCRIPT)], cwd="/tmp", env=env,
                                        capture_output=True, text=True)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(len(list((destination / "mit").glob("*.pdf"))), 25)
                self.assertEqual(len(list((destination / "ucla").glob("*.pdf"))), 12)
                if attempt == 0:
                    requests_before = len(log.read_text().splitlines())
                else:
                    self.assertEqual(len(log.read_text().splitlines()), requests_before + 2)
            self.assertEqual((destination / "ucla/ece236b-2026-duality.pdf").read_bytes(), PDF)
            self.assertFalse(list(destination.rglob("*.part")))


if __name__ == "__main__":
    unittest.main()
