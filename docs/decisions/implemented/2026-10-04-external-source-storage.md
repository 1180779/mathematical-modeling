# Store supplementary PDFs outside the study repository

English | [Polski](2026-10-04-external-source-storage.pl.md)

Status: implemented

## Problem

Supplementary references help clarify historical lecture material, but downloaded
PDFs would add unrelated bulk to the notes repository. The user requested storage
under the parent subject directory on 2026-10-04.

## Decision

Supplementary PDFs belong in `../sources/`, grouped by provider (initially `mit/`).
Original historical lectures retain their existing location. The repository's
paired source inventory records provenance, intended paths, actual download status,
and how each reference was used. The external `../sources/README.md` records
retrieval details. This structure is in place; the first MIT PDF download remains
pending because shell DNS resolution failed.

## Alternatives considered

**PDFs inside the notes repository:** declined at the user's request to keep
reference materials outside it.

**Download staging in `/tmp`:** attempted when the parent directory was outside
the writable workspace; the user then expanded the workspace to the subject
folder, allowing durable source-directory setup. Temporary staging is no longer
the selected location.

## Consequences

The Git repository stays focused on authored notes and scripts. The sibling
source tree must be copied separately when moving the project. Official links and
explicit download status prevent a missing local file from appearing available.
Consulting a supplement does not confirm the current university syllabus.
