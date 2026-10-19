# Visual cues for confirmed current lecture content

English | [Polski](2026-10-19-confirmed-lecture-highlights.pl.md)

Status: implemented

## Problem

The user requested visible identification of material definitely present in the
lecture, following the highlighted AZ notes, and separate colors connecting
primal and dual matrix cells. The earlier self-contained-teaching decision kept
all provenance outside the teaching text and did not provide a visual exception.

## Decision

At the user's request on 2026-10-19, permit selected cream `lecturecore` boxes
and the shared `\lecturelegend` in lecture documents. This narrowly supersedes
the no-inline-source-cue part of the
[self-contained teaching decision](2026-10-04-self-contained-study-notes.md).
Keep dates, source pages, discrepancies and verification in final remarks or docs.

Highlight only statements, models and formulas confirmed in supplied current
lecture sources. Do not highlight surrounding added proofs or hand solutions by
association. Coverage is not an examination requirement. Unmarked content can
still explain a lecture topic; absence of highlighting does not establish absence
from class. Chapter 5's alignment remains unknown.

Reuse the breakable cream-box convention from AZ's
`aa-lectures-2025-2026/preamble.tex`, with a distinct meaning from its exam scope.
Use a separate, explicitly labeled cell palette for the mathematical roles in
paired primal–dual tableaus. Keep all content readable without color.

## Alternatives

- Coloring whole chapters or sections would incorrectly include added derivations.
- Coloring only headings would not identify exactly which statements are confirmed.
- Keeping provenance only in end remarks would not meet the requested visual cue.

## Consequences and verification

There are 23 selected blocks in Chapters 1–4 and Modeling patterns, each with a
shared legend. Existing proofs and historical extensions are retained. Formatting,
translation pairing and PDF hashes are checked after rebuilding all notes; selected
rendered pages are inspected for box breaks and colored-table readability.
