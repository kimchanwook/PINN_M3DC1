Physics notes are organized by the seven modules defined in project_plan.tex.
A physics note must distinguish the reduced synthetic model from the full
extended-MHD capability of M3D-C1 and must include equations, assumptions,
normalization, boundary conditions, diagnostics, and known limitations.

Completed:

- Module 1: Reduced Resistive-MHD Physics and Conventions
  - module1_reduced_resistive_mhd_physics_and_conventions.pdf
  - module1_reduced_resistive_mhd_physics_and_conventions.tex
  - module1_foundations.tex

- Module 2: Synthetic MHD Solver and Case Generation
  - module2_synthetic_mhd_solver_and_case_generation.pdf
  - module2_synthetic_mhd_solver_and_case_generation.tex

- Module 3: Dataset Contracts and M3D-C1-Shaped Input/Output
  - module3_dataset_contracts_and_m3dc1_shaped_io.pdf
  - module3_dataset_contracts_and_m3dc1_shaped_io.tex

- Module 4: Data-Only Parameterized Surrogate Baseline
  - module4_data_only_surrogate_baseline.pdf
  - module4_data_only_surrogate_baseline.tex

- Module 5: Physics-Informed Surrogate
  - module5_physics_informed_surrogate.pdf
  - module5_physics_informed_surrogate.tex

- Summary slides for Modules 1 through 5
  - modules1_2_3_4_5_summary_slides.pdf
  - modules1_2_3_4_5_summary_slides.tex

Build Module 1 from this directory with:

  pdflatex module1_reduced_resistive_mhd_physics_and_conventions.tex
  pdflatex module1_reduced_resistive_mhd_physics_and_conventions.tex

Build Module 4 from this directory with:

  pdflatex module4_data_only_surrogate_baseline.tex
  pdflatex module4_data_only_surrogate_baseline.tex

Build Module 2 from this directory with:

  pdflatex module2_synthetic_mhd_solver_and_case_generation.tex
  pdflatex module2_synthetic_mhd_solver_and_case_generation.tex

Build Module 3 from this directory with:

  pdflatex module3_dataset_contracts_and_m3dc1_shaped_io.tex
  pdflatex module3_dataset_contracts_and_m3dc1_shaped_io.tex

Build Module 5 from this directory with:

  pdflatex module5_physics_informed_surrogate.tex
  pdflatex module5_physics_informed_surrogate.tex

Build the Module 1 through 5 summary slides from this directory with:

  pdflatex modules1_2_3_4_5_summary_slides.tex
  pdflatex modules1_2_3_4_5_summary_slides.tex

The repository-level scripts/build_docs.sh builds the project plan and all
completed physics-note PDFs, then removes LaTeX intermediate files.
