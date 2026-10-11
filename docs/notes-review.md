# Notes review and further study

English | [Polski](notes-review.pl.md)

## Scope and findings

Review date: 2026-10-11. The review covers the six conceptual lecture documents,
the three sheet 1 solution documents, the MATLAB refresher, and the repository's
reading routes and verification records. It focuses on mathematical assumptions,
explanatory continuity, useful visualizations and material worth pursuing next.
It does not establish a new syllabus or independently recompute every existing
tableau. The earlier exact-arithmetic records and the user's MATLAB output remain
separate evidence.

The LP core is already substantial: standard-form equivalence, qualified
vertex/BFS results, reduced-cost and ratio-test derivations, initialization,
degeneracy, duality, complementarity and sensitivity have proofs, counterexamples
and worked certificates. All supplied sheet 1 tasks have solutions or outcome
certificates under their printed data. The main opportunities are connections
between these topics and the broader optimization roadmap, rather than more
tableaus for the same methods.

The supplied grinding-capacity conflict and exceptional exercise outcomes remain
explicit. The review preserves their data and the distinction between a feasible
point, a usable basis and a certificate. The refresher already explains array
shapes, backslash, residuals and conditioning; those explanations do not need a
second treatment in that document.

## Expansions and new figures

Section names below match the PDF contents; chapter numbers remain conceptual.

| Document | Added explanation | New TikZ figure |
| --- | --- | --- |
| [Chapter 1](../output/lectures/01-optimization-modeling.pdf) | Attainment, compactness and coercivity; local/global optimality; convex functions and the local-to-global proof | Convex chord versus unequal local minima |
| [Chapter 2](../output/lectures/02-linear-programming.pdf) | “What an integer relaxation can and cannot certify”: bounds, rounding, an exact small branch-and-bound solve | Continuous polygon, integer points, relaxation and integer optima |
| [Modeling patterns](../output/lectures/02a-linear-modeling-patterns.pdf) | Cut bottlenecks, network integrality and redundant balances; startup decisions; limits of weighted multiobjective criteria | Infeasible cut; Pareto trade-offs in criterion space |
| [Chapter 3](../output/lectures/03-simplex-method.pdf) | “From a full tableau to revised simplex”: basis solves, pricing, factorization and numerical care | Revised-simplex computation cycle |
| [Chapter 4](../output/lectures/04-degeneracy-and-duality.pdf) | Farkas' alternative; numerical primal/dual residuals and gap bounds with feasibility qualifications | Separating vector in the space of equation values |
| [Chapter 5](../output/lectures/05-sensitivity-and-lagrange-multipliers.pdf) | Nonlinear KKT sufficiency versus necessity, Slater/LICQ, stationary counterexamples and constrained curvature; barrier stationarity and gap | Explicit two-variable central path |

New examples are explanatory additions, not newly supplied course tasks. Their
current-course alignment is unknown. Existing MATLAB companions are unchanged;
the new examples have hand derivations and independent mathematical checks,
rather than a claim that existing scripts execute them.

## Remaining directions, in a useful order

These are optional study directions. The current lecture and sheet do not confirm
them as assessment requirements. Follow their prerequisites before implementing
an algorithm.

| Direction | What is still missing or only introduced | Prerequisites and a concrete next step |
| --- | --- | --- |
| Smooth unconstrained optimization | A developed treatment of line searches, gradient descent, Newton and quasi-Newton methods; descent and convergence assumptions | Chapter 1's local/global distinction, gradients and Hessians. Derive a gradient step and damped Newton step on a positive-definite quadratic, then explain why full Newton steps can fail on a nonconvex function |
| Constrained nonlinear optimization | Full second-order conditions, critical cones, reduced Hessians, SQP and augmented Lagrangians | Chapter 5's KKT and regularity distinctions. Analyze curvature only along directions allowed by an equality, then study how active inequalities change the relevant directions |
| Interior-point algorithms | Newton systems, feasible/infeasible starts, step lengths, stopping rules and a convergence proof; the barrier section is an entry point | Chapter 4's duality and Chapter 5's perturbed complementarity. Derive the Newton equations for `Ax=b`, `A^T y-c=q`, `x_j q_j=tau`, and identify which equations are linearized |
| Integer optimization | A general branch-and-bound implementation, valid cuts, formulation strength and integer optimality gaps | Chapter 2's relaxation example. Compare two equivalent integer formulations with different LP bounds; distinguish an incumbent from a proven optimum |
| Network optimization | Proof of total unimodularity, max-flow/min-cut construction, assignment and shortest-path reductions; specialized flow algorithms | Modeling patterns' balances and cuts. Add a super-source and super-sink for a supply/demand feasibility test, then explain why an extra shared-capacity row can break integrality |
| Nonsmooth convex optimization | Subgradients, proximal methods and their convergence assumptions; absolute-value and max objectives are currently handled through LP auxiliaries | Convexity and the regression/goal formulations. Derive the subgradient of an absolute value at zero and compare it with the LP epigraph formulation |
| Uncertain data and model validation | Robust and stochastic optimization, scenario models, recourse and out-of-sample validation | Modeling units and sensitivity. For demand `d in [d_min,d_max]`, requiring `x >= d` for every realization means `x >= d_max`; an expected-demand constraint makes a different promise. Decide which decisions precede observing demand and which may adapt |

The historical roadmap names many of these topics, but the repository currently
develops mainly LP. Historical PDFs 6–13 have not been integrated into these notes;
their presence is not confirmation of current coverage. New course materials
should decide the expansion order when they arrive.

## Further reading

Use the original derivations in the notes first; these references provide longer
treatments. The [source inventory](sources.md) records the sources consulted for
this review and their local-storage status.

- [Boyd and Vandenberghe, *Convex Optimization*](https://web.stanford.edu/~boyd/cvxbook/): Chapters 2–5 for convexity and duality; Chapters 9–11 for unconstrained, equality-constrained and interior-point methods.
- [MIT OCW, *Discrete optimization II*](https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/d0be6aa7393f489a419add7cec874a4c_MIT6_251JF09_lec25.pdf): cuts and branch and bound.
- [MIT OCW, *Networks 2: Network flows*](https://ocw.mit.edu/courses/15-053-optimization-methods-in-management-science-spring-2013/687225c151d8cc8254dcb8b07e5f9ce2_MIT15_053S13_lec16.pdf): flow formulations, integrality and network applications.

## Verification

On 2026-10-11 the user supplied successful output for the modeling-patterns and
all three sheet 1 MATLAB companions, confirming the same MATLAB version as the
earlier runs: 26.2.0.3386108 (R2026b). All assertions passed. The reported maximum
primal-simplex tableau/basis discrepancy was `7.11e-15` with absolute tolerance
`1e-10`. Exact commands and output are retained in the
[verification record](matlab-verification.md).

Independent checks used exact rational arithmetic for the integer relaxation
and both branches, polynomial values and derivative signs, the Farkas vector,
and the flow bottleneck. The central-path positivity, stationarity and gap were
checked at 60-digit precision. All ten notes have unique labels and resolved
local reference targets. All seven new figures were inspected in rendered PDFs.

All ten PDFs built successfully without overflow or unresolved-reference warnings.
Formatting, translation records and source/PDF hashes passed the repository's
existing checks. Graphs of new examples are drawn from
their formulas; schematic workflow figures are identified as such. No new MATLAB
run is attributed to the agent.
