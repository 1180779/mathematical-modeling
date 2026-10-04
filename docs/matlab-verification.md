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

**MATLAB execution: pending.** The agent attempted this command in the sandbox;
it exited with code 1 and no output. An earlier version-only attempt in this turn
behaved the same way. No successful Lecture 3 terminal output has been supplied.
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
