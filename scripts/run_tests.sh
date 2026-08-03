#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

cd "$ROOT/python"
python -m unittest discover -s tests -v
python cases/run_backbone_demo.py

if command -v matlab >/dev/null 2>&1; then
  matlab -batch "cd('$ROOT/matlab'); addpath('src'); results = runtests('tests'); disp(results); assert(all([results.Passed])); addpath('cases'); run_backbone_demo"
else
  echo "MATLAB executable not found; MATLAB source and tests were not executed."
fi

