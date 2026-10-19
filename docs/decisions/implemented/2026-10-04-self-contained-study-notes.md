# Self-contained teaching text and visual explanations

English | [Polski](2026-10-04-self-contained-study-notes.pl.md)

Status: implemented

## Problem

Inline source tags, editorial corrections, repository organization, and execution
history interrupt studying. Lecture 2 also needs more visual explanations,
following the useful diagrams in the historical slides.

## Decision

At the user's request on 2026-10-04, keep the teaching narrative independent of
repository decisions and provenance. Sources and important editorial context may
appear in a self-contained final section, without citation markers or forward
pointers from the body. That section may point backwards to the relevant material.
Repository policy and detailed verification records stay in `docs/`.
Mathematical assumptions and qualifications remain beside their results.
Use editable TikZ diagrams where they explain geometry or physical models.

## Alternatives considered

**Inline source tags and editorial notes:** preserve immediate attribution but
interrupt the teaching narrative; replaced by final remarks.

**All provenance only in repository documentation:** keeps PDFs shorter but loses
useful context when a PDF is read independently. A final source section retains it.

**Copied slide images:** convenient but often have small labels and historical
formatting. Redrawn diagrams match the notes and remain editable.

## Consequences

Lecture notes, the existing MATLAB refresher, templates, and both writing guides
follow this boundary. Future source updates should revise end remarks and the
source inventory together. Drawings must match stated mathematical models and
remain readable in the compiled PDF.

The [2026-10-19 visual-cue decision](2026-10-19-confirmed-lecture-highlights.md)
narrowly supersedes the prohibition on inline source cues for selected lecture
boxes and their shared legend. The remaining provenance boundary still applies.
