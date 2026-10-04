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
