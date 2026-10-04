# Commit, bilingual review, PDF, and formatting checks

English | [Polski](2026-10-04-repository-checks.pl.md)

Status: implemented

## Problem

The user requested short, structured commit messages, DeepSeek-like hash checks,
PDF integrity checks, and consistent formatting for TikZ using the existing
Neovim setup. Editor contents can differ from staged contents, so checking only
the working tree would not reliably validate a commit.

## Decision

Use versioned `.githooks/` hooks, enabled per clone with `core.hooksPath`.
The commit-message hook enforces at most 72 Unicode characters per line and a
blank separator before an optional body. Git editor comments are excluded.
Pre-commit checks read the Git index.

English–Polish Markdown pairs have section-keyed SHA-256 records in sibling
`.i18n.json` files. Review both languages before explicitly recording a pair.
Headings align by depth and order; fenced examples must match exactly and are
excluded from section hashes. This borrows the review-record concept from
[DeepSeek's bilingual convention](https://github.com/deepseek-ai/deepseek-harness/blob/master/docs/i18n/README.md),
using JSON and Python's standard library for this smaller repository.
It replaces the first iteration's decision to omit hash sidecars, while retaining
the English-notes and bilingual-documentation policy.

`build.sh` records SHA-256 hashes of exported PDFs and build inputs in
`docs/pdf-build.json`. The check detects changes to notes, figure assets, shared
style files, and PDF copies after a build. It also compares available intermediate
PDFs with exports; during pre-commit that comparison is limited to staged PDF
changes. A fresh clone can validate the committed hashes without intermediate files.

Use latexindent with `.latexindent.yaml` for `.tex`, `.sty`, and `.tikz` sources.
The existing inline figures remain in their lecture files. `.editorconfig` and
project `.nvim.lua` match the command-line settings; Conform's project formatter
is scoped to TeX filetypes. Global Neovim settings are not edited.

## Alternatives considered

**Working-tree-only hooks:** simpler but could miss staged errors masked by
unstaged fixes. Checks read staged files and staged formatter configuration.

**A single corpus hash:** detects drift but cannot identify the affected section.
Section records make translation review and diffs more focused.

**Import DeepSeek's full tooling:** brings unnecessary package and workflow
requirements. The smaller implementation checks pair completeness, headings,
fenced code, reciprocal links, and reviewed hashes, without a full Markdown parser.

**Always require intermediate PDFs:** prevents checks in a fresh clone.
Committed build records supply the baseline; local intermediate copies add a
byte comparison when available.

## Consequences

Enable hooks in every clone. Review translations before updating their records;
hashes cannot establish semantic equivalence. Format sources, rebuild, and stage
the refreshed PDFs and manifest together. Hook failures explain the correction.
No hook writes or restages files automatically. Python 3 and latexindent are
required for repository checks. The checks intentionally use the current ATX
Markdown format and do not reproduce DeepSeek's complete structural verifier.
