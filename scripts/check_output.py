#!/usr/bin/env python3
"""Verify exported PDF hashes and the inputs recorded by build.sh."""

import argparse
import hashlib
import json
import subprocess
from pathlib import Path

from repo_files import ROOT, RepoFiles

MANIFEST = "docs/pdf-build.json"
parser = argparse.ArgumentParser(description=__doc__)
mode = parser.add_mutually_exclusive_group()
mode.add_argument("--record", action="store_true", help="used by build.sh after a successful build")
mode.add_argument("--staged", action="store_true", help="check exactly the Git index")
args = parser.parse_args()
files = RepoFiles(staged=args.staged)
inputs = [p for p in files.paths if (p.startswith("notes/") and not p.endswith("/.gitkeep"))
          or (p.startswith("templates/") and p.endswith(".sty"))]
expected = {"output/" + p[len("notes/"):-4] + ".pdf"
            for p in inputs if p.startswith("notes/") and p.endswith(".tex")}
exports = {p for p in files.paths if p.startswith("output/")}
if exports != expected:
    parser.exit(1, f"Output must contain exactly the note PDFs. Missing: {sorted(expected - exports)}; unexpected: {sorted(exports - expected)}\n")
sha256 = lambda content: hashlib.sha256(content).hexdigest()
record = {
    "inputs": {p: sha256(files.read(p)) for p in inputs},
    "pdfs": {p: sha256(files.read(p)) for p in sorted(expected)},
}
changed = set()
if args.staged:
    changed = set(subprocess.check_output(
        ["git", "diff", "--cached", "--name-only", "-z"], cwd=ROOT,
    ).decode("utf-8").split("\0"))
for output in sorted(expected):
    content = files.read(output)
    if not content.startswith(b"%PDF-"):
        parser.exit(1, f"Invalid PDF: {output}\n")
    compiled = ROOT / ("build/" + output[len("output/"):])
    if (not args.staged or output in changed) and compiled.is_file():
        if compiled.read_bytes() != content:
            parser.exit(1, f"{output} differs from its build PDF; run ./build.sh.\n")
    if args.record and not compiled.is_file():
        parser.exit(1, f"Missing build PDF: {compiled}\n")
canonical = (json.dumps(record, indent=2) + "\n").encode()
if args.record:
    (ROOT / MANIFEST).write_bytes(canonical)
    print(f"Recorded PDF build hashes ({len(expected)} PDFs).")
else:
    if MANIFEST not in files.paths:
        parser.exit(1, "Missing PDF build record; run ./build.sh.\n")
    old = json.loads(files.read(MANIFEST))
    if old != record:
        mismatches = [p for group in record for p in set(old.get(group, {})) | set(record[group])
                      if old.get(group, {}).get(p) != record[group].get(p)]
        parser.exit(1, "PDF build hashes are stale: " + ", ".join(sorted(mismatches))
                    + "\nRun ./build.sh and stage the PDFs and docs/pdf-build.json.\n")
    print(f"PDF build hash check passed ({len(expected)} PDFs).")
