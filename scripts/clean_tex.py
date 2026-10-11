#!/usr/bin/env python3
"""Remove untracked LaTeX compilation files while preserving published PDFs."""

import argparse
import os
from pathlib import Path
import subprocess


ROOT = Path(__file__).resolve().parents[1]
SUFFIXES = (
    ".aux", ".log", ".out", ".toc", ".fls", ".fdb_latexmk",
    ".synctex", ".synctex.gz", ".synctex(busy)", ".synctex.gz(busy)",
    ".bbl", ".blg", ".bcf", ".run.xml", ".lof", ".lot", ".loa", ".loe", ".lol",
    ".idx", ".ind", ".ilg", ".acn", ".acr", ".alg", ".glg", ".glo", ".gls",
    ".glsdefs", ".glstex", ".nlo", ".nls", ".nav", ".snm", ".vrb", ".dvi", ".xdv",
)


def candidates(include_pdfs):
    tracked = set(os.fsdecode(subprocess.check_output(
        ["git", "ls-files", "--cached", "-z"], cwd=ROOT,
    )).split("\0"))
    for directory in ("notes", "templates", "build"):
        base = ROOT / directory
        if base.is_symlink():
            continue
        for folder, directories, filenames in os.walk(base, followlinks=False):
            directories[:] = [name for name in directories if name != ".git"]
            for name in filenames:
                path = Path(folder) / name
                relative = path.relative_to(ROOT).as_posix()
                if relative in tracked or path.is_symlink() or not path.is_file():
                    continue
                auxiliary = name.endswith(SUFFIXES)
                generated_pdf = (include_pdfs and path.suffix == ".pdf"
                                 and (directory == "build" or path.with_suffix(".tex").is_file()))
                if auxiliary or generated_pdf:
                    yield path


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dry-run", action="store_true", help="list files without deleting them")
    parser.add_argument("--pdfs", action="store_true",
                        help="also remove generated PDFs in build/ or beside matching TeX sources")
    args = parser.parse_args()
    paths = sorted(candidates(args.pdfs))
    for path in paths:
        if args.dry_run:
            print(path.relative_to(ROOT).as_posix())
        else:
            path.unlink()
    action = "Would remove" if args.dry_run else "Removed"
    print(f"{action} {len(paths)} LaTeX compilation files.")


if __name__ == "__main__":
    main()
