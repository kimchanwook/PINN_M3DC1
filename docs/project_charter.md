# Project charter

## 1. Claim hierarchy

The project keeps three claims separate.

### Claim A: reduced-MHD proof of concept

A parameterized PINN can reproduce selected nonlinear resistive-MHD field
evolution from independently generated synthetic data while satisfying a stated
two-field model. Version 1 can test this claim directly.

### Claim B: M3D-C1-shaped workflow

The inputs, outputs, parameterization, diagnostics, and data interface
demonstrate how the workflow could be applied to M3D-C1 exports. This is an
interface demonstration, not M3D-C1 validation.

### Claim C: validated M3D-C1 surrogate

A trained model predicts actual M3D-C1 output over a defined domain of
equilibria, closures, transport coefficients, perturbations, meshes, and time.
This claim requires genuine M3D-C1 train/validation/test cases and is outside
the initial synthetic stage.

## 2. Initial physical problem

Version 1 uses incompressible two-field reduced resistive MHD on a periodic
square. The state contains magnetic flux `psi`, flow stream function `U`,
current `J`, and vorticity `omega`. The primary nonlinear benchmark is
magnetic-island coalescence because it exercises advection, resistive
reconnection, current-sheet formation, nonlinear time evolution, and
parameter dependence without claiming full extended-MHD fidelity.

The case settings begin with

```text
mu = (eta, nu, A0)
```

for resistivity, viscosity, and perturbation amplitude. The surrogate learns

```text
(psi_initial, U_initial, eta, nu, time) -> (psi, U) at that time.
```

## 3. Training-data standard

Screenshots and published plots are visualization references only. They are not
acceptable training targets because they discard numerical precision, mesh
coordinates, normalization, variable definitions, and usually most of the
evolved state.

Each numerical case must instead store coordinates, time, fields, physical
parameters, grid and time-step metadata, normalization, sign convention,
initial/boundary conditions, solver version, diagnostic histories, and split
assignment. HDF5 is the preferred field container; TOML or JSON records the
case manifest.

## 4. Fair model comparison

Module 3 contains both settings of the comparison. The data-only baseline uses
the field-data loss alone. The physics-informed setting uses the same inputs,
outputs, cases, and model family but adds the two reduced-MHD residual losses,
the initial-condition loss, and the stream-function gauge. Optional global
constraints are tested separately. Whole parameter combinations are held out.
A random time split across every trajectory would test interpolation within
already-seen cases and is not sufficient evidence of a reusable surrogate.

## 5. Loss construction

The documented objective is

```text
L = w_data L_data
  + w_psi L_PDE,psi + w_omega L_PDE,omega
  + w_ic L_ic + w_gauge L_gauge
  + optional global terms.
```

For the periodic Fourier representation, the boundary condition is built in,
so `L_bc = 0`. Current, vorticity, incompressibility, and magnetic divergence
are also enforced through the chosen field definitions rather than extra loss
terms.

Weights are selected using nondimensionalization, gradient-scale monitoring,
validation metrics, and ablation studies. Merely making numerical loss values
similar is not a physical justification.

## 6. Validation hierarchy

1. Verify the conventional solver with manufactured/analytic limits,
   grid/time-step convergence, periodicity, and energy behavior.
2. Validate the data-only and PINN models on identical unseen parameter cases.
3. Report field errors for `psi`, `U`, `J`, and `omega`.
4. Report magnetic/kinetic energy, peak current, reconnection rate, and PDE
   residual histories.
5. Separate parameter interpolation from extrapolation.
6. State the exact parameter and time domain over which accuracy was measured.
7. Compare training cost, inference cost, solver cost, and break-even query
   count without counting training as free.
8. Re-run the full validation suite when genuine M3D-C1 data replace synthetic
   cases.

## 7. Definition of success

The initial project succeeds if it shows, under a reproducible held-out-case
experiment, whether the PINN improves data efficiency, field accuracy, or
physical admissibility relative to the fair data-only baseline. A negative or
mixed result is scientifically valid. The project does not succeed merely
because the PINN produces visually plausible contours.

## 8. Near-term deliverables

- frozen reduced-MHD equations and signs;
- verified island-coalescence synthetic solver;
- versioned HDF5 data contract and split manifest;
- Module 3 data-only setting using `L_data` alone;
- Module 3 physics-informed setting with the two PDE residuals and conditions;
- ablation and generalization report;
- M3D-C1 export schema and adapter tests.
