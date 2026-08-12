from pinn_m3dc1.common.scaffold import ScaffoldModule


def create() -> ScaffoldModule:
    """Return the Module 1 interface scaffold."""
    return ScaffoldModule(module_id="module_1")

