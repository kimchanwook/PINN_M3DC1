# Reduced-MHD equations and conventions

This file freezes the version-1 computational convention. Any change that
alters stored field meaning requires a dataset schema/version change.

## Domain and bracket

The domain is periodic in both directions:

```text
(x, y) in [0, Lx) x [0, Ly).
```

The Poisson bracket is

```text
[f, g] = (d f/dx)(d g/dy) - (d f/dy)(d g/dx).
```

## Primary and derived fields

The network and reference solver evolve `psi(x,y,t)` and `U(x,y,t)`.

```text
B_perp = grad(psi) x zhat = ( psi_y, -psi_x)
v_perp = zhat x grad(U)   = (-U_y,     U_x)
J       = -laplacian(psi)
omega   =  laplacian(U)
```

With these definitions, `div(B_perp) = div(v_perp) = 0` identically.

## Evolution equations

```text
psi_t   + [U, psi]   = eta laplacian(psi)
omega_t + [U, omega] = [J, psi] + nu laplacian(omega)
J                     = -laplacian(psi)
omega                 =  laplacian(U)
```

Equivalently, the PINN residuals are

```text
R_psi   = psi_t + [U, psi] - eta laplacian(psi)
R_omega = omega_t + [U, omega] - [J, psi] - nu laplacian(omega).
```

All variables are nondimensional in version 1. The normalization scales must
be stored in case metadata even when their numerical values are unity.

## Boundary and gauge conditions

- `psi`, `U`, and their required derivatives are periodic in `x` and `y`.
- The spatial mean of `U` is fixed to zero because only its derivatives affect
  velocity.
- The spatial mean of `psi` is recorded and held consistent across a case.
- Spectral zero modes are handled explicitly when inverting
  `laplacian(U) = omega`.

## Mandatory convention tests

- spectral derivatives of known Fourier modes;
- `div(B_perp)` and `div(v_perp)` near numerical precision;
- bracket antisymmetry and `[f,f] = 0`;
- `J = -laplacian(psi)` and `omega = laplacian(U)`;
- periodic value and derivative matching;
- ideal-limit invariants and resistive/viscous dissipation trends.

