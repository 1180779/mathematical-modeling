"""Read repository files from the working tree or the Git index."""

from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]


class RepoFiles:
    def __init__(self, staged=False):
        self.staged = staged
        args = ["git", "ls-files", "--cached", "-z"]
        if not staged:
            args += ["--others", "--exclude-standard"]
        names = subprocess.check_output(args, cwd=ROOT).decode("utf-8").split("\0")
        self.paths = sorted(
            path for path in set(names)
            if path and (staged or (ROOT / path).is_file())
        )

    def read(self, path):
        if self.staged:
            return subprocess.check_output(["git", "show", f":{path}"], cwd=ROOT)
        return (ROOT / path).read_bytes()
