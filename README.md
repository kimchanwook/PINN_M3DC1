# PINN_M3DC1

`PINN_M3DC1` is a modular proof-of-concept project for a physics-informed
neural-network surrogate of nonlinear resistive-MHD evolution of the kind
modeled by M3D-C1. `This work was conducted with the assistance of a large language model (LLM)`.

The first project stage does **not** run M3D-C1 and must not be described as a
validated replacement for it. It will generate numerical field arrays with an
independent two-dimensional reduced-MHD solver, compare a data-only surrogate
with a parameterized PINN, and preserve an interface through which genuine
M3D-C1 exports can later enter the same training and validation pipeline.

The repository contains the project plan, physics notes, matching Python and
MATLAB folders, tests, settings, and output folders.

## Current status

The project now has five consecutive modules. Module 2 combines simulation and
data handling. Module 3 combines the old data-only baseline and physics-informed
training modules: the baseline is the same model trained with only the data
loss, while the physics-informed version turns on the reduced-MHD residual and
condition losses. The former Modules 6 and 7 are renumbered as Modules 4 and 5.
No MHD solver, data pipeline, or trained neural network is yet implemented.

## Maintained architecture documents

- `README.md` - repository entry point and current status
- `project_plan.tex/.pdf` - living scientific and implementation roadmap
- `docs/project_charter.md` - claims, comparisons, validation rules, and scope
- `docs/equations_and_conventions.md` - frozen version-1 variables and signs
- `docs/shared/project_style.tex` - common LaTeX styling
- `docs/physics_notes/` - physics notes for Modules 1, 2, and 3
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
2. Generate and Save MHD Simulation Data
3. Physics-Informed Surrogate, including the data-only baseline
4. Validation, Diagnostics, and Benchmarking
5. M3D-C1 Export Adapter and Transfer Learning

## Scientific comparison

The core experiment compares models on identical training cases, parameter
splits, data budgets, and approximately comparable network capacity.

| Model | Data loss | PDE/IC/BC losses | Role |
| --- | ---: | ---: | --- |
| Reduced-MHD solver | N/A | Numerical discretization | Synthetic reference |
| Data-only setting of Module 3 | Yes | No | Fair neural baseline |
| Physics-informed setting of Module 3 | Yes | Yes | Test the value of physics constraints |

The neural-network task is

```text
(psi_initial, U_initial, eta, nu, time) -> (psi, U) at that time
```

with derived current `J = -laplacian(psi)` and vorticity
`omega = laplacian(U)`. Complete simulations, not randomly selected times from
every simulation, are held out for testing.

## First numerical milestone

Module 2 is complete when one command runs and saves an island-coalescence
case, the numerical checks pass, and the saved file can be reopened without
changing or reordering the arrays.

Module 3 is complete when the same model can be trained first with only
`L_data`, then with the two PDE residual losses, the initial-condition loss,
and the gauge constraint turned on and reported separately.

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
