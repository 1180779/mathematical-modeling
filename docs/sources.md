# Source inventory

English | [Polski](sources.pl.md)

## Current course materials 2026–27

The user supplied the following materials for the current course. The handwritten
notes explicitly date the lecture to 19 October 2026. Delivery dates for the slide
deck and sheet are not established; PDF metadata alone does not establish them.
Paths are relative to the repository root, and originals stay outside it.

| File | Pages | Local path |
| --- | --- | --- |
| `ProgMat_w1.pdf` | 39 | `../lectures-2026-27/ProgMat_w1.pdf` |
| `ProgMatc1.pdf` | 2 | `../execrices-2026-27/ProgMatc1.pdf` |
| `lecture_19_10_2026.pdf` | 10 | `../lecutures_notes/lecture_19_10_2026.pdf` |

The handwritten BOOX export was reviewed visually on all ten pages. Its content
is integrated into Chapter 4: cycling, symbolic perturbation, Bland's rule,
dual construction, weak/strong duality, paired tableaus and complementarity.
Three added worked subsections develop the numerical perturbation, paired
primal/dual solve, and final feasible-dual-start example. The candidate on pages
9–10 already has a complete treatment there. Final editorial remarks preserve
the RHS `8`/`3` discrepancy and explain arithmetic corrections; the course map
provides a page-by-page route. Exact rational checks passed for all eight new
pivot tableaus and certificates; no new MATLAB execution is claimed.


The lecture develops LP modeling through simplex and initialization. Chapters 01–03
and the new modeling-patterns supplement integrate its content. The sheet has 16
subproblems and two starts in 1(f); three exercise documents cover groups 1, 2–3 and
4–5. Duality and dual simplex are required by the sheet but are not developed in
these lecture slides. The [course map](course-map-2026-27.md) gives page/task destinations.
Historical enrichment remains available without a claim of current course coverage.

All current source pages were reviewed; source data, both task pages and image-based
initialization tableaus were also checked visually during the agent reviews.
Lecture p. 4 states four grinding machines; pp. 6–7 use three and 144 hours.
Chapter 1 parameterizes capacity and solves both readings. Page 34's row/column
indices and p. 35's unconditional Big M claims are qualified in Chapter 3.
Sheet 1(e)'s start violates its equality; 2(b)'s candidate is infeasible. These may
be deliberate tests and are preserved. As printed, 5(a) and 5(c) are unbounded
primal problems with infeasible duals; full certificates and Phase I failures
replace the impossible generic request for optimal dual solutions.

Hand explanations, exact certificates and diagrams are additions to the slides.
The [verification record](matlab-verification.md) distinguishes mathematical and
static checks from actual execution of the new MATLAB companions.

## Historical lectures

Thirteen PDFs are available beside this repository. Their folder labels them as
2020 lectures; lecture 1 contains a 2019/2020 schedule. Lectures 1–5 have been reviewed
for these notes. Current topical overlaps are recorded in the
[course map](course-map-2026-27.md); broader syllabus and lab alignment remain
unconfirmed. Paths below are
relative to the repository root. These originals remain outside this repository.

| File | Local path |
| --- | --- |
| `s4_w1.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w1.pdf` |
| `s4_w2.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w2.pdf` |
| `s4_w3.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w3.pdf` |
| `s4_w4.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w4.pdf` |
| `s4_w5.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w5.pdf` |
| `s4_w6.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w6.pdf` |
| `s4_w7.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w7.pdf` |
| `s4_w8.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w8.pdf` |
| `s4_w9.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w9.pdf` |
| `s4_w10.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w10.pdf` |
| `s4_w11.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w11.pdf` |
| `s4_w12.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w12.pdf` |
| `s4_w13.pdf` | `../Wykłady 2020-20261004T114043Z-1-001/Wykłady 2020/s4_w13.pdf` |

For each developed topic, cite the filename and page numbers, distinguish supplied
material from added explanations, and record any comparison with current classes.
A current slide deck, handwritten notes from 19 October and one exercise sheet
have now been supplied. The full current
syllabus and lab instructions remain unavailable.

## Developed notes and source qualifications

