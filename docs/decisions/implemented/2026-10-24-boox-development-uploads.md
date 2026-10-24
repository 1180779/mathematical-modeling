# BOOX uploads during note development

English | [Polski](2026-10-24-boox-development-uploads.pl.md)

Status: implemented

## Problem

The uploader reads Git blobs from `HEAD`, so rebuilding notes does not make
uncommitted PDFs eligible for upload. The user needs to read drafts on BOOX
while iterating on the notes.

## Decision

Add explicit `--working-tree` selection of local regular PDFs, including new
and ignored files under `BOOX_PDF_DIR`. Skip symlinks and snapshot contents
before uploading. `make upload-boox-dev` builds first, refreshes `output/`,
then uploads the current files. A failed build prevents this upload.
The flag can also select existing PDFs under `build/` without exporting them.

Retain committed selection for the hook and `make upload-boox`. Share Git blob
content identifiers and success state between modes. Committing an unchanged
uploaded draft does not resend it; uploading from `HEAD` after a draft restores
the committed bytes on the device. Preserve relative directories and failure
handling from the [directory-layout decision](2026-10-19-boox-directory-layout.md).
This extends its committed-only selection rule for explicit development uploads.

## Alternatives

- Requiring a commit for every draft interrupts note development.
- Changing the commit hook to send local files could upload unrelated edits.
- Separate state for each mode can falsely skip a transfer after the other mode
  overwrites the device copy.

## Consequences

Development transfers require no staging or commit. Direct `build/` selection
includes every PDF there, including template previews if present. Device folders
must exist. Integration tests replace curl, covering drafts, new and ignored
PDFs, symlinks, retries, and switching between local and committed content.
They do not establish live device transfer success.
