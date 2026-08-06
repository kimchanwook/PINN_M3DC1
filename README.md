# PINN_M3DC1

`PINN_M3DC1` is a modular proof-of-concept project for a physics-informed
neural-network surrogate of nonlinear resistive-MHD evolution of the kind
modeled by M3D-C1. `This work was conducted with the assistance of a large language model (LLM)`.

The first project stage does **not** run M3D-C1 and must not be described as a
validated replacement for it. It will generate numerical field arrays with an
independent two-dimensional reduced-MHD solver, compare a data-only surrogate
with a parameterized PINN, and preserve an interface through which genuine
M3D-C1 exports can later enter the same training and validation pipeline.

This repository follows the architecture of `Kinetic_MHD_PINN`: a living
project roadmap, shared documentation style, module-by-module physics and
implementation notes, mirrored Python and MATLAB trees, version-controlled
cases and configurations, explicit data contracts, tests, outputs, and
reference material.

## Current status

The version-0.1 repository backbone is established. Its module registry,
cross-module state contract, Python/MATLAB directory parity, configuration
skeleton, scientific claim hierarchy, and reduced-MHD sign conventions are
documented and tested. Physics notes for Modules 1 through 5 are complete under
`docs/physics_notes/`. Module 2 freezes the periodic island-coalescence case,
pseudo-spectral numerical method, diagnostics, and verification criteria.
Module 3 freezes the canonical HDF5 case schema, physical-case identities,
provenance, whole-case splits, learning-view normalization, versioning, and the
boundary between M3D-C1-shaped I/O and genuine M3D-C1 equivalence. Modules 4
and 5 freeze the controlled data-only-versus-PINN experiment before
implementation. No numerical MHD solver, data pipeline, or trained neural
surrogate is yet claimed as implemented. The first numerical milestone remains
Module 2: a verified periodic pseudo-spectral island-coalescence solver.

## Maintained architecture documents

- `README.md` - repository entry point and current status
- `project_plan.tex/.pdf` - living scientific and implementation roadmap
- `docs/project_charter.md` - claims, comparisons, validation rules, and scope
- `docs/equations_and_conventions.md` - frozen version-1 variables and signs
- `docs/shared/project_style.tex` - common LaTeX styling
- `docs/physics_notes/` - module-by-module physics notes; Modules 1 through 5 are complete
- `docs/implementation_notes/` - future module implementation contracts

## High-level code structure

- `python/` - primary data-generation and machine-learning implementation
- `matlab/` - independent parallel numerical implementation
- `python/src/pinn_m3dc1/` and `matlab/src/+pinn_m3dc1/` - matched module trees
- `python/cases/` and `matlab/cases/` - executable cases and demonstrations
- `python/tests/` and `matlab/tests/` - architecture and later physics tests
- `python/outputs/` and `matlab/outputs/` - generated run products
- `data/raw/` - immutable imported or generated source cases
- `data/processed/` - normalized learning-ready arrays and split manifests
- `data/reference/` - small frozen verification benchmarks
- `configs/` - version-controlled physical and training configurations
- `references/` - provenance notes and external-source inventory

## Module architecture

1. Reduced Resistive-MHD Physics and Conventions
2. Synthetic MHD Solver and Case Generation
3. Dataset Contracts and M3D-C1-Shaped I/O
4. Data-Only Surrogate Baseline
5. Physics-Informed Surrogate
6. Validation, Diagnostics, and Benchmarking
7. M3D-C1 Export Adapter and Transfer Learning

## Scientific comparison

The core experiment compares models on identical training cases, parameter
splits, data budgets, and approximately comparable network capacity.

| Model | Data loss | PDE/IC/BC losses | Role |
| --- | ---: | ---: | --- |
| Reduced-MHD solver | N/A | Numerical discretization | Synthetic reference |
| Data-only network | Yes | No | Fair neural baseline |
| Parameterized PINN | Yes | Yes | Test the value of physics constraints |

The initial map is

```text
(x, y, t, eta, nu, A0) -> (psi, U)
```

with derived current `J = -laplacian(psi)` and vorticity
`omega = laplacian(U)`. Complete parameter combinations, not randomly chosen
space-time points from every case, are held out for generalization tests.

## First numerical milestone

Module 2 is complete when one command generates a reproducible HDF5
island-coalescence case and diagnostics for `psi`, `U`, `J`, `omega`,
magnetic energy, kinetic energy, peak current, and reconnected flux. Grid/time
convergence and dissipative energy behavior must be checked before those cases
are used as learning targets.

## Python scaffold smoke test

```bash
cd python
python -m unittest discover -s tests -v
python cases/run_backbone_demo.py
```

## MATLAB scaffold smoke test

```matlab
cd matlab
addpath('src')
results = runtests('tests');
assert(all([results.Passed]));
addpath('cases')
run_backbone_demo
```

The repository-level `scripts/run_tests.sh` runs Python tests and uses MATLAB
automatically when the executable is available.
