# MATLAB verification

English | [Polski](matlab-verification.pl.md)

## Execution on 2026-10-04

The user ran the command below in a normal terminal from the repository root
and supplied its output. MATLAB reported version 26.2.0.3386108 (R2026b).
This was not an agent-executed run inside the sandbox.

```sh
matlab -batch "disp(version); run('matlab/exercises/lecture_02_checks.m'); run('matlab/review/arrays_and_linear_systems.m')"
```

```text
26.2.0.3386108 (R2026b)
Production: x = (2, 6), revenue = 18 PLN
5.2 m cutting: counts = (200, 0, 400), offcut = 140 m
2 m cabinets: 11 boards; one enumerated plan = (10, 1, 0)
All numerical refresher assertions passed.
Plot exported to /home/rdkgsk/Documents/Studies/masters/sem2/progmat/mathematical-modeling/matlab/output/01-quadratic-review.png
```

## Scope and limitations

Lecture 2 assertions check production vertices, the optimal basis, slacks,
the cutting certificate, and cabinet enumeration under the documented assumptions.
The refresher checks arrays, indexing, operators, the linear solve, vectorization,
and plot export. No Optimization Toolbox solvers were executed.

An initial attempt exposed invalid script names containing hyphens or starting
with a digit. These were corrected before the successful run. The agent's launcher
still exits with code 1 and no diagnostic, even after the user's login; the cause
remains unresolved. Normal-terminal results confirm the scripts and MATLAB installation work.

## Lecture 3 checks on 2026-10-04

The new companion is `matlab/exercises/lecture_03_checks.m`, covering candidate
basic solutions, the three-pivot production path and its alternative start,
the unbounded ray, both two-phase starts, degenerate zero steps, infeasibility,
a successful Big M solve, and the finite-penalty counterexample. It needs base MATLAB only.

```sh
matlab -batch "run('matlab/exercises/lecture_03_checks.m')"
```

**MATLAB execution: passed.** The user ran this command in a normal terminal
from the repository root on 2026-10-04 and supplied the output below. All
assertions passed, including checks that do not print separate summaries.
This was not an agent-executed run inside the sandbox. This command did not
print the MATLAB version; the earlier user run reported R2026b.

```text
Production: revenue sequence = 0, 12, 16, 18 PLN
Unbounded ray: Ad = 0, d >= 0, objective slope = 2
Two-phase: both starts give x = (7/8, 0, 0, 1/8), z = -11/8
Infeasible original inequalities: Phase I optimum w = 1
All Lecture 3 numerical assertions passed.
```

Before the successful user run, the agent's sandbox attempt exited with code 1
and no output; a version-only attempt behaved the same way. The sandbox startup
issue remains unresolved, but the normal-terminal run verifies the Lecture 3 script.
The successful Lecture 2 and refresher runs above remain valid.

**Static analysis: passed.** The installed R2026b analyzer ran successfully with
no diagnostics:

```sh
/usr/local/MATLAB/R2026b/bin/glnxa64/mlint -id matlab/exercises/lecture_03_checks.m
```

**Independent mathematical verification: passed.** Temporary Python calculations
using standard-library rational arithmetic recomputed all worked tableaus by
Gauss–Jordan elimination and checked equality residuals exactly. Exhaustive basis
enumeration found five production vertices with maximum 18 and four feasible
bases of the equality example with unique optimum −11/8. It also confirmed the
Phase I optimum 1 for the infeasible example and penalized optimum −10 with
positive artificial value for K = 100, M = 10. These checks establish the stated
hand results, not execution of the MATLAB script. The script independently
recomputes each basis and compares its pivot updates with the next linear solve.
The combined Big M indicator rows were also checked exactly at M = 10, giving
the same equality-problem optimum with zero artificial variables.

## Lecture 4 checks on 2026-10-04

`matlab/exercises/lecture_04_checks.m` needs base MATLAB only. It checks the complete
cycle, Bland and lexicographic paths, all eight Klee–Minty vertices, the mixed-sign
pair, production resource prices and RHS interval, complementarity and the optimal
segment, the one-pivot dual-simplex solve, a wrong pivot choice, and the contradictory
row certificate.

```sh
matlab -batch "disp(version); run('matlab/exercises/lecture_04_checks.m')"
```

**MATLAB execution: passed.** The user ran the command in a normal terminal from
the repository root and supplied the output below. MATLAB reported version
26.2.0.3386108 (R2026b). All assertions passed; this was not an agent-executed
run inside the sandbox.

```text
26.2.0.3386108 (R2026b)
Cycling: six zero steps return to the initial basis
Anti-cycling: Bland = 6 pivots, lexicographic = 2, optimum = 5/4
Klee-Minty: 8 vertices, 7 pivots, maximum = 125
Production: dual y = (1, 1/3, 0), value = 18; RHS interval [-2, 2]
Complementarity: candidate and optimal segment have minimum = 8
Dual simplex: one pivot, minimum = 5, dual y = (0, 1/2)
Infeasibility: h*A >= 0 and h*b = -1 certify the contradictory row
All Lecture 4 numerical assertions passed.
```

