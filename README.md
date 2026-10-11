# Mathematical modeling

English | [Polski](README.pl.md)

Personal study repository for mathematical modeling: lecture notes, exercises
with hand and MATLAB solutions, MATLAB revision, and lab work.
Conceptual chapters preserve the explanatory depth of the historical notes and
integrate the supplied 2026–27 lecture 1 and task sheet 1. Chapter numbers are
independent of current lecture numbers; future course alignment remains unknown.

## Start here

- [Current course map](docs/course-map-2026-27.md): lecture pages, task IDs, prerequisites and hand outcomes.
- [Notes review and further study](docs/notes-review.md): visual explanations, expanded foundations and remaining study directions.
- [Writing guide](docs/writing-guide.md): structure, notation, sources, and verification.
- [Language policy](docs/language-policy.md): English notes with Polish terminology.
- [Polish–English glossary](docs/glossary.md): shared vocabulary.
- [Source inventory](docs/sources.md): current materials, historical references and template provenance.
- [Decision log](docs/decisions/README.md): rationale and pending proposals.

## Conceptual study chapters

- [Chapter 1: Modeling optimization problems](notes/lectures/01-optimization-modeling.tex)
  ([PDF](output/lectures/01-optimization-modeling.pdf)): variables, constraints, objectives,
  classifications, a five-product model with two capacity readings and exact hand certificates.

- [Chapter 2: Linear programming—models and geometry](notes/lectures/02-linear-programming.tex)
  ([PDF](output/lectures/02-linear-programming.pdf)): modeling examples, standard form,
  recession directions, optimal vertices, and basic feasible solutions.

- [Modeling patterns: Blending, networks, objectives and goals](notes/lectures/02a-linear-modeling-patterns.tex)
  ([PDF](output/lectures/02a-linear-modeling-patterns.pdf)): complete blending,
  restricted transportation and storage examples, min-cost flow, objective choices
  and soft constraints, with derivations and hand certificates.

- [Chapter 3: The simplex method](notes/lectures/03-simplex-method.tex)
  ([PDF](output/lectures/03-simplex-method.pdf)): canonical equations, reduced costs,
  full simplex tableaus, degeneracy, feasible rays, two-phase initialization, and Big M.

- [Chapter 4: Degeneracy, duality, and dual simplex](notes/lectures/04-degeneracy-and-duality.tex)
  ([PDF](output/lectures/04-degeneracy-and-duality.pdf)): complete cycling example,
  Bland and lexicographic perturbation, complexity, dual construction,
  optimality certificates, complementarity, and a dual-simplex solve.

- [Chapter 5: Sensitivity analysis and Lagrange multipliers](notes/lectures/05-sensitivity-and-lagrange-multipliers.tex)
  ([PDF](output/lectures/05-sensitivity-and-lagrange-multipliers.pdf)): data ranges,
  shadow prices, structural reoptimization, complete tableaus, and KKT certificates.

PDF links point to the committed reading copies in `output/`.

## Current sheet 1 and modeling checks

- [Group 1: Primal simplex](notes/exercises/01-primal-simplex.tex)
  ([PDF](output/exercises/01-primal-simplex.pdf)): all six problems, both 1(f)
  starts, complete tableaus, optimal sets and growth rays.
- [Groups 2–3: Complementarity and two-phase methods](notes/exercises/01-complementarity-and-two-phase.tex)
  ([PDF](output/exercises/01-complementarity-and-two-phase.pdf)): feasibility-first
  candidate checks, mixed-sign duals and complete Phase I/II paths.
- [Groups 4–5: Dual simplex and primal recovery](notes/exercises/01-dual-simplex-and-recovery.tex)
  ([PDF](output/exercises/01-dual-simplex-and-recovery.pdf)): dual pivots,
  dual solves, primal recovery and the infeasible duals of printed 5(a)/5(c).

Original Polish statements and printed data are preserved; explanations are in
English. The current lecture's conflicting grinding capacities are treated
explicitly. Inadmissible supplied candidates are checked rather than repaired.

The four new base-MATLAB companions can be run from the repository root:

```matlab
run('matlab/exercises/modeling_patterns_checks.m')
run('matlab/exercises/sheet_01_primal_simplex.m')
run('matlab/exercises/sheet_01_complementarity_and_two_phase.m')
run('matlab/exercises/sheet_01_dual_simplex_and_recovery.m')
```

Exact rational checks, MATLAB static analysis and all four scripts' assertions
passed. The user supplied successful output and confirmed MATLAB
26.2.0.3386108 (R2026b); the primal-simplex script reported a largest tableau/basis
discrepancy of `7.11e-15` against absolute tolerance `1e-10`.
See the [verification record](docs/matlab-verification.md).
The diet example and its check were revised after that run. Their new result
passes exact arithmetic and static analysis; MATLAB execution of this revision
is pending.

## Layout

| Path | Purpose |
| --- | --- |
| `notes/lectures/` | English conceptual chapters and modeling supplement in LaTeX |
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

Install Bash, Python 3, a TeX distribution with pdfLaTeX, latexmk, and the packages listed
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
The build also refreshes `docs/pdf-build.json`, recording SHA-256 hashes of
PDFs and build inputs. Commit that record and the PDFs alongside note changes.
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

## Chapter 2 MATLAB checks

```matlab
run('matlab/exercises/lecture_02_checks.m')
```

Run from the repository root. The script checks the hand examples using base
MATLAB; no Optimization Toolbox is required. Both scripts passed, including plot export; see the [verification record](docs/matlab-verification.md).

## Chapter 3 MATLAB checks

```matlab
run('matlab/exercises/lecture_03_checks.m')
```

