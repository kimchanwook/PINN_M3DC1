Physics notes are organized by the seven modules defined in project_plan.tex.
A physics note must distinguish the reduced synthetic model from the full
extended-MHD capability of M3D-C1 and must include equations, assumptions,
normalization, boundary conditions, diagnostics, and known limitations.

Completed:

- Module 1: Reduced Resistive-MHD Physics and Conventions
  - module1_reduced_resistive_mhd_physics_and_conventions.pdf
  - module1_reduced_resistive_mhd_physics_and_conventions.tex
  - module1_foundations.tex

- Module 4: Data-Only Parameterized Surrogate Baseline
  - module4_data_only_surrogate_baseline.pdf
  - module4_data_only_surrogate_baseline.tex

- Module 5: Physics-Informed Surrogate
  - module5_physics_informed_surrogate.pdf
  - module5_physics_informed_surrogate.tex

Build Module 1 from this directory with:

  pdflatex module1_reduced_resistive_mhd_physics_and_conventions.tex
  pdflatex module1_reduced_resistive_mhd_physics_and_conventions.tex

Build Module 4 from this directory with:

  pdflatex module4_data_only_surrogate_baseline.tex
  pdflatex module4_data_only_surrogate_baseline.tex

Build Module 5 from this directory with:

  pdflatex module5_physics_informed_surrogate.tex
  pdflatex module5_physics_informed_surrogate.tex

The repository-level scripts/build_docs.sh builds the project plan and all
completed physics-note PDFs, then removes LaTeX intermediate files.
