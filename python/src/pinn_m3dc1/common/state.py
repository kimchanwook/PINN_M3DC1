from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any


@dataclass
class ProjectState:
    """Named cross-module state products with auditable publication history."""

    fields: dict[str, Any] = field(default_factory=dict)
    metadata: dict[str, Any] = field(default_factory=dict)
    history: list[dict[str, Any]] = field(default_factory=list)

    def require(self, *names: str) -> None:
        missing = [name for name in names if name not in self.fields]
        if missing:
            raise KeyError(f"Missing required state products: {missing}")

    def publish(self, module_id: str, **products: Any) -> None:
        if not products:
            raise ValueError("At least one named product must be published")
        self.fields.update(products)
        self.history.append({"module": module_id, "products": tuple(products)})

