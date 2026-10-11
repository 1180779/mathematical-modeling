# Integrate the current course while preserving mathematical depth

English | [Polski](2026-10-05-current-course-integration.pl.md)

Status: implemented

## Problem and evidence

The notes should support the 2026–27 course and understanding sufficient to
explain and reconstruct the mathematics. Current materials should determine
coverage and practice priorities; mathematical dependencies should determine
explanation order. The user's account of a friend's lecture experience motivates
clearer teaching, but remains secondhand evidence. Slides cannot establish what
was explained orally.

Three independent agent reviews examined source coverage, teaching depth, and
repository organization. The user approved the approach on 2026-10-05.
The conceptual chapters, current-source map, modeling supplement and complete
worked sheet are now in place. The initial alternatives and rationale are retained
below. MATLAB execution was unverified at integration time; later successful
user output is recorded in the [verification log](../../matlab-verification.md).

Source paths are relative to the repository root; page references mean PDF pages.

- `../lectures-2026-27/ProgMat_w1.pdf`: 39 pages, from modeling through simplex,
  artificial variables, two-phase initialization, and Big M.
- `../execrices-2026-27/ProgMatc1.pdf`: two pages, five groups containing 16
  subproblems, or 17 start cases counting both starts in 1(f). Includes duality,
  complementarity, and dual simplex, which the supplied lecture does not develop.

The lecture corresponds mainly to existing notes 02–03; the sheet also needs 04.
Existing “Lecture 1–5” numbers follow historical material rather than the current
lecture sequence. PDF creation dates do not establish delivery dates; the supplied
exercise PDF has 2025 metadata. Future syllabus and assessment coverage remain unknown.

## Alternatives considered

| Direction | Benefit | Cost or limitation |
| --- | --- | --- |
| Reorganize the main notes around current lectures | Direct lecture correspondence | Lecture 1 compresses several conceptual chapters; restructuring displaces prerequisites or creates a large chapter and duplication |
| Preserve existing notes and write a complete second course companion | Existing work survives; weekly documents are convenient | Two treatments of the same mathematics require synchronized corrections |
| Keep conceptual chapters, add a course map, and develop separate worked sheets | Preserves depth and makes course preparation concrete | Requires a small maintained map and precise coverage statements |

Recommend the third direction. A short weekly reading route can later be derived
from the map if useful, linking to canonical explanations rather than duplicating them.

## Recommended direction

Keep one authoritative explanation of each concept and initially preserve existing
filenames and links. Describe the numbered notes as conceptual chapters in navigation;
consider changing displayed “Lecture” titles to “Chapter” in a later coherent edit.
Retain historical enrichment, including notes 04–05, while limiting current-course
claims to topics supported by the supplied lecture or tasks.

Add a bilingual `docs/course-map-2026-27.md` relating source pages and task IDs to
chapter sections and coverage gaps. Distinguish lecture presence, task requirements,
and added explanations. During source intake, update `docs/sources.md`, its Polish
pair, and outdated README availability claims. Originals remain outside the repository.

Develop the actual sheet under `notes/exercises/`, retaining Polish statements,
printed data, and original task IDs, with English hand solutions. Documents can
be split by groups: primal simplex (1), certificates and two-phase methods (2–3),
and dual simplex and primal recovery (4–5). Theory chapters teach reusable ideas;
exercise documents apply them, with prerequisite pointers and matching MATLAB scripts.

Continue the [writing guide](../../writing-guide.md),
[language policy](../../language-policy.md), and
[self-contained teaching decision](../implemented/2026-10-04-self-contained-study-notes.md).
Sources, discrepancies, and execution history stay in final editorial remarks or
`docs/`; mathematical assumptions and limitations stay beside the results.

## Coverage and priorities

Destinations below refer to `notes/lectures/`. This compares source content and
proposes work; it does not claim that current-source integration is already complete.

