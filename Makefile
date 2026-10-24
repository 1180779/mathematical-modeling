PYTHON ?= python3
MATLAB ?= matlab

.DEFAULT_GOAL := help
.PHONY: help build format check check-translations check-output check-format test \
	matlab-checks clean-preview clean download-preview download upload-boox upload-boox-dev

help:
	@printf '%s\n' \
		'make build              Build notes and refresh exported PDFs' \
		'make format             Format LaTeX and TikZ sources' \
		'make check              Run repository checks and Python tests' \
		'make test               Run Python script tests' \
		'make matlab-checks      Run MATLAB study checks' \
		'make clean-preview      Preview removable TeX build files' \
		'make clean              Remove generated TeX build files' \
		'make download-preview   Preview supplementary lecture downloads' \
		'make download           Download supplementary lectures' \
		'make upload-boox        Upload changed committed PDFs to BOOX' \
		'make upload-boox-dev    Build and upload current PDFs without committing'

build:
	./build.sh

format:
	$(PYTHON) scripts/format_tex.py --write

check: check-translations check-output check-format test

check-translations:
	$(PYTHON) scripts/check_translations.py

check-output:
	$(PYTHON) scripts/check_output.py

check-format:
	$(PYTHON) scripts/format_tex.py --check

test:
	$(PYTHON) -m unittest discover -s scripts/tests -v

matlab-checks:
	$(MATLAB) -batch "run('matlab/review/arrays_and_linear_systems.m'); \
		run('matlab/exercises/lecture_02_checks.m'); \
		run('matlab/exercises/lecture_03_checks.m'); \
		run('matlab/exercises/lecture_04_checks.m'); \
		run('matlab/exercises/lecture_05_checks.m'); \
		run('matlab/exercises/modeling_patterns_checks.m'); \
		run('matlab/exercises/sheet_01_primal_simplex.m'); \
		run('matlab/exercises/sheet_01_complementarity_and_two_phase.m'); \
		run('matlab/exercises/sheet_01_dual_simplex_and_recovery.m')"

clean-preview:
	$(PYTHON) scripts/clean_tex.py --dry-run

clean:
	$(PYTHON) scripts/clean_tex.py

download-preview:
	$(PYTHON) scripts/download_lectures.py --dry-run

download:
	$(PYTHON) scripts/download_lectures.py

upload-boox:
	$(PYTHON) scripts/upload_boox.py

upload-boox-dev: build
	$(PYTHON) scripts/upload_boox.py --working-tree
