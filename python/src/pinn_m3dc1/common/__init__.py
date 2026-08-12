"""Shared contracts for PINN_M3DC1."""

from .registry import MODULE_SPECS, nominal_startup_order
from .state import ProjectState

__all__ = ["MODULE_SPECS", "ProjectState", "nominal_startup_order"]

