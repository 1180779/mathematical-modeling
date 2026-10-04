# Repository instructions

- Study notes, hand solutions, and MATLAB comments are written in English.
- Maintain Polish terminology in `docs/glossary.md`; preserve original task statements with source attribution.
- READMEs, guides, source inventory, and decision records use sibling `.md` / `.pl.md` pairs. Update both together and keep reciprocal language links.
- This instruction file is English only. The glossary is bilingual in one file; LaTeX templates and study notes are English only.
- Read `docs/writing-guide.md`, `docs/language-policy.md`, and relevant decisions before adding material.
- Use `templates/modeling-notes.sty`; do not duplicate preambles in notes.
- Keep teaching text independent of repository decisions and provenance. Put source attribution, editorial context, and execution evidence in final remarks or `docs/`; use only backward pointers from those remarks. Keep essential mathematical assumptions in the teaching text.
- Add readable TikZ diagrams when they clarify the mathematics.
- Historical 2020 lectures are reference material, not confirmed current syllabus. Mark unknown course alignment explicitly.
- Do not invent lecture dates, task sources, MATLAB versions, solver output, or verification results.
- For worked tasks, provide assumptions and a hand derivation, link the actual MATLAB script, and compare the same inputs and tolerances.
- Run `./build.sh` to build LaTeX notes into ignored `build/` and refresh the PDF-only `output/` tree matching `notes/`. Commit PDF copies alongside their sources. Run relevant MATLAB scripts when MATLAB is available; otherwise report them as unverified.
- Record lasting decisions under `docs/decisions/` with problem, decision/proposal, alternatives, and consequences/acceptance criteria.
- Preserve old decision rationale. Supersede it with a linked new record when a choice changes.
- Keep source PDFs outside this repository unless explicitly needed; inventory them in `docs/sources.md`.
