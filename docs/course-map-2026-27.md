# Course map 2026–27

English | [Polski](course-map-2026-27.pl.md)

## Scope and reading routes

This map covers the supplied `ProgMat_w1.pdf`, `ProgMatc1.pdf`, and handwritten
`lecture_19_10_2026.pdf` (19 October 2026). Source paths,
provenance and discrepancies are in the [source inventory](sources.md). Page
numbers mean PDF pages. Chapter numbers describe the notes' conceptual sequence;
they are independent of current lecture and sheet numbers. All topics and tasks
below have developed explanations or hand solutions. Future course coverage,
assessment emphasis and labs remain unknown. The handwriting establishes the
19 October lecture date; delivery dates for the slide deck remain unknown.

For modeling, read [Chapter 1](../output/lectures/01-optimization-modeling.pdf),
the modeling sections of [Chapter 2](../output/lectures/02-linear-programming.pdf),
then [Modeling patterns](../output/lectures/02a-linear-modeling-patterns.pdf).
For the first sheet, follow Chapter 2's standard form, geometry and bases,
[Chapter 3](../output/lectures/03-simplex-method.pdf), then the required sections
of [Chapter 4](../output/lectures/04-degeneracy-and-duality.pdf). The handwritten
lecture confirms cycling, perturbation, Bland's rule, duality and complementarity
as current topics. Complexity in Chapter 4 and
[Chapter 5](../output/lectures/05-sensitivity-and-lagrange-multipliers.pdf) remain
enrichment; the supplied current materials do not confirm them as requirements.

## Supplied lecture 1

| PDF pages | Material in the supplied lecture | Developed explanation |
| --- | --- | --- |
| 1 | Title and authorship | Source inventory; no delivery date inferred |
| 2–8 | Five-product factory and general resource model | Chapter 1, “A concrete model”; Chapter 2, “Production planning”. Both grinding capacities are solved explicitly |
| 9 | Diet with nutrient and food bounds | Chapter 2, “Diet problem”, including a hand lower-bound certificate |
| 10–12 | Oil blending, capacities, quality, profit | Modeling patterns, “Blending”, including the ratio derivation, zero-output convention and exact optimum |
| 13 | Linearity and decisions | Chapter 1, modeling assumptions; Chapter 2, LP definition; Modeling patterns, “Building an LP” |
| 14–15 | Transportation and forbidden routes | Chapter 2, generic transportation; Modeling patterns, exact-demand instance and hand certificate |
| 16–17 | Production, shifts and storage across months | Modeling patterns, “Production with storage”, forward-time network and optimal schedule |
| 18 | Minimum-cost flow | Modeling patterns, node balances, incidence signs and a worked network |
| 19 | Minimax and least-absolute-deviation regression | Chapter 2, “Regression as a linear program”, with contrasting hand solutions |
| 20–22 | Objective choice, feasibility and constant costs | Chapter 1, feasibility/optimality; Modeling patterns, objective constants, startup decisions and singleton example |
| 23 | Multiple objectives | Modeling patterns, weighted sums, threshold constraints, scaling and max–min derivation |
| 24 | Practical constraint types | Chapter 1 workflow and the production, diet, blending and network models |
| 25–26 | Incompatible requirements and minimizing deviations | Modeling patterns, hard/soft requirements, weighted and max deviations, distinction from Phase I |
| 27–29 | Standard form and transformations | Chapter 2, “Standard form and equivalent transformations”, including sign recovery and nonpositive variables |
| 30 | Vertex intuition | Chapter 2, geometry, outcome qualifications, vertex theorem and BFS equivalence |
| 31 | Example transition | No standalone mathematical content |
| 32–33 | Simplex indicators, entering/leaving rules and pivots | Chapter 3, canonical equations, feasible directions, ratio test and row operations |
| 34–35 | Initial basis, artificials, Phase I/II and Big M | Chapter 3, initialization and Big M, retaining column-indexing and penalty qualifications |
| 36–39 | Four-variable equality example | Chapter 3, “Two different Phase I starts”; the same numerical example and image-based tableau path |