- Chapter 1: `s4_w1.pdf`, PDF pages 1–6; introduction and historical roadmap.
- Chapter 2: `s4_w2.pdf`, PDF pages 1–11, printed slides 1–44; LP models,
  standard form, geometry, and bases. Regression formulas and the cabinet sketch
  were also inspected visually.
- Chapter 3: `s4_w3.pdf`, PDF pages 1–12, printed slides 1–46; the complete
  simplex derivation, basic-solution candidates, both worked simplex examples,
  two-phase initialization with both supplied starts, and Big M. Slides 39–44
  were inspected visually to confirm variable domains and artificial columns.
  Added qualifications distinguish optimal points from certifying bases at
  degeneracy, require an actual move for alternative optima, explain zero-basic
  artificial cleanup, and show why finite penalties or augmented rays alone
  do not certify original infeasibility. The PDF creation metadata is 2019-10-17;
  this is not an established lecture delivery date.
- Chapter 4: `s4_w4.pdf`, PDF pages 1–12, printed slides 1–47 (47 closes the lecture).
  Complete mathematical content: degeneracy, all Beale cycling tableaus, perturbation,
  Bland's rule, complexity, dual construction, weak/strong duality, possible outcomes,
  complementary slackness, and the complete dual-simplex example. All pages were
  reviewed; dense tableaus and formulas were also inspected enlarged. Added derivations
  include the full Bland path, eight Klee–Minty vertices at p = 5, an RHS validity
  interval, and the candidate problem's entire optimal segment. Qualifications cover
  perturbation-start feasibility, pivot-rule-dependent complexity, the existence
  statement of strong duality, certifying bases, and dual degeneracy limitations.
  Creation metadata: 2019-10-27, not an established delivery date. All MATLAB assertions
  passed on R2026b.
- Chapter 5: `s4_w5.pdf`, PDF pp. 1–10, printed slides 1–38 (38 closes the lecture).
  Full coverage: single RHS/cost ranges, vector changes, variable and constraint
  additions/deletions, and Lagrange multipliers. All pages were reviewed;
  sensitivity formulas and the final certificate were also inspected enlarged.
  Useful constraint-removal drawings were redrawn in TikZ, with added basic-value,
  indicator, value-function, data-region, and normal-cone diagrams.
  Open questions were completed with hand solutions, full tableaus, proofs, and MATLAB.
  Qualifications cover joint changes, degeneracy, RHS column signs, artificial
  cleanup, and constraint qualifications for nonlinear KKT necessity.
  Metadata creation: 2019-11-03; not an established delivery date.
  All MATLAB assertions passed in the user's normal terminal on R2026b.
- The notes distinguish added hand proofs and derivations from slide content.
  Qualifications cover revenue versus profit, exact versus minimum demand,
  integer versus continuous cutting counts, strict convex combinations,
  recession directions for closed convex sets, pointed polyhedral representation,
  and the hypotheses of the optimal-vertex theorem.
- The 2 m cabinet solution assumes three 0.8 m members and two 0.3 m members per
  cabinet, zero kerf, and no joint or thickness allowances; these assumptions
  go beyond the sketch's explicit manufacturing information.

## Supplementary sources outside the repository

### Downloading complete lecture sets

