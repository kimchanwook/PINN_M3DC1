from __future__ import annotations

import sys
from pathlib import Path

SRC = Path(__file__).resolve().parents[1] / "src"
sys.path.insert(0, str(SRC))

from pinn_m3dc1 import MODULE_SPECS, ProjectState, nominal_startup_order
from pinn_m3dc1.common.registry import validate_registry


def main() -> None:
    validate_registry()
    state = ProjectState(metadata={"purpose": "architecture smoke test"})
    print("PINN_M3DC1 Python backbone")
    print("Nominal startup order:")
    for module_id in nominal_startup_order():
        spec = next(item for item in MODULE_SPECS if item.id == module_id)
        print(f"  {spec.number:02d}. {spec.name} [{spec.status}]")
        state.publish(module_id, **{f"{module_id}_registered": True})
    print(f"Registered {len(state.history)} module transitions.")
    print("No physics solver or neural model was executed; this is an interface-only smoke test.")


if __name__ == "__main__":
    main()