Run from the repository root. The base MATLAB script checks both simplex examples,
both two-phase starts, and the added counterexamples. All assertions passed in the
user's normal terminal. Static analysis and independent exact rational calculations
also passed; see the [verification record](docs/matlab-verification.md).

## Chapter 4 MATLAB checks

```matlab
run('matlab/exercises/lecture_04_checks.m')
```

Run from the repository root. The base MATLAB script checks cycling, both
anti-cycling paths, the Klee–Minty example, dual certificates, complementarity,
RHS changes, and dual simplex. All assertions passed in the user's normal terminal
on R2026b. Static analysis and independent exact rational calculations also passed;
see the [verification record](docs/matlab-verification.md).

## Chapter 5 MATLAB checks

```matlab
run('matlab/exercises/lecture_05_checks.m')
```

Run from the repository root. The base MATLAB script checks sensitivity ranges,
joint changes, variable and constraint additions/deletions, selected pivots,
and the KKT certificate. All assertions passed in the user’s normal terminal
on R2026b. Static analysis and independent exact rational calculations also passed;
see the [verification record](docs/matlab-verification.md).

## Git checks

Enable the repository's shared hooks in each clone (Python 3 is required):

```sh
git config --local core.hooksPath .githooks
```

The `commit-msg` hook limits every message line to 72 Unicode characters and
requires a blank line between the title and description. A title-only message
is valid. Git editor comments are excluded from the check.

The `pre-commit` hook checks staged contents for:

- English–Polish pair completeness, section hashes, heading depths, and identical code fences.
- PDF hashes, recorded build inputs, and available build copies of changed PDFs.
- LaTeX/TikZ formatting with the staged `.latexindent.yaml` configuration.

Run the working-tree checks directly:

```sh
python3 scripts/check_translations.py
python3 scripts/check_output.py
python3 scripts/format_tex.py --check
```

After editing paired documents, review both languages, then record the specific
reviewed pair and stage all three files:

```sh
python3 scripts/check_translations.py --write README.md
```

Each pair has a sibling `.i18n.json` file with English and Polish section hashes,
inspired by [DeepSeek's pairing convention](https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/i18n/README.md).
Hashes detect edits since review; they cannot establish translation quality.
The PDF check detects modified inputs or exported files; a fresh clone can pass
using the committed record without having an intermediate `build/` tree.

### BOOX uploads

The optional `post-commit` hook uploads new or changed **committed** PDFs to a
BOOX device using Python 3 and curl. Enable the shared hooks as above, then:

```sh
cp .env.boox.example .env.boox
```

Edit the ignored `.env.boox` file: set `BOOX_UPLOAD_URL` to the complete upload
endpoint shown in your device's upload request, and `BOOX_REMOTE_DIR` to the
absolute path of an existing folder **on the device**. The request matches the
supplied HAR: multipart fields `dir`, `sender=web`, and `file`. Configuration is
literal `KEY=value` data; quote values with spaces. Shell commands and variable
expansion are not evaluated. Exported environment variables override the file;
export an empty `BOOX_UPLOAD_URL` to disable uploads temporarily.

| Variable | Default / purpose |
| --- | --- |
| `BOOX_UPLOAD_URL` | Required; complete HTTP(S) upload endpoint |
| `BOOX_REMOTE_DIR` | Required; existing destination directory on BOOX |
| `BOOX_PDF_DIR` | `output`; repository-relative directory containing PDFs |
| `BOOX_CONNECT_TIMEOUT` | `1`; maximum connection time in seconds |
| `BOOX_UPLOAD_TIMEOUT` | `15`; maximum total time per upload in seconds |
| `BOOX_ENV_FILE` | `.env.boox`; alternate configuration file, set in the environment |
| `BOOX_STATE_FILE` | Git-local `boox-upload.json`; optional alternate state path |

The first configured run uploads all PDFs under `BOOX_PDF_DIR` in `HEAD`.
Later runs compare Git blob hashes with the last successful uploads. By default,
state stays in Git metadata; keep any custom state path outside version control.
Changing the endpoint, destination, or PDF directory starts a fresh sync.
PDFs go into one destination folder using
their original filenames; duplicate filenames are rejected before uploading.
Remote files are not deleted when PDFs disappear from Git.

An unavailable host or endpoint stops the upload batch after the first failure;
there are no immediate retries and the commit still succeeds. A transfer is
recorded only after an HTTP success with BOOX JSON `successful: true` and
`code: 0`. Each completed upload is saved separately, so pending PDFs retry on
the next commit. To retry manually, or to run the tests without a device:

```sh
python3 scripts/upload_boox.py
python3 -m unittest discover -s scripts/tests -v
```

## LaTeX and TikZ formatting

Use the shared latexindent settings for `.tex`, `.sty`, and `.tikz` files:

```sh
python3 scripts/format_tex.py --write
./build.sh
```

The current TikZ figures are inline in lecture `.tex` files and are included in
the check. Formatting preserves line breaks and verbatim MATLAB listings.
Formatter scratch files stay outside source directories.

The project `.nvim.lua` configures Conform with the same formatter settings.
In Neovim, from the repository root:

```vim
:luafile .nvim.lua
```

Then use your existing `<leader>f` formatting mapping. Neovim's optional `exrc`
setting can load the project configuration automatically after you trust it.
`.editorconfig` supplies matching two-space indentation for TeX/TikZ buffers.
Your global Neovim configuration is unchanged.


## Study workflow

Use the course map to separate supplied lecture coverage, task requirements
and historical enrichment; update it as new materials arrive. Write the mathematical explanation and hand solution,
then check the same inputs in MATLAB. Record assumptions, units, solver settings,
and discrepancies. Add Polish terms to the glossary as they occur.

Update both language versions of guides and decisions in the same change.
Record substantial decisions, including alternatives and consequences; Git commits
record routine edits. Commit small, coherent changes with descriptive messages.
