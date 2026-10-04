#!/usr/bin/env bash
# Compile study notes, then copy their PDFs into the matching output tree.
set -euo pipefail

if (( $# != 0 )); then
    printf 'Usage: %s (builds all LaTeX documents under notes/)\n' "$0" >&2
    exit 2
fi

repo_root=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
cd -- "$repo_root"

for tool in latexmk pdflatex; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        printf 'Required command not found: %s\n' "$tool" >&2
        exit 1
    fi
done

mapfile -d '' -t note_files < <(find notes -type f -name '*.tex' -print0 | sort -z)
if (( ${#note_files[@]} == 0 )); then
    printf 'No LaTeX documents found under notes/.\n' >&2
    exit 1
fi

# Keep empty study categories available without adding non-PDF placeholders.
while IFS= read -r -d '' note_dir; do
    relative_dir=${note_dir#notes}
    mkdir -p -- "build${relative_dir}" "output${relative_dir}"
done < <(find notes -type d -print0)

for source in "${note_files[@]}"; do
    relative_path=${source#notes/}
    build_dir="build/$(dirname -- "$relative_path")"
    printf '\nBuilding %s\n' "$source"
    latexmk -pdf -interaction=nonstopmode -halt-on-error -file-line-error \
        -outdir="$build_dir" "$source"
done

# Publish only after every document builds successfully.
for source in "${note_files[@]}"; do
    relative_path=${source#notes/}
    pdf_path=${relative_path%.tex}.pdf
    cp -- "build/$pdf_path" "output/$pdf_path"
    printf 'PDF: output/%s\n' "$pdf_path"
done
