# Optional BOOX uploads after commits

English | [Polski](2026-10-11-boox-pdf-uploads.pl.md)

Status: implemented

## Problem

The user supplied a HAR of a PDF upload and requested automatic uploads of
changed PDFs, environment-based configuration, and fast skips when the device
or endpoint is unavailable. Device addresses and storage paths differ between
machines and must not be embedded in repository code.

## Decision

Add a `post-commit` hook alongside the existing validation hooks. Its uploader
reads committed regular PDF files under `BOOX_PDF_DIR` (default `output`),
and sends only blobs absent from the last successful upload record. First use
uploads the full selection. Git-local state is saved atomically after each
successful transfer and scoped to the endpoint, device directory, and PDF directory.

The supplied HAR establishes `dir`, `sender=web`, and `file` multipart fields,
and a successful JSON response with `code: 0` and `successful: true`.
Use curl with connection and transfer timeouts, no retries, no redirects,
and no proxy routing. Stop at the first unavailable or rejected upload; keep
pending files for the next commit or manual run. Upload failures cannot fail
a commit. Do not send unstaged bytes, delete remote files, or replay browser headers.

Use exported `BOOX_*` variables or ignored `.env.boox` literal assignments,
with exported values taking precedence. Commit a blank configuration example;
keep the HAR and device-specific settings outside version control. The captured
device uses HTTP, so allow HTTP and HTTPS according to the configured endpoint.

## Alternatives considered

**Upload before committing:** couples repository validation to device availability
and may send changes from a commit that subsequently fails. Post-commit uploads
use the accepted Git contents.

**Send only the latest commit diff:** misses PDFs from earlier offline commits.
Successful blob records preserve the pending selection without a separate queue.

**Send every PDF every time:** wastes transfer time. Successful blob comparisons
skip identical content, while first use initializes the device collection.

**Mirror subdirectories:** requires additional device directory-management APIs
absent from the supplied capture. Use one existing destination folder and reject
duplicate PDF filenames before transferring anything.

## Consequences

Enable shared hooks in each clone and configure the endpoint and device directory.
Python 3 and curl are required. Offline commits remain fast; an active upload
may take up to its configured transfer timeout. Pending files retry at the next
commit, including commits without PDF changes, or through the manual command
in the README. Changing destinations or removing local state starts a full sync.

Tests run the real hook in isolated Git repositories with simulated curl results,
covering incremental transfers, offline and partial failures, BOOX response checks,
configuration, filenames, and committed versus unstaged content. Live device
transfer was not verified in the network-restricted development environment.