`scripts/download_lectures.py` reads the official
[MIT OCW 6.251J, Fall 2009 lecture index](https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/pages/lecture-notes/)
and [UCLA ECE236B course page](https://www.seas.ucla.edu/~vandenbe/ee236b/).
Checked on 2026-10-11: these list 25 MIT lectures, 11 UCLA Winter 2026 chapters,
and a Winter 2023 numerical-linear-algebra supplement. The script downloads all
of them into sibling `../sources/mit/` and `../sources/ucla/` and preserves the
intended filenames below. See the [README](../README.md#supplementary-lecture-pdfs)
for commands, destination settings, and retry behavior. The other MIT courses
cited in the foundations table below are separate reference collections.

The downloader's discovery, PDF-marker checks, file preservation, and failure
handling passed offline fixture tests. Live retrieval in this workspace is
unverified: shell DNS resolution remains unavailable. The existing Lecture 10
file was confirmed readable with `pdfinfo`; the other lecture files were absent
when inspected on 2026-10-11. Running the script does not update this inventory
automatically or establish current course alignment.

[MIT OCW 15.081J/6.251J, Lecture 10 (Fall 2009)](https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/ab890d20b071105239fe0b9bcf599f57_MIT6_251JF09_lec10.pdf),
PDF pages 4 and 6, was consulted through the web tool to cross-check the recession
cone and vertex–ray representation hypotheses. It supplements the source lecture;
it is not evidence of current course coverage.

Intended local path from this repository:
`../sources/mit/mit-6-251j-2009-lecture-10-polyhedral-representation.pdf`.
**Present locally:** a readable eight-page PDF was confirmed on 2026-10-11.
The earlier shell download attempt failed at DNS resolution on 2026-10-04.
The external `../sources/README.md` records the official URL and retry command.

Additional simplex cross-checks for Lecture 3:

- [MIT OCW 15.081J/6.251J, Lecture 5 (Fall 2009)](https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/4fdf1a06497288c24593f7eedef7576e_MIT6_251JF09_lec05.pdf),
  PDF p. 2 and pp. 5–6: the nondegeneracy qualification of the reduced-cost test,
  degenerate steps, and the anti-cycling rule.
- [Lecture 7](https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/12b1c7e885991696c294953b2497739c_MIT6_251JF09_lec07.pdf),
  PDF pp. 2–4: artificial-variable cleanup, redundant rows, and Phase II initialization.

Both were consulted through the web tool. Intended external files are
`../sources/mit/mit-6-251j-2009-lecture-05-simplex.pdf` and
`../sources/mit/mit-6-251j-2009-lecture-07-simplex-initialization.pdf`.
**Not downloaded:** the Lecture 5 download attempt on 2026-10-04 failed at shell
DNS resolution; neither file is stored locally. The external paired README
records both official URLs and retry commands. These sources do not establish
current course coverage.

Additional Lecture 4 cross-checks (titles follow the PDF interiors):

- [MIT OCW Lecture 6: The Simplex Method II](https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/2ef2f1dd7045b5f29e5faea299fb0798_MIT6_251JF09_lec06.pdf),
  PDF pp. 5–8: symbolic perturbation and anti-cycling rules.
- [MIT OCW Lecture 8: Duality Theory I](https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/496d9a385fd1d7e1aa82837d91adb23e_MIT6_251JF09_lec08.pdf),
  PDF pp. 2–5: dual signs, the strong-duality basis proof, and complementarity.
- [MIT OCW Lecture 9: Duality Theory II](https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/b93d1665d7a8f05ea626b8f04c7ad66c_MIT6_251JF09_lec09.pdf),
  PDF pp. 4–5: dual-simplex invariants and ratio test.

These sources were read through the web tool. **Not downloaded:** all three shell
download attempts on 2026-10-04 failed at DNS resolution. Intended files:

- `../sources/mit/mit-6-251j-2009-lecture-06-simplex-anticycling.pdf`
- `../sources/mit/mit-6-251j-2009-lecture-08-duality.pdf`
- `../sources/mit/mit-6-251j-2009-lecture-09-dual-simplex.pdf`

The external `../sources/README.md` and `../sources/README.pl.md` record URLs and
retry commands. These materials do not establish current course coverage.

Additional Lecture 5 cross-checks:

- [MIT OCW Lecture 12: Sensitivity analysis](https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/370982a2d3b22e090aa7a8d573bb5604_MIT6_251JF09_lec12.pdf),
  PDF pp. 2–6: local basis tests, parameter changes, new columns and rows.
- [L. Vandenberghe, UCLA ECE236B, Winter 2026: Duality](https://www.seas.ucla.edu/~vandenbe/ee236b/lectures/duality.pdf),
  sections on Slater's qualification, optimality conditions, and sensitivity.

Read through the web tool. **Not downloaded:** both shell attempts on 2026-10-04
failed at DNS resolution. Intended external files:

- `../sources/mit/mit-6-251j-2009-lecture-12-sensitivity.pdf`
- `../sources/ucla/ece236b-2026-duality.pdf`

The paired external READMEs record the URLs and retry commands.
These supplementary references do not establish current course coverage.

## Additional foundations consulted on 2026-10-11

The [holistic notes review](notes-review.md) adds seven explanatory TikZ figures
and focused mathematical bridges. These supplementary references were read
online through the web tool; no new local PDF copies were created. They do not
establish current course coverage. Examples and diagrams added during the review
are original derivations, distinct from supplied exercise data.

| Primary reference | Material checked |
| --- | --- |
| [Boyd and Vandenberghe, *Convex Optimization*](https://web.stanford.edu/~boyd/cvxbook/) | Sections 3.1 and 4.2: convexity and local/global optimality; 5.2.3 and 5.5.3: regularity and KKT; 11.2: barriers and the central path |
| [MIT OCW 6.251J, Lecture 25: *Exact Methods for Discrete Optimization*](https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/d0be6aa7393f489a419add7cec874a4c_MIT6_251JF09_lec25.pdf) | Sections 2–3: cuts, LP relaxation bounds and branch and bound; catalogue title: Discrete optimization II |
| [MIT OCW 15.053, *Networks 2: Network flows*](https://ocw.mit.edu/courses/15-053-optimization-methods-in-management-science-spring-2013/687225c151d8cc8254dcb8b07e5f9ce2_MIT15_053S13_lec16.pdf) | PDF pp. 30–33: network integrality and its data/structure qualifications |
| [MIT OCW 18.310, *Network flows*](https://ocw.mit.edu/courses/18-310-principles-of-discrete-applied-mathematics-fall-2013/3235079dd74eb61e56f41ea2bb595d64_MIT18_310F13_Ch9.pdf) | PDF pp. 2–3: max-flow/min-cut theorem and the cut-capacity bound |
| [MIT OCW 6.854J, *Linear programming notes*](https://ocw.mit.edu/courses/6-854j-advanced-algorithms-fall-2008/908fe54d659623efadda2d033b895caf_notes_lp.pdf) | PDF p. 12, Theorem 6: Farkas' alternative for nonnegative equality-system feasibility |

The previously inventoried MIT OCW Lecture 6, *The Simplex Method II*, was also
consulted at PDF pp. 2–3 for revised simplex, sparse representation and periodic
recomputation. Its earlier external-download status is unchanged. The revised
simplex formulas use these notes' maximization convention consistently.

## MATLAB refresher documentation

Refresher 1 uses original hand examples and the official MathWorks references
below for array construction, indexing, operators, linear solves, and figure export.
The production equations are from `s4_w2.pdf`, slides 7–9.

- [Matrices and Arrays](https://www.mathworks.com/help/matlab/learn_matlab/matrices-and-arrays.html)
- [Array Indexing](https://www.mathworks.com/help/matlab/math/array-indexing.html)
- [Array vs. Matrix Operations](https://www.mathworks.com/help/matlab/matlab_prog/array-vs-matrix-operations.html)
- [mldivide](https://www.mathworks.com/help/matlab/ref/double.mldivide.html)
- [exportgraphics](https://www.mathworks.com/help/matlab/ref/exportgraphics.html)

## AZ style provenance

The style was adapted from the preambles and organization of `Lecture_5May.tex`
and `egzamin_AZ.tex` in:

`/home/rdkgsk/Documents/Studies/masters/sem1/az/AZ_lectures`

No separate template, style package, or writing guide was found in the supplied
checkout, including its tracked file list. The new style extracts their common
layout and theorem conventions, uses English labels, and adds MATLAB listings.
No AZ subject content is copied into these notes.

The lecture-highlight boxes added on 2026-10-19 adapt the selected, breakable
`obowiazkowybox` treatment from a separate AZ checkout:
`/home/rdkgsk/Documents/Studies/masters/sem1/az/aa-lectures-2025-2026/preamble.tex`.
Its README distinguishes normal, highlighted and exam editions. Only the visual
box convention is reused here: cream means confirmed current lecture content,
without adopting AZ's mandatory-exam meaning or proof filtering.
