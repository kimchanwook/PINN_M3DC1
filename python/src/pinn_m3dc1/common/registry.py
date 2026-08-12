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
    ModuleSpec(id="module_2", number=2, name="Generate and Save MHD Simulation Data", package="module2_generate_and_save_mhd_data", dependencies=("module_1",), status="scaffold"),
    ModuleSpec(id="module_3", number=3, name="Physics-Informed Surrogate", package="module3_physics_informed_surrogate", dependencies=("module_1", "module_2"), status="scaffold"),
    ModuleSpec(id="module_4", number=4, name="Validation, Diagnostics, and Benchmarking", package="module4_validation_diagnostics_benchmarking", dependencies=("module_2", "module_3"), status="scaffold"),
    ModuleSpec(id="module_5", number=5, name="M3D-C1 Export Adapter and Transfer Learning", package="module5_m3dc1_export_adapter_transfer_learning", dependencies=("module_1", "module_2", "module_3", "module_4"), status="scaffold"),
)

RETIRED_MODULE_NUMBERS: tuple[int, ...] = ()


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
    expected_numbers = set(range(1, max(numbers) + 1)) - set(RETIRED_MODULE_NUMBERS)
    if set(numbers) != expected_numbers:
        raise ValueError("Active module numbers must be consecutive")

    known = set(ids)
    position = {spec.id: spec.number for spec in MODULE_SPECS}
    for spec in MODULE_SPECS:
        unknown = set(spec.dependencies) - known
        if unknown:
            raise ValueError(f"{spec.id} has unknown dependencies: {sorted(unknown)}")
        late = [dep for dep in spec.dependencies if position[dep] >= spec.number]
        if late:
            raise ValueError(f"{spec.id} depends on non-earlier modules: {sorted(late)}")