| Source locator | Topic | Existing destination and proposed work |
| --- | --- | --- |
| Lecture pp. 2–8 | Production and general resource models | 01 modeling workflow; 02 production. Add the five-product model with units and declared capacity assumptions; preserve the simpler geometric example |
| Lecture p. 9 | Diet | 02 other modeling patterns; explain requirement bounds and units |
| Lecture pp. 10–12 | Blending | Add mass balance, revenue minus costs, weighted hardness, positive-output assumption, and zero production to 02 or a focused modeling chapter |
| Lecture p. 13, pp. 20–24 | Linearity, objective selection, multiple objectives, practical constraints | Extend 01–02 with concrete examples, unavoidable constants versus startup decisions, weighted objectives and scaling, threshold constraints, and max–min reformulation |
| Lecture pp. 14–17 | Transportation and production with storage | Extend 02: exact customer demand, forbidden routes, time-indexed costs and forward-time arcs |
| Lecture p. 18 | Minimum-cost flow | Add node balances, capacities, supply convention, and a network diagram |
| Lecture p. 19 | Minimax and least-absolute-deviation regression | Reuse 02 regression; explain auxiliary bounds and free slope/intercept variables |
| Lecture pp. 25–26 | Conflicting requirements and goal programming | Add nonnegative deviations, sum/max measures, meaningful weights, hard/soft requirements, and the model change caused by relaxation |
| Lecture pp. 27–30 | Standardization, geometry, vertex motivation | Reuse 02 equivalence arguments and qualified vertex/BFS results; explicitly treat nonpositive variables and reconstruct original objectives |
| Lecture p. 31 | Example transition slide | No independent mathematical addition needed |
| Lecture pp. 32–35 | Simplex, initialization, two-phase and Big M methods | Reuse 03 derivations and qualifications; document source indexing and penalty issues in final remarks |
| Lecture pp. 36–39 | Equality example and artificial-variable tableaus | The same numerical example is already developed in 03, including the all-artificial path and another start; reuse it |
| Sheet p. 1, 1(a)–1(f) | Primal simplex, starts, alternative optima, growth rays | 02 bases/rays and 03 simplex/initialization; develop all six tasks and both 1(f) starts |
| Sheet p. 1, 2(a)–2(c) | Candidate optimality and complementarity | 04 dual construction and certificates; check feasibility first |
| Sheet p. 2, 3(a)–3(b) | Dual formulation and two-phase solves | 02 domains, 03 Phase I/II, 04 mixed-sign dual rules |
| Sheet p. 2, 4 | Dual simplex and a dual solution | 04 dual-simplex derivation and certificate |
| Sheet p. 2, 5(a)–5(d) | Solve the dual, recover the primal, assess dual alternatives | 04 mixed domains, complementarity, outcomes and optimal faces; 03 two-phase initialization; handle exceptional outcomes explicitly |

## Preserving and improving depth

Existing depth is worth retaining for specific reasons: 02 develops hand certificates,
equivalence mappings, geometry and bases; 03 derives reduced costs and the ratio test
and supplies counterexamples; 04 derives dual bounds and complementary slackness;
05 connects geometry, multipliers and sensitivity. But 01 remains largely abstract,
and several modeling patterns in 02 are brief. New sources should improve these
parts rather than merely add a formula catalogue.

For important constructions, state the question, symbols, units and assumptions;
derive the equations; explain what each transformation preserves; work an example;
and justify the result with a proof or certificate. Add geometry and failure cases
where useful. These are teaching components, not a mandatory repeated template.
Depth means the reader can justify the method. A course reading route can shorten
the immediate workload while retaining access to complete derivations.

A useful pilot links standardization to simplex starts. Prove the equivalence
of an inequality and its slack equality, then distinguish feasible points from
feasible bases. In 1(f)(i), `(0,1,0)` has slacks `(1,2,11)`: four positive augmented
coordinates with three equations, so it cannot be basic. In 1(f)(ii), `(3,0,0)`
has slacks `(0,1,2)` and admits a feasible basis. Explain initialization before pivots.

Keep the maximization convention `q_j = z_j - c_j`, derived from
`c^T x = z0 - sum(q_j x_j)`. Derive the ratio test from nonnegativity along a
feasible direction. Retain qualifications about degenerate steps, an actual
positive move for distinct alternative optima, the vertex theorem's hypotheses,
and justified Big M penalties.

Blending supplies another concrete explanation: for positive total output,
hardness is a mass-weighted average. Multiplication by that positive output
preserves inequality directions and yields linear quality bounds. At zero output,
the average is undefined; accepting zero production is an explicit modeling convention.
Similarly, relaxing requirements solves a changed model; explain which constraints
may be softened and how weights compare deviations in different units.

## Source discrepancies and mathematical outcomes

Lecture p. 4 states four grinding machines; pp. 6–7 use three and 144 weekly hours.
Four at 48 hours each imply 192 hours. Preserve both readings in editorial remarks
and declare the capacity used in any worked model. The intended datum remains unresolved.

