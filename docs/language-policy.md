# Language policy

English | [Polski](language-policy.pl.md)

## Study material

Write lecture notes, explanations, hand solutions, and MATLAB revision in English.
Add Polish equivalents of important terms to the [shared glossary](glossary.md).
At first use, a Polish equivalent may appear in parentheses when it helps relate
an English concept to the class vocabulary. Full Polish chapters are not required.

Preserve supplied exercise statements in their original language with attribution.
Label any translation and keep mathematical meaning, notation, and data unchanged.
Use English MATLAB identifiers and explanatory comments, with one shared codebase.

## Repository documentation

Pair READMEs, guides, source inventories, and decision records as `topic.md` and
`topic.pl.md`. Use reciprocal language links, matching section order, equivalent
meaning, and identical commands, paths, identifiers, and status values. Links to
paired prose should select the reader's language. The glossary is bilingual in
one file; `AGENTS.md`, study notes, and LaTeX templates are English only.

Update both members in the same commit. Either language may be edited first;
resolve disagreements before committing. Review meaning manually: file presence
and matching structure do not prove translation accuracy. Each pair also has a
sibling `.i18n.json` record of reviewed section hashes. After reviewing an edited
pair, run `python3 scripts/check_translations.py --write <English-file.md>` and
commit all three files. The pre-commit check compares staged hashes, heading
depths, reciprocal language links, and exact fenced code. Code fences are
compared separately and excluded from section hashes. English heading paths key
the records; Polish sections align by position. SHA-256 hashes cover each
section’s heading and prose after trimming its outer whitespace. This detects
changes since review, not semantic correctness. Use ATX (`#`) headings in paired
documents; the checker deliberately implements this repository’s current format.
README and Markdown documents under `docs/` are in scope; `AGENTS.md`, study
notes, and the single bilingual glossary are not paired. Record confirmation is
explicit: `--write` requires named pairs or the corpus-wide `--write --all`.

## Reconsideration

This is the current policy, not a permanent restriction. If Polish assessment
practice or full Polish chapters become useful, record a new decision that
supersedes the [initial language decision](decisions/implemented/2026-10-04-language-policy.md).
