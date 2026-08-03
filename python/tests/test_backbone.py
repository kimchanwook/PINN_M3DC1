from __future__ import annotations

import importlib
import sys
import unittest
from pathlib import Path

SRC = Path(__file__).resolve().parents[1] / "src"
sys.path.insert(0, str(SRC))

from pinn_m3dc1 import MODULE_SPECS, ProjectState, nominal_startup_order
from pinn_m3dc1.common.registry import validate_registry
from pinn_m3dc1.common.scaffold import ScaffoldModule


class BackboneTests(unittest.TestCase):
    def test_registry_is_valid(self) -> None:
        validate_registry()
        self.assertEqual(len(MODULE_SPECS), 7)

    def test_nominal_order_is_numbered(self) -> None:
        self.assertEqual(nominal_startup_order(), tuple(f"module_{i}" for i in range(1, 8)))

    def test_shared_state_contract(self) -> None:
        state = ProjectState()
        module = ScaffoldModule(module_id="module_test", produced_marker="test_product")
        module.run(state)
        self.assertTrue(state.fields["test_product"])
        self.assertEqual(state.history[-1]["module"], "module_test")

    def test_missing_product_fails_loudly(self) -> None:
        state = ProjectState()
        module = ScaffoldModule(module_id="module_test", required_products=("missing",))
        with self.assertRaises(KeyError):
            module.run(state)

    def test_all_module_scaffolds_are_addressable(self) -> None:
        for spec in MODULE_SPECS:
            solver = importlib.import_module(f"pinn_m3dc1.{spec.package}.solver")
            module = solver.create()
            self.assertEqual(module.module_id, spec.id)


if __name__ == "__main__":
    unittest.main()

