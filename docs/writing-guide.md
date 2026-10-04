# Writing guide

English | [Polski](writing-guide.pl.md)

## Style and templates

The shared style is adapted from `Lecture_5May.tex` and `egzamin_AZ.tex` in the
previous semester's AZ repository. It keeps 11-point A4 articles, 2.4 cm margins,
Latin Modern fonts, AMS mathematics, theorem numbering within sections, and blue
hyperlinks. Environment names and labels are English. Separate template or guide
files were not found in that checkout; this guide documents the extracted style.
See the [source inventory](sources.md) for provenance.

Copy `templates/lecture.tex` or `templates/exercise.tex` into `notes/` as needed.
Use descriptive ASCII filenames such as `01-topic.tex` and stable label prefixes
`sec:`, `def:`, `thm:`, `eq:`, and `fig:`. Build from the repository root as
shown in the [README](../README.md). Keep generated output in `build/`.

## Lecture notes

Identify the source, date if known, and whether alignment with the current course
is confirmed. Define the problem, symbols, domains, assumptions, and units before
using them. Explain the modeling idea, derive equations step by step, state the
conditions for each result, and distinguish proofs from intuition. Add worked
examples when material is developed, followed by limitations and common mistakes.
Do not turn unverified historical coverage into claims about the current syllabus.

## Exercises and MATLAB

Preserve and attribute the task statement. Present assumptions and a hand solution
before linking `matlab/exercises/<matching-topic>.m`. Use the same inputs and
parameters in both solutions. Record expected results, absolute or relative error,
units, solver settings, tolerances, and reasons for discrepancies when applicable.
State whether checks were actually run, including the MATLAB release when known.
Do not present planned scripts or invented output as verification.

Keep numerical approximation separate from exact mathematical results. Distinguish
model validity from numerical solver success. MATLAB revision and labs follow the
same rules and use their dedicated notes and code directories.

## Language and decisions

Follow the [language policy](language-policy.md). Add new terminology to the
[glossary](glossary.md). Change both languages of paired repository documents
together. For lasting choices, record rationale and genuine alternatives in the
[decision log](decisions/README.md); routine corrections belong in Git history.
