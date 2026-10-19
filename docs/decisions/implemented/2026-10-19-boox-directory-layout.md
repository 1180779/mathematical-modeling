# Preserve output directories in BOOX uploads

English | [Polski](2026-10-19-boox-directory-layout.pl.md)

Status: implemented

## Problem

The user requested the same directory separation on BOOX as in `output/`.
The earlier uploader flattened filenames and rejected duplicate basenames.

## Decision

Preserve each committed PDF's parent path relative to `BOOX_PDF_DIR` beneath
`BOOX_REMOTE_DIR`. A root-level PDF uses the device base directory. Duplicate
basenames in different folders are allowed. Continue uploading committed blobs
only, recording success after each file, and stopping after the first rejection.
Never fall back to the base directory on a subdirectory failure.

Version the destination state with `relative-directories-v1` so earlier flat
upload records cannot suppress the initial upload into the correct folders.
Keep existing flat copies; do not delete remote files.

This supersedes the flat-destination choice in the
[original upload decision](2026-10-11-boox-pdf-uploads.md). The captured API
establishes upload fields but no directory-creation operation. Matching device
subdirectories must already exist; document this setup requirement rather than
inventing an endpoint or claiming automatic directory creation.

## Alternatives

- Retaining one destination folder loses the requested separation.
- Prefixing filenames with directory names does not create actual subdirectories.
- Guessing a directory-creation endpoint lacks evidence from the supplied API capture.

## Verification

The integration tests use real Git repositories and the actual hook, with curl's
network boundary replaced. They check relative and nested destinations, duplicate
basenames, root-level files, migration from flat state, incremental transfers,
partial success and rejection without flattening. Existing offline and
committed-content checks remain. Live device transfers are not established by
these tests.
