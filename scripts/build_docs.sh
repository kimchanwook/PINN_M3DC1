#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
latexmk -pdf -interaction=nonstopmode -halt-on-error project_plan.tex
find "$ROOT" -type f \( -name '*.aux' -o -name '*.fdb_latexmk' -o -name '*.fls' -o -name '*.log' -o -name '*.out' -o -name '*.toc' -o -name '*.synctex.gz' \) -delete

