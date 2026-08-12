from __future__ import annotations

from dataclasses import dataclass

from .state import ProjectState


@dataclass
class ScaffoldModule:
    """Nonphysical placeholder used only to verify project wiring."""

    module_id: str
    required_products: tuple[str, ...] = ()
    produced_marker: str | None = None

    def run(self, state: ProjectState) -> ProjectState:
        state.require(*self.required_products)
        marker = self.produced_marker or f"{self.module_id}_scaffold_complete"
        state.publish(self.module_id, **{marker: True})
        return state