The lecture confirms these topics' presence in the slides. It does not establish
that the full proofs, examples or counterexamples added to the notes were delivered orally.

## Handwritten lecture: 19 October 2026

All ten BOOX pages were reviewed visually. Read Chapter 3's indicators and ratio
test first, then the following sections of [Chapter 4](../output/lectures/04-degeneracy-and-duality.pdf).
These are conceptual sections, not a new numbered lecture document.

| PDF pages | Recorded topic | Reading destination and outcome |
| --- | --- | --- |
| 1 | Cycling, entering/leaving choices, symbolic perturbation | “Degeneracy” and “Perturbation and lexicographic tie-breaking”; zero steps can change bases without improving the original objective |
| 2 | Perturbed two-variable example | “A zero-ratio tie resolved by symbolic right-hand sides”; both pivot tableaus, symbolic ratio comparisons, limit optimum `(0,0)`, value `0` |
| 3 | Bland's rule, finite termination, weighted bounds | “Bland's rule and its complete path”; “A weighted bound and paired primal–dual tableaus”; full Bland requires both index rules |
| 4–5 | Dual definition, weak/strong duality, dual of the dual | “Constructing the dual problem” and “Weak duality, strong duality, and possible outcomes”; dual objective is `b^T y`, with `m` terms |
| 6–8 | Dictionary transposition and paired primal/dual pivots | “A weighted bound and paired primal–dual tableaus”; primal `(0,1/4,13/4)`, dual `(1,3)`, common value `10` for RHS `(1,3)` |
| 8–9 | Complementarity and its proof | “Complementary slackness”; feasible points are optimal exactly when all complementary products vanish |
| 9–10 | Candidate `(2,1,1,0,0)` | “Certifying a supplied candidate without running simplex”; existing example, value `8`, dual `(1,2,0)`, entire optimal segment retained |
| 10 | Choose the dual because its slack start is feasible | “Solving the dual when its slack start is feasible”; two primal-simplex pivots on the transformed dual, primal `(7,0)`, dual `(0,0,1)`, original value `-7` |

Chapter 4's final remarks record handwriting discrepancies: the isolated RHS `8`
on page 6 versus `3` in the dictionaries and subsequent tableaus; the final
perturbation coefficient; and row arithmetic on page 10. The RHS `8` variant is
also solved in those remarks (value `25`). The final page uses primal simplex on
a transformed dual; this is distinct from the dual-simplex algorithm. New pivot
tableaus and certificates passed independent exact rational checks. The existing
MATLAB companion has not been extended or rerun for these additions.

## Supplied sheet 1

The three reading documents preserve the original Polish instructions and data:

- [Primal simplex: group 1](../output/exercises/01-primal-simplex.pdf)
  ([source](../notes/exercises/01-primal-simplex.tex)).
- [Complementarity and two-phase methods: groups 2–3](../output/exercises/01-complementarity-and-two-phase.pdf)
  ([source](../notes/exercises/01-complementarity-and-two-phase.tex)).
- [Dual simplex and primal recovery: groups 4–5](../output/exercises/01-dual-simplex-and-recovery.pdf)
  ([source](../notes/exercises/01-dual-simplex-and-recovery.tex)).