Lecture p. 34's initial-column condition uses row indices where a column condition
is needed. Explain the correct condition and normalization. Page 35's claims about
Big M and artificial variables require penalty qualifications already present in 03.
Keep these qualifications when aligning sources. Image-based tableaus on pp. 37–39
were checked visually; text extraction omits them.

Preserve supplied candidates: 1(e)'s `(0,0,6)` violates `x1 = 6`, and 2(b)'s
`(2,0,-2)` violates nonnegativity and its third inequality. Task 1 allows the given
start only “if possible”; task 2 asks whether the candidate is optimal. These may
be intentional checks. Reject inadmissible starts/candidates without assuming typos.

Two printed tasks also defeat group 5's generic request for optimal dual solutions:

- **5(a):** `x(t) = (-2-t,0,0)`, `t >= 0`, is feasible and has objective
  `-6-3t`, unbounded below. The dual requires `-(y1+y2+y3+y4) >= 3` with
  `y >= 0`, which is impossible.
- **5(c):** `x(t) = (-5-t,-t,0)`, `t >= 0`, is feasible and has objective
  `5-4t`, unbounded below. Its dual requires `y1+y2+y3 = 1` and
  `-y1+y3-y4 = 5` with `y >= 0`; the latter left side is at most 1.

These rays and directional inequalities were independently checked with exact
integer arithmetic during this review. They establish outcomes under the printed
data; intent remains unknown. Future solutions should give the certificates and
explain why the requested optimum does not exist, preserving the original statements.

## Implementation sequence and acceptance criteria

1. **Source intake and navigation.** Inventory both PDFs, create the bilingual
   course map, and update availability claims. Every lecture topic and all 16
   subproblems must have a destination or explicit gap; unknown dates stay unknown.
2. **Teaching pilot.** Develop both starts of 1(f) and their hand solves. The reader
   should be able to justify initialization, signs, pivots, and the final outcome.
3. **Complete sheet 1 by groups.** Develop 1, then 2–3, then 4–5, using the map
   for prerequisites. Retain original statements, exact hand reasoning, requested
   ray/alternative arguments, and valid feasibility and optimality certificates.
   Explain exceptional outcomes, including 5(a) and 5(c).
4. **Expand confirmed modeling gaps.** Begin with blending, then networks and
   production with storage, then objective selection and soft constraints. Derive
   each model with assumptions and units, work an example, and update the map and
   source remarks. Split a conceptual chapter only if its size impairs studying.

For mathematical changes, link actual MATLAB scripts and compare the same inputs
and tolerances. Distinguish exact reasoning, static review and actual execution;
record unexecuted scripts honestly. Use the existing translation review, TeX
formatter, `./build.sh`, PDF build record, and output checks. Review diagrams in
compiled PDFs. This proposal requires no new tooling.

## Assumptions, risks, and scope

Deep personal understanding and practical course preparation are both priorities.
Validate the balance through the pilot: reconstruct the method and locate its
prerequisites without first reading every enrichment section. Only one current
lecture and sheet are available; future ordering, labs and assessment emphasis
remain unknown. Revisit the map as materials arrive.

The map can become stale, and worked sheets can duplicate theory. Update map rows
with each integration and keep reusable derivations in canonical chapters. Avoid
expanding every historical topic before confirmed gaps and exercise needs are met.

No second textbook, mandatory full Polish study chapters, new solver framework,
repository-wide renaming, or removal of historical depth is proposed. Existing
language, source-storage, teaching-text and build decisions continue to apply.

## Implementation on 2026-10-05

The source inventory and both READMEs now describe the supplied current materials.
The bilingual course map links every lecture topic and all 16 subproblems to
actual explanations and hand solutions. Displayed titles identify Chapters 1–5
while existing source paths remain stable.

Chapter 1 adds the five-product factory and solves both grinding capacities.
Chapter 2 expands diet, regression and transformation explanations. The separate
modeling-patterns supplement develops blending, restricted transportation,
production with storage, minimum-cost flow, objectives and goal relaxation.
Existing geometric proofs and Chapters 3–5 retain their depth.

Three exercise documents cover groups 1, 2–3 and 4–5, including both 1(f) starts,
45 displayed tableaus, full certificates and exceptional outcomes under the
printed data. Four base-MATLAB companions check the same inputs. Independent
exact-arithmetic and static reviews passed; the launcher issue prevents an actual
MATLAB run. The [verification record](../../matlab-verification.md) preserves
that limitation. Source provenance and contradictions remain in final remarks
and documentation, with mathematical assumptions beside the teaching material.
