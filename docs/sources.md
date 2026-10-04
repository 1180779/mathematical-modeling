# Source inventory

English | [Polski](sources.pl.md)

## Historical lectures

Thirteen PDFs are available beside this repository. Their folder labels them as
2020 lectures; lecture 1 contains a 2019/2020 schedule. Lectures 1 and 2 have been reviewed
for these notes; alignment with the current lecturer, syllabus, exercises, and labs
is unconfirmed. Paths below are
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
Current syllabus, exercise sheets, and lab instructions have not yet been supplied.

## Developed notes and source qualifications

- Lecture 1: `s4_w1.pdf`, PDF pages 1–6; introduction and historical roadmap.
- Lecture 2: `s4_w2.pdf`, PDF pages 1–11, printed slides 1–44; LP models,
  standard form, geometry, and bases. Regression formulas and the cabinet sketch
  were also inspected visually.
- The notes distinguish added hand proofs and derivations from slide content.
  Qualifications cover revenue versus profit, exact versus minimum demand,
  integer versus continuous cutting counts, strict convex combinations,
  recession directions for closed convex sets, pointed polyhedral representation,
  and the hypotheses of the optimal-vertex theorem.
- The 2 m cabinet solution assumes three 0.8 m members and two 0.3 m members per
  cabinet, zero kerf, and no joint or thickness allowances; these assumptions
  go beyond the sketch's explicit manufacturing information.

## Supplementary sources outside the repository

[MIT OCW 15.081J/6.251J, Lecture 10 (Fall 2009)](https://ocw.mit.edu/courses/6-251j-introduction-to-mathematical-programming-fall-2009/ab890d20b071105239fe0b9bcf599f57_MIT6_251JF09_lec10.pdf),
PDF pages 4 and 6, was consulted through the web tool to cross-check the recession
cone and vertex–ray representation hypotheses. It supplements the source lecture;
it is not evidence of current course coverage.

Intended local path from this repository:
`../sources/mit/mit-6-251j-2009-lecture-10-polyhedral-representation.pdf`.
**Not downloaded:** shell DNS resolution failed on 2026-10-04.
The external `../sources/README.md` records the official URL and retry command.

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