| Task | Required ideas and prerequisites | Hand result under printed data |
| --- | --- | --- |
| 1(a) | Chapter 3, ordinary pivots and uniqueness certificate | Unique `(1/3,11/3,4)`, maximum `46/3` |
| 1(b) | Chapter 3, pivots and finite objective on an unbounded set | Unique `(0,1,2)`, maximum `5` |
| 1(c) | Chapter 3, actual zero-cost moves and optimal faces | `(t,6+2t,8)`, `0 <= t <= 2`, maximum `36` |
| 1(d) | Chapters 2–3, surplus signs and a supplied basis | `(8-2t,t,0)`, `2 <= t <= 4`, maximum `8` |
| 1(e) | Chapter 3, reject inadmissible start and exhibit growth | Given start violates `x1=6`; feasible ray `(6,0,4)+t(0,0,1)`, value `16+t` |
| 1(f), i and ii | Chapters 2–3, feasible point versus BFS, initialization and ray | First start is feasible but nonbasic; both paths yield `(6,0,1)+t(5,0,2)`, value `33+24t` |
| 2(a) | Chapter 4, feasibility and complementary dual certificate | Candidate optimal, maximum `7`, dual `(3,0,2,0)` |
| 2(b) | Chapter 4, feasibility before optimality | Candidate infeasible; actual optimum `(2,0,2)`, minimum `6`, dual `(0,9/2,6)` |
| 2(c) | Chapter 4, mixed row signs and complementarity | Candidate optimal, maximum `1`; dual `(-1,0,2)` and an optimal primal segment |
| 3(a) | Chapters 3–4, mixed rows, dual construction and Phase I/II | `(0,3,0)`, maximum `-6`, dual `(0,0,-1)`; alternatives described in the solution |
| 3(b) | Chapters 2–4, nonpositive variable, negative RHS, sign recovery | `(3/2,0,-5/2)`, minimum `1/2`, dual `(3/2,0,1/2)`; an optimal ray |
| 4 | Chapter 4, dual-feasible pivots and recovery of dual prices | Unique `(3,0,2,0)`, minimum `7`; dual `(0,3,1)` |
| 5(a) | Chapters 3–4, nonpositive variable and infeasibility certificate | Primal unbounded below; dual infeasible; Phase I minimum artificial sum `3` |
| 5(b) | Chapters 3–4, free variable, dual two-phase and primal recovery | Primal `(3,-6,7)`, minimum `-44`; unique dual `(31/4,0,15/2,9)` |
| 5(c) | Chapters 3–4, two free variables and inconsistent dual equalities | Primal unbounded below; dual infeasible; Phase I minimum artificial sum `4` |
| 5(d) | Chapters 3–4, free variable, Phase II and complementarity | Primal `(0,-8,5)`, minimum `80`; unique dual `(0,18,0,5)` |

Ray parameters are nonnegative unless an interval is displayed. Sheet content
establishes practice requirements, not prior coverage in lecture 1. In particular,
groups 2–5 require duality, which the supplied lecture does not develop.
Inadmissible candidates may be deliberate checks. Group 5's generic request for
optimal dual solutions cannot be fulfilled for 5(a) and 5(c) as printed; their
solutions give the appropriate infeasibility and unboundedness certificates.

## Additional foundations and optional reading

The [notes review and further-study guide](notes-review.md) records the holistic
review, seven new TikZ figures and remaining directions. Added foundations cover
attainment and convexity (Chapter 1), integer relaxations (Chapter 2), network
cuts and integrality plus criterion-space trade-offs (Modeling patterns), revised
simplex (Chapter 3), Farkas' alternative and numerical certificates (Chapter 4),
and nonlinear KKT qualifications and a barrier/central-path introduction
(Chapter 5). Their current-course alignment is unknown; their presence does not
change the supplied-lecture or sheet requirements above.

The LP explanations remain the canonical prerequisites. Smooth nonlinear
algorithms, full second-order theory, general integer algorithms, nonsmooth
methods and optimization under uncertainty are still further-study directions,
not fully developed chapters. The guide gives prerequisites and concrete next
steps instead of claiming coverage from the historical roadmap.

## Verification and maintenance

Each exercise document links its actual matching MATLAB script. The modeling
examples share [modeling_patterns_checks.m](../matlab/exercises/modeling_patterns_checks.m).
Hand certificates and exact rational verification establish the reported mathematics.
Actual MATLAB execution is recorded separately in the [verification record](matlab-verification.md).
Update this map, source remarks and both language versions when new materials arrive;
preserve uncertain future alignment rather than extrapolating from historical lectures.