The agent's sandbox attempt exited with code 1 and no output. The startup cause
remains unresolved; the successful normal-terminal run verifies the script.

**Static analysis: passed.** The installed R2026b analyzer reported no diagnostics:

```sh
/usr/local/MATLAB/R2026b/bin/glnxa64/mlint -id matlab/exercises/lecture_04_checks.m
```

**Independent mathematical verification: passed.** Temporary Python calculations
using standard-library rational arithmetic recomputed every worked path, indicator
row, and certificate. An exact small perturbation produced the same two lexicographic
pivots with positive steps in the perturbed problem. Exhaustive basis enumeration
confirmed eight distinct cube vertices with maximum 125. The RHS interval,
mixed-sign feasible pair, and optimal-segment parametrization were checked too.
The results agree with the hand derivations.

## Lecture 5 checks on 2026-10-04

The script `matlab/exercises/lecture_05_checks.m` uses base MATLAB only.
It checks parameter ranges and endpoints, the value function, joint RHS/cost
changes including the cross term, new-column and new-row pivots, variable and
constraint deletions, and the unique KKT certificate. Basis enumeration compares
the finite optima of the small models. Rays and contradictory rows have separate
certificates; enumeration is not a general unboundedness test.

```sh
matlab -batch "disp(version); run('matlab/exercises/lecture_05_checks.m')"
```

**MATLAB execution: passed.** The user ran the command in a normal terminal
from the repository root and supplied the exact output below.
MATLAB reported version 26.2.0.3386108 (R2026b). All assertions passed.

```text
26.2.0.3386108 (R2026b)
Sensitivity: RHS change [-50/3, 22]; cost endpoints = -3/2, 2, 2/5
Simultaneous RHS changes: separately feasible, combined basic slack = -9
Vector updates: new-cost value = 64/3; new-RHS value = 6; joint value = 12
Added column: x1 = 16, x6 = 10, value = 42
Added row: x = (10/3, 0, 8/3), value = 28/3
Deletions: x1 removal gives 6; production row 3 gives 18, row 1 gives 20
KKT: multiplier signs, stationarity, complementarity; unique maximum = 37/2
All Lecture 5 numerical assertions passed.
```

The agent's sandbox attempt exited with code 1 and no output; the startup cause
remains unresolved. The execution evidence above is user-supplied.

**Static analysis: passed.** The installed R2026b analyzer reported no diagnostics:

```sh
/usr/local/MATLAB/R2026b/bin/glnxa64/mlint -id matlab/exercises/lecture_05_checks.m
```

**Independent mathematical verification: passed.** Temporary Python calculations
using standard-library rational arithmetic recomputed the tableaus, ranges,
endpoints, structural updates, and KKT certificate. Exhaustive small-basis
enumeration confirmed finite optimal values, both value-function branches,
and absence of feasible bases in the contradictory examples. Hand certificates
separately prove infeasibility and unboundedness where enumeration alone would
not establish the outcome.

## Current-course integration on 2026-10-05

Four new base-MATLAB scripts accompany the revised conceptual notes and all 16
subproblems of the first supplied sheet (including both starts of 1(f)):

```matlab
run('matlab/exercises/modeling_patterns_checks.m')
run('matlab/exercises/sheet_01_primal_simplex.m')
run('matlab/exercises/sheet_01_complementarity_and_two_phase.m')
run('matlab/exercises/sheet_01_dual_simplex_and_recovery.m')
```

**MATLAB execution: unverified.** An agent version-only launcher attempt,
`matlab -batch 'disp(version)'`, exited with code 1 and no output. The startup
issue described above persists. The four new scripts have not been executed
in MATLAB, and no new runtime release, observed output or numerical error is
claimed. Earlier successful user runs apply only to their named historical scripts.

**Static analysis: passed.** The installed R2026b standalone `mlint -id` analyzer
checked each of the four scripts without diagnostics. This does not execute them.

**Independent mathematical verification: passed.** Exact Python `Fraction`
calculations and independent agent reviews checked all 45 displayed exercise
tableaus, basis equations, pivot transitions, objective rows and original-domain
certificates. They also checked optimal sets, supplied starts, both unbounded
primal problems in group 5, and Phase I minimum artificial sums 3 and 4 for their
infeasible duals. Independent review corrected task 5(d)'s prose column slack to
`(4,0,0)`; the final script asserts that value explicitly.

The modeling examples were independently checked in exact rational arithmetic:
factory values `28704/5` and `32544/5` under capacities 144 and 192; blending
profit `475000/27`; transportation cost `25919`; storage cost `1883/2`; flow
cost 9; diet and regression bounds. Each finite result has a hand bound attained
by a feasible candidate. Enumeration was used as a separate small-instance
cross-check for factory, blending and transportation, rather than as a general
unboundedness test. Rays and contradictory dual conditions establish the
exceptional outcomes separately.

All four scripts compare the same stated inputs with absolute tolerance `1e-10`.
They use base MATLAB and prescribed calculations, without Optimization Toolbox
or a general-purpose LP solver. A successful future run must be recorded as a
new execution event with actual output before the new scripts are called verified
in MATLAB. The notes' final remarks currently retain this distinction.
