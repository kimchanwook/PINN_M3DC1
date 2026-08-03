from __future__ import annotations

from dataclasses import dataclass


@dataclass(frozen=True)
class ModuleSpec:
    id: str
    number: int
    name: str
    package: str
    dependencies: tuple[str, ...]
    status: str


MODULE_SPECS: tuple[ModuleSpec, ...] = (
    ModuleSpec(id="module_1", number=1, name="Reduced Resistive-MHD Physics and Conventions", package="module1_reduced_mhd_physics_conventions", dependencies=(), status="scaffold"),
    ModuleSpec(id="module_2", number=2, name="Synthetic MHD Solver and Case Generation", package="module2_synthetic_mhd_solver_case_generation", dependencies=("module_1",), status="scaffold"),
    ModuleSpec(id="module_3", number=3, name="Dataset Contracts and M3D-C1-Shaped I/O", package="module3_dataset_contracts_m3dc1_io", dependencies=("module_1", "module_2"), status="scaffold"),
    ModuleSpec(id="module_4", number=4, name="Data-Only Surrogate Baseline", package="module4_data_only_surrogate_baseline", dependencies=("module_3",), status="scaffold"),
    ModuleSpec(id="module_5", number=5, name="Physics-Informed Surrogate", package="module5_physics_informed_surrogate", dependencies=("module_1", "module_3", "module_4"), status="scaffold"),
    ModuleSpec(id="module_6", number=6, name="Validation, Diagnostics, and Benchmarking", package="module6_validation_diagnostics_benchmarking", dependencies=("module_2", "module_3", "module_4", "module_5"), status="scaffold"),
    ModuleSpec(id="module_7", number=7, name="M3D-C1 Export Adapter and Transfer Learning", package="module7_m3dc1_export_adapter_transfer_learning", dependencies=("module_1", "module_3", "module_4", "module_5", "module_6"), status="scaffold"),
)


def nominal_startup_order() -> tuple[str, ...]:
    """Return deterministic initialization order for scaffold checks."""
    return tuple(spec.id for spec in sorted(MODULE_SPECS, key=lambda item: item.number))


def validate_registry() -> None:
    ids = [spec.id for spec in MODULE_SPECS]
    numbers = [spec.number for spec in MODULE_SPECS]
    packages = [spec.package for spec in MODULE_SPECS]
    if len(ids) != len(set(ids)):
        raise ValueError("Module IDs must be unique")
    if len(numbers) != len(set(numbers)):
        raise ValueError("Module numbers must be unique")
    if len(packages) != len(set(packages)):
        raise ValueError("Module package names must be unique")
    if sorted(numbers) != list(range(1, len(MODULE_SPECS) + 1)):
        raise ValueError("Module numbering must be contiguous and start at 1")

    known = set(ids)
    position = {spec.id: spec.number for spec in MODULE_SPECS}
    for spec in MODULE_SPECS:
        unknown = set(spec.dependencies) - known
        if unknown:
            raise ValueError(f"{spec.id} has unknown dependencies: {sorted(unknown)}")
        late = [dep for dep in spec.dependencies if position[dep] >= spec.number]
        if late:
            raise ValueError(f"{spec.id} depends on non-earlier modules: {sorted(late)}")

