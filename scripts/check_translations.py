#!/usr/bin/env python3
"""Verify English/Polish section hashes after a translation review."""

import argparse
import hashlib
import json
import re
from pathlib import Path

from repo_files import ROOT, RepoFiles


def sections(content):
    """Split ATX-heading sections; compare fenced examples separately."""
    blocks, fences, current, code = [], [], [], []
    heading, fence = None, None
    for line in content.decode("utf-8").splitlines(keepends=True):
        marker = re.match(r"^ {0,3}(`{3,}|~{3,})(.*)$", line)
        if fence:
            code.append(line)
            if marker and marker[1][0] == fence[0] and len(marker[1]) >= len(fence) and not marker[2].strip():
                fences.append("".join(code))
                fence, code = None, []
            continue
        if marker:
            fence, code = marker[1], [line]
            continue
        match = re.match(r"^(#{1,6})\s+(.+?)\s*#*\s*$", line)
        if match:
            blocks.append((heading, "".join(current)))
            heading = (len(match[1]), match[2])
            current = []
        current.append(line)
    if fence:
        raise ValueError("Unclosed Markdown code fence")
    blocks.append((heading, "".join(current)))
    return blocks, fences


def record_for(en, pl):
    english, en_fences = sections(en)
    polish, pl_fences = sections(pl)
    depths = lambda blocks: [heading[0] if heading else 0 for heading, _ in blocks]
    if depths(english) != depths(polish):
        raise ValueError("Heading depths and order differ")
    if en_fences != pl_fences:
        raise ValueError("Fenced examples differ")
    stack, counts, record = [], {}, {}
    for (heading, en_text), (_, pl_text) in zip(english, polish):
        key = "/"
        if heading:
            depth, title = heading
            while stack and stack[-1][0] >= depth:
                stack.pop()
            slug = re.sub(r"[^a-z0-9]+", "-", title.lower()).strip("-")
            base = (stack[-1][1] if stack else "") + "/" + slug
            counts[base] = counts.get(base, 0) + 1
            key = base + (f"~{counts[base]}" if counts[base] > 1 else "")
            stack.append((depth, key))
        if en_text.strip() or pl_text.strip():
            digest = lambda text: hashlib.sha256(text.strip().encode("utf-8")).hexdigest()
            record[key] = {"en": digest(en_text), "pl": digest(pl_text)}
    return record


parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument("pairs", nargs="*", help="English .md files reviewed in both languages")
parser.add_argument("--write", action="store_true", help="record explicitly reviewed pairs")
parser.add_argument("--all", action="store_true", help="explicitly confirm every pair with --write")
parser.add_argument("--staged", action="store_true", help="check exactly the Git index")
args = parser.parse_args()
if (args.write and args.staged) or (args.all and not args.write):
    parser.error("--staged is read-only; --all requires --write")
if args.write and not (args.pairs or args.all):
    parser.error("Name the reviewed English files, or explicitly use --write --all")
files = RepoFiles(staged=args.staged)
pairs = [p for p in files.paths if p.endswith(".md") and not p.endswith(".pl.md")
         and (p == "README.md" or p.startswith("docs/")) and p != "docs/glossary.md"]
if args.pairs:
    unknown = set(args.pairs) - set(pairs)
    if unknown:
        parser.error(f"Unknown pairs: {', '.join(sorted(unknown))}")
    pairs = args.pairs
errors = []
for sidecar in [p for p in files.paths if p.endswith(".i18n.json")]:
    if sidecar[:-10] + ".md" not in files.paths:
        errors.append(f"{sidecar}: missing English document")
for pl in [p for p in files.paths if p.endswith(".pl.md")]:
    if pl[:-6] + ".md" not in files.paths:
        errors.append(f"{pl}: missing English counterpart")
for en in pairs:
    pl, sidecar = en[:-3] + ".pl.md", en[:-3] + ".i18n.json"
    try:
        if pl not in files.paths:
            raise ValueError("Missing Polish counterpart")
        en_text, pl_text = files.read(en), files.read(pl)
        if f"]({Path(pl).name})".encode() not in en_text or f"]({Path(en).name})".encode() not in pl_text:
            raise ValueError("Missing reciprocal language link")
        canonical = (json.dumps(record_for(en_text, pl_text), ensure_ascii=False, indent=2) + "\n").encode()
        if args.write:
            (ROOT / sidecar).write_bytes(canonical)
            print(f"Recorded reviewed pair: {en}")
        else:
            if sidecar not in files.paths:
                raise ValueError("Missing review hash record")
            existing = files.read(sidecar)
            if existing != canonical:
                old, new = json.loads(existing), json.loads(canonical)
                changed = sorted(key for key in set(old) | set(new) if old.get(key) != new.get(key))
                raise ValueError("Review and re-record changed sections: " + ", ".join(changed or ["record formatting"]))
    except (ValueError, OSError) as error:
        errors.append(f"{en}: {error}")
if errors:
    parser.exit(1, "\n".join(errors) + "\n")
print(f"Translation pairing check passed ({len(pairs)} pairs).")
