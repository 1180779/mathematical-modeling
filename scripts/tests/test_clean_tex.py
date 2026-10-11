"""Check cleanup boundaries and preservation of source and published files."""

from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]


class CleanTexTests(unittest.TestCase):
    def setUp(self):
        temporary = tempfile.TemporaryDirectory(prefix="tex cleanup ")
        self.addCleanup(temporary.cleanup)
        self.root = Path(temporary.name)
        (self.root / "scripts").mkdir()
        shutil.copy2(ROOT / "scripts/clean_tex.py", self.root / "scripts/clean_tex.py")
        subprocess.run(["git", "init", "-q", str(self.root)], check=True)
        self.kept = {
            "notes/lectures/chapter.tex", "notes/lectures/chapter.pdf",
            "notes/lectures/.latexmkrc", "templates/modeling-notes.sty",
            "output/lectures/chapter.pdf", "build/lectures/chapter.pdf",
            "matlab/output/experiment.log", "docs/example.aux",
            "notes/lectures/tracked.aux",
        }
        self.removed = {
            "notes/lectures/chapter.aux", "notes/lectures/chapter.synctex.gz(busy)",
            "notes/lectures/chapter.idx", "notes/lectures/chapter.gls",
            "templates/lecture.toc", "build/lectures/chapter.fdb_latexmk",
            "build/lectures/chapter.log",
        }
        for name in self.kept | self.removed:
            path = self.root / name
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text("contents to preserve or clean\n")
        subprocess.run(["git", "add", "notes/lectures/tracked.aux"],
                       cwd=self.root, check=True)

    def run_clean(self, *args):
        # Invocation from another directory must still find the script's repo.
        return subprocess.run(["python3", str(self.root / "scripts/clean_tex.py"), *args],
                              cwd="/tmp", check=True, capture_output=True, text=True)

    def test_default_removes_auxiliary_files_and_preserves_pdfs_and_tracked_files(self):
        self.run_clean()
        self.assertTrue(all((self.root / name).is_file() for name in self.kept))
        self.assertTrue(all(not (self.root / name).exists() for name in self.removed))
        self.assertIn("0", self.run_clean().stdout)

    def test_preview_does_not_delete_anything(self):
        result = self.run_clean("--dry-run")
        self.assertIn("notes/lectures/chapter.aux", result.stdout)
        self.assertTrue(all((self.root / name).is_file() for name in self.kept | self.removed))

    def test_gitignore_covers_compilation_files_but_not_published_pdfs(self):
        shutil.copy2(ROOT / ".gitignore", self.root / ".gitignore")
        paths = self.removed | {"notes/lectures/chapter.pdf", "templates/lecture.pdf"}
        result = subprocess.run(["git", "check-ignore", "--stdin"], cwd=self.root,
                                input="\n".join(paths), capture_output=True, text=True, check=True)
        self.assertEqual(set(result.stdout.splitlines()), paths)
        result = subprocess.run(["git", "check-ignore", "output/lectures/chapter.pdf"],
                                cwd=self.root, capture_output=True)
        self.assertEqual(result.returncode, 1)

    def test_pdf_option_preserves_published_pdfs_and_pdf_assets(self):
        asset = self.root / "notes/lectures/illustration.pdf"
        asset.write_bytes(b"PDF asset without a matching TeX source")
        self.run_clean("--pdfs")
        self.assertFalse((self.root / "notes/lectures/chapter.pdf").exists())
        self.assertFalse((self.root / "build/lectures/chapter.pdf").exists())
        self.assertTrue((self.root / "output/lectures/chapter.pdf").is_file())
        self.assertTrue(asset.is_file())

    def test_does_not_follow_directory_or_file_symlinks(self):
        outside = self.root / "outside"
        outside.mkdir()
        auxiliary = outside / "external.aux"
        auxiliary.write_text("must survive\n")
        (self.root / "notes/external").symlink_to(outside, target_is_directory=True)
        link = self.root / "notes/lectures/linked.aux"
        link.symlink_to(auxiliary)
        self.run_clean()
        self.assertTrue(auxiliary.is_file())
        self.assertTrue(link.is_symlink())

    def test_does_not_follow_a_symlinked_build_root(self):
        shutil.rmtree(self.root / "build")
        outside = self.root / "outside"
        outside.mkdir()
        auxiliary = outside / "external.aux"
        auxiliary.write_text("must survive\n")
        (self.root / "build").symlink_to(outside, target_is_directory=True)
        self.run_clean()
        self.assertTrue(auxiliary.is_file())


if __name__ == "__main__":
    unittest.main()
