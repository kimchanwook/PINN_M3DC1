#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

cleanup_latex_intermediates() {
  find "$ROOT" -type f \( -name '*.aux' -o -name '*.fdb_latexmk' -o -name '*.fls' -o -name '*.log' -o -name '*.out' -o -name '*.toc' -o -name '*.synctex.gz' \) -delete
}

# Stale or interrupted LaTeX intermediates can make an otherwise valid source
# fail before latexmk has a chance to regenerate its dependency files.
cleanup_latex_intermediates
trap cleanup_latex_intermediates EXIT

latexmk -pdf -interaction=nonstopmode -halt-on-error project_plan.tex
(
  cd docs/physics_notes
  latexmk -pdf -interaction=nonstopmode -halt-on-error module1_reduced_resistive_mhd_physics_and_conventions.tex
  latexmk -pdf -interaction=nonstopmode -halt-on-error module4_data_only_surrogate_baseline.tex
  latexmk -pdf -interaction=nonstopmode -halt-on-error module5_physics_informed_surrogate.tex
)

# A successful TeX process should still leave a structurally readable PDF.
# Validate every maintained deliverable before removing the diagnostic logs.
if command -v pdfinfo >/dev/null 2>&1; then
  pdfinfo project_plan.pdf >/dev/null
  pdfinfo docs/physics_notes/module1_reduced_resistive_mhd_physics_and_conventions.pdf >/dev/null
  pdfinfo docs/physics_notes/module4_data_only_surrogate_baseline.pdf >/dev/null
  pdfinfo docs/physics_notes/module5_physics_informed_surrogate.pdf >/dev/null
fi
cleanup_latex_intermediates
trap - EXIT
