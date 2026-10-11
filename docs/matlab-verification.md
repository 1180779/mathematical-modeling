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

**MATLAB execution at integration time: unverified.** An agent version-only
launcher attempt, `matlab -batch 'disp(version)'`, exited with code 1 and no
output. No successful execution of these four scripts was recorded at that point;
earlier user runs concerned the named historical scripts. The later successful
user output is preserved in the next section.

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
or a general-purpose LP solver. The later execution event below supplies actual
output and updates their MATLAB verification status; it does not replace the
independent exact-arithmetic evidence.

## Current-course execution evidence received on 2026-10-11

**MATLAB execution: passed.** The user supplied the following output from the
four commands and confirmed the same version as the earlier runs:
26.2.0.3386108 (R2026b). The version was confirmed separately; these commands do
not print it. The exact execution date was not separately supplied.
This is user-supplied evidence, not an agent-executed sandbox run.

```text
>> run('matlab/exercises/modeling_patterns_checks.m')
Factory: optima 28704/5 and 32544/5 for G = 144 and 192
Blending: profit 475000/27; transport cost 25919
Storage: cost 1883/2; three-node flow cost 9
All modeling-pattern certificate assertions passed.
>> run('matlab/exercises/sheet_01_primal_simplex.m')
1(a): unique maximum 15.3333333333 at (1/3, 11/3, 4).
1(b): unique maximum 5; feasible set itself is unbounded.
1(c): maximum 36 on (t, 6+2*t, 8), 0 <= t <= 2.
1(d): maximum 8 on (8-2*t, t, 0), 2 <= t <= 4.
1(e): rejected supplied start; ray (6,0,4)+theta*(0,0,1), z=16+theta.
1(f)(i): nonbasic start moved to a BFS; two pivots reach (6,0,1).
1(f)(ii): one pivot from supplied BFS; same ray, z=33+24*theta.
Largest checked tableau/basis discrepancy: 7.11e-15 (absolute tolerance 1e-10).
All prescribed primal-simplex paths and certificates passed.
>> run('matlab/exercises/sheet_01_complementarity_and_two_phase.m')
2(a): supplied point optimal, maximum 7, dual (3,0,2,0)
2(b): supplied point infeasible; actual minimum 6, dual (0,9/2,6)
2(c): supplied point optimal, maximum 1, full segment checked
3(a): Phase I steps 4/3,5; Phase II maximum -6, dual (0,0,-1)
3(b): Phase I step 4, Phase II step 5/2; original minimum 1/2
3(b): dual (3/2,0,1/2), constant-objective optimal ray checked
All complementary certificates and displayed tableaus passed at tol = 1.0e-10
>> run('matlab/exercises/sheet_01_dual_simplex_and_recovery.m')
Task 4: primal = (3,0,2,0), dual = (0,3,1), value = 7; both unique
Task 5(a): dual infeasible, Phase I artificial sum = 3; primal slope = -3
Task 5(b): dual = (31/4,0,15/2,9), recovered primal = (3,-6,7), value = -44; both unique
Task 5(c): dual infeasible, Phase I artificial sum = 4; primal slope = -4
Task 5(d): dual = (0,18,0,5), recovered primal = (0,-8,5), value = 80; both unique
All Sheet 1 dual-simplex and recovery assertions passed.
```

All assertions passed and the reported values agree with the hand certificates.
The largest reported primal-simplex tableau/basis discrepancy, `7.11e-15`, is
below the script's absolute tolerance `1e-10`. This is an observed discrepancy
for those checks, not a universal error bound. The earlier sandbox-launch failure
remains historical context; it no longer leaves these four scripts unverified.
The new conceptual examples in the [notes review](notes-review.md) do not modify
these scripts and are not claimed to have been executed by them.

### Diet example revision after the recorded run

The Chapter 2 diet illustration now identifies nutrient amounts by food in a
table and uses `A = [2, 1; 1, 3]`, with nutrient rows and food columns in grams
per serving. Requirements remain `b = [4; 4]` g per day and prices remain
`c = [2; 3]` PLN per serving. The matching script now checks servings
`x = [8/5; 4/5]`, positive certificate weights `[3/5; 4/5]` and cost `28/5` PLN.
This is a revision of an added illustration, not of supplied course data.

**Independent mathematical verification: passed.** Exact Python `Fraction`
calculations checked both nutrient totals, the positive weighted lower bound,
uniqueness and all three vertices. **Static analysis: passed.** The R2026b
standalone `mlint -id` analyzer reported no diagnostics for the revised script.

**MATLAB execution of this revision: unverified.** The agent attempted
`matlab -batch "run('matlab/exercises/modeling_patterns_checks.m')"`; MATLAB
exited with code 1 and no output. The successful user transcript above concerns
the earlier diet coefficients. The three sheet 1 scripts are unchanged.
