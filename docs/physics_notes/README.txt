Physics notes follow the active modules defined in project_plan.tex. The project
now has five consecutive modules. Module 2 combines simulation and data
handling. Module 3 combines the data-only baseline and physics-informed
training because they use the same prediction problem and differ only in the
loss terms that are active.
A physics note must distinguish the reduced synthetic model from the full
extended-MHD capability of M3D-C1 and must include equations, assumptions,
normalization, boundary conditions, diagnostics, and known limitations.

Completed:

- Module 1: Reduced Resistive-MHD Physics and Conventions
  - module1_reduced_resistive_mhd_physics_and_conventions.pdf
  - module1_reduced_resistive_mhd_physics_and_conventions.tex
  - module1_foundations.tex

- Module 2: Generate and Save MHD Simulation Data
  - module2_generate_and_save_mhd_data.pdf
  - module2_generate_and_save_mhd_data.tex

- Module 3: Physics-Informed Surrogate, including the data-only baseline
  - module3_physics_informed_surrogate.pdf
  - module3_physics_informed_surrogate.tex

- Summary slides for Modules 1, 2, and 3
  - modules1_2_3_summary_slides.pdf
  - modules1_2_3_summary_slides.tex

Build Module 1 from this directory with:

  pdflatex module1_reduced_resistive_mhd_physics_and_conventions.tex
  pdflatex module1_reduced_resistive_mhd_physics_and_conventions.tex

Build Module 2 from this directory with:

  pdflatex module2_generate_and_save_mhd_data.tex
  pdflatex module2_generate_and_save_mhd_data.tex

Build Module 3 from this directory with:

  pdflatex module3_physics_informed_surrogate.tex
  pdflatex module3_physics_informed_surrogate.tex

Build the Module 1, 2, and 3 summary slides from this directory with:

  pdflatex modules1_2_3_summary_slides.tex
  pdflatex modules1_2_3_summary_slides.tex

The repository-level scripts/build_docs.sh builds the project plan and all
completed physics-note PDFs, then removes LaTeX intermediate files.
