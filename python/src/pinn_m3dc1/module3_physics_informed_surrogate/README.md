# Module 3: Physics-Informed Surrogate

Status: physics notes complete; implementation scaffold.

Purpose: train one field-to-field surrogate. Using only the field-data loss
creates the baseline; adding the reduced-MHD residual, initial-condition, and
gauge losses creates the physics-informed version.

The loss construction is documented in
`docs/physics_notes/module3_physics_informed_surrogate.pdf`. This directory
still defines only the module interface. It must not be reported as an
implemented or trained surrogate until the implementation and tests exist.
