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
  ([PDF](output/lectures/01-optimization-modeling.pdf)): variables, constraints, objectives,
  classifications, and the historical MATLAB refresher scope.

- [Lecture 2: Linear programming—models and geometry](notes/lectures/02-linear-programming.tex)
  ([PDF](output/lectures/02-linear-programming.pdf)): modeling examples, standard form,
  recession directions, optimal vertices, and basic feasible solutions.

PDF links point to the committed reading copies in `output/`.

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
| `build/` | Compilation PDFs and intermediate files, grouped like `notes/`; ignored by Git |
| `output/` | Committed PDF copies, grouped like `notes/`; PDFs only |
| `build.sh` | Build all study notes and refresh their PDF copies |

Use matching topic names for a worked exercise and its MATLAB script; link the
script from the solution. Keep one executable implementation per task.

## Build notes

Install Bash, a TeX distribution with pdfLaTeX, latexmk, and the packages listed
in `templates/modeling-notes.sty`. From the repository root, run:

```sh
./build.sh
```

The script discovers every `.tex` document under `notes/`. It compiles into
matching directories under ignored `build/`, then copies only PDFs to `output/`
after all documents build successfully. For example:

```text
notes/lectures/02-linear-programming.tex
  -> build/lectures/02-linear-programming.pdf (plus intermediate files)
  -> output/lectures/02-linear-programming.pdf
```

`output/` also has `exercises/`, `labs/`, and `matlab-review/` categories.
Empty directories are created by the script; they contain no placeholder files.
Existing PDF copies are overwritten after a successful build. If you rename or
remove a note, remove its obsolete PDF from `output/` too.
The script can also be invoked by its absolute path from another directory.
Commit updated PDFs alongside the corresponding note changes.
IntelliJ's `.idea/`, `*.iml`, `*.ipr`, and `*.iws` files are ignored.

To preview an empty template without exporting it to `output/`:

```sh
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build/templates templates/lecture.tex
latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir=build/templates templates/exercise.tex
```

Copy a template into the appropriate `notes/` directory before developing it;
retain its repository-root paths and run `./build.sh`.

## MATLAB refresher

[Refresher 1: Arrays, indexing, and linear systems](notes/matlab-review/01-arrays-and-linear-systems.tex)
([PDF](output/matlab-review/01-arrays-and-linear-systems.pdf)) contains hand calculations and a
matching script covering dimensions, indexing, operators, backslash, function
handles, loops, and plotting.

```matlab
run('matlab/review/arrays_and_linear_systems.m')
```

The plot is written to ignored `matlab/output/`. Refresh the study PDFs with:

```sh
./build.sh
```

## Lecture 2 MATLAB checks

```matlab
run('matlab/exercises/lecture_02_checks.m')
```

Run from the repository root. The script checks the hand examples using base
MATLAB; no Optimization Toolbox is required. Both scripts passed, including plot export; see the [verification record](docs/matlab-verification.md).

## Study workflow

Compare historical material with the current lecture or task before treating it
as current course coverage. Write the mathematical explanation and hand solution,
then check the same inputs in MATLAB. Record assumptions, units, solver settings,
and discrepancies. Add Polish terms to the glossary as they occur.

Update both language versions of guides and decisions in the same change.
Record substantial decisions, including alternatives and consequences; Git commits
record routine edits. Commit small, coherent changes with descriptive messages.
