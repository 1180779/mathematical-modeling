# Mathematical modeling

English | [Polski](README.pl.md)

Personal study repository for mathematical modeling: lecture notes, exercises
with hand and MATLAB solutions, MATLAB revision, and lab work.
Lecture notes are developed from the historical sources, with current course alignment unconfirmed.

## Start here

- [Writing guide](docs/writing-guide.md): structure, notation, sources, and verification.
- [Language policy](docs/language-policy.md): English notes with Polish terminology.
- [Polish–English glossary](docs/glossary.md): shared vocabulary.
- [Source inventory](docs/sources.md): historical lectures and template provenance.
- [Decision log](docs/decisions/README.md): rationale and pending proposals.

## Lecture notes

- [Lecture 1: Modeling optimization problems](notes/lectures/01-optimization-modeling.tex)
  ([PDF](build/01-optimization-modeling.pdf)): variables, constraints, objectives,
  classifications, and the historical MATLAB refresher scope.

- [Lecture 2: Linear programming—models and geometry](notes/lectures/02-linear-programming.tex)
  ([PDF](build/02-linear-programming.pdf)): modeling examples, standard form,
  recession directions, optimal vertices, and basic feasible solutions.

PDF links refer to local build output, which is not committed.

## Layout

| Path | Purpose |
| --- | --- |
| `notes/lectures/` | English lecture notes in LaTeX |
| `notes/exercises/` | Exercise statements, hand solutions, and MATLAB comparisons |
| `notes/matlab-review/` | Short MATLAB refresher notes |
| `notes/labs/` | Lab explanations and results |
| `matlab/review/` | Refresher scripts |
| `matlab/exercises/` | Scripts linked to worked exercises |
| `matlab/labs/` | Lab scripts and functions |
| `templates/` | Shared LaTeX style and starter documents |
| `docs/` | Bilingual guides, decisions, source inventory, and glossary |
| `build/` | Generated PDFs and auxiliary files; ignored by Git |

Use matching topic names for a worked exercise and its MATLAB script; link the
script from the solution. Keep one executable implementation per task.

## Build a template

Install a TeX distribution with pdfLaTeX, latexmk, and the packages listed in
`templates/modeling-notes.sty`. From the repository root:

```sh
mkdir -p build
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build templates/lecture.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build templates/exercise.tex
```

Copy a template into the appropriate notes directory. Retain its repository-root
paths and build it from the repository root using the same command with the new
file path. MATLAB work will be checked in MATLAB when scripts are added; the
Lecture 2 check script has not yet been run in MATLAB.

Build both lecture PDFs from the repository root:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build notes/lectures/01-optimization-modeling.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build notes/lectures/02-linear-programming.tex
```

## Lecture 2 MATLAB checks

```matlab
run('matlab/exercises/lecture-02-checks.m')
```

Run from the repository root. The script checks the hand examples using base
MATLAB; no Optimization Toolbox is required. MATLAB execution remains unverified.

## Study workflow

Compare historical material with the current lecture or task before treating it
as current course coverage. Write the mathematical explanation and hand solution,
then check the same inputs in MATLAB. Record assumptions, units, solver settings,
and discrepancies. Add Polish terms to the glossary as they occur.

Update both language versions of guides and decisions in the same change.
Record substantial decisions, including alternatives and consequences; Git commits
record routine edits. Commit small, coherent changes with descriptive messages.
