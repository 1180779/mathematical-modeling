# Separate intermediate builds from reading PDFs

English | [Polski](2026-10-04-pdf-build-and-output.pl.md)

Status: implemented

## Problem

Manual LaTeX commands leave reading PDFs mixed with intermediate files. The user
requested a build script and a PDF-only directory grouped like the study notes,
with intermediate builds excluded from Git. IntelliJ metadata must also stay local.

## Decision

`build.sh` compiles every `.tex` document under `notes/` into a matching `build/`
subdirectory. After all compilations succeed, it copies the PDFs to matching
paths under `output/`. Both trees preserve relative directories and filenames,
so identical filenames in different study categories do not collide.
Templates are previewed separately and are not exported as study notes.

`build/` is ignored by Git. PDF reading copies in `output/` are committed with
their sources, providing directly readable notes in the repository. The script
creates empty categories without adding non-PDF placeholders. Obsolete exported
PDFs are removed manually when a note is renamed or deleted.
IntelliJ `.idea/`, `*.iml`, `*.ipr`, and `*.iws` files are ignored.

## Alternatives considered

**One directory for PDFs and intermediate files:** retains the existing workflow,
but makes the reading collection harder to browse.

**Flattened build directories:** simpler paths, but documents in different
categories can share a filename and overwrite one another.

**Untracked reading PDFs:** avoids binary changes in Git, but requires readers
to install TeX and build before opening the notes. The reading collection is
kept in the repository; only the intermediate build tree is excluded.

## Consequences

Run `./build.sh` after changing notes, then commit sources and refreshed PDFs
together. A failed compilation stops the script before it updates reading copies.
The build needs Bash, latexmk, pdfLaTeX, and the shared style's TeX packages.
IDE settings remain local. Build policy is documented outside the teaching text.
