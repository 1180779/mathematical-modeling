#!/usr/bin/env python3
"""Check or apply latexindent formatting to LaTeX and TikZ sources."""

import argparse
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

from repo_files import ROOT, RepoFiles

parser = argparse.ArgumentParser(description=__doc__)
mode = parser.add_mutually_exclusive_group()
mode.add_argument("--check", action="store_true", help="check the working tree (default)")
mode.add_argument("--write", action="store_true", help="format the working tree")
mode.add_argument("--staged", action="store_true", help="check exactly the Git index")
args = parser.parse_args()

if not shutil.which("latexindent"):
    parser.exit(1, "latexindent is required; install it with your TeX distribution.\n")
files = RepoFiles(staged=args.staged)
sources = [p for p in files.paths if Path(p).suffix in {".tex", ".tikz", ".sty"}]
changed = []
with tempfile.TemporaryDirectory(prefix="modeling-format-") as scratch:
    config = Path(scratch) / "latexindent.yaml"
    config.write_bytes(files.read(".latexindent.yaml"))
    for path in sources:
        original = files.read(path)
        result = subprocess.run(
            ["latexindent", f"-l={config}", f"-c={scratch}", "-"],
            input=original, stdout=subprocess.PIPE, stderr=subprocess.PIPE, cwd=ROOT,
        )
        if result.returncode:
            sys.stderr.buffer.write(result.stderr)
            parser.exit(1, f"latexindent failed for {path}.\n")
        if result.stdout != original:
            changed.append(path)
            if args.write:
                (ROOT / path).write_bytes(result.stdout)
            print(f"{'Formatted' if args.write else 'Needs formatting'}: {path}")
if changed and not args.write:
    parser.exit(1, "Run python3 scripts/format_tex.py --write, then stage the files.\n")
print(f"LaTeX/TikZ format check passed ({len(sources)} files).")
