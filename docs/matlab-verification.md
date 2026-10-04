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
