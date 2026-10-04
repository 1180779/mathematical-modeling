# Decision log

English | [Polski](README.pl.md)

## Purpose

Record lasting choices and open proposals concerning study organization, notation,
language, templates, and tooling. This is a decision backlog, not a transcript of
conversations or a substitute for Git history.

## Lifecycle

Use `proposed/`, `implemented/`, `rejected/`, and `superseded/` directories.
Name each pair `YYYY-MM-DD-topic.md` and `YYYY-MM-DD-topic.pl.md`, using the
first-proposed date. Create a proposal for an unresolved choice; do not invent
proposals just to populate the backlog. Move both files when status changes,
update the status, and repair links. No unresolved proposals are recorded yet.

An implemented decision describes the policy or structure actually in place.
A rejected proposal keeps its rationale. When a decision changes, add a new
record and link it to the superseded record; retain the old rationale.

## Format

Start with a title, reciprocal language link, and `Status: proposed`,
`Status: implemented`, `Status: rejected`, or `Status: superseded`.
Keep status tokens identical in both languages. Record:

- Problem and context.
- Decision, or proposal while unresolved.
- Genuine alternatives considered and why they were not selected.
- Consequences for implemented decisions; acceptance criteria and risks for proposals.
- Rejection reason or superseding link when applicable.

Update both languages in the same commit with equivalent meaning and section order.
Write records for substantive choices; use commit messages for ordinary edits.
This lightweight convention is inspired by
[DeepSeek Harness Agent Notes](https://github.com/deepseek-ai/deepseek-harness/blob/master/.agents/notes/README.md)
and its [bilingual policy](https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/i18n/README.md).
It does not adopt their classification folders or archive machinery. Paired
records have section hash sidecars following the [language policy](../language-policy.md).
