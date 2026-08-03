function specs = registry()
%REGISTRY Return the seven-module PINN_M3DC1 registry.

specs = repmat(struct('id', '', 'number', 0, 'name', '', 'package', '', ...
    'dependencies', {{}}, 'status', ''), 1, 7);
specs(1) = makeSpec('module_1', 1, 'Reduced Resistive-MHD Physics and Conventions', 'module1_reduced_mhd_physics_conventions', {}, 'scaffold');
specs(2) = makeSpec('module_2', 2, 'Synthetic MHD Solver and Case Generation', 'module2_synthetic_mhd_solver_case_generation', {'module_1'}, 'scaffold');
specs(3) = makeSpec('module_3', 3, 'Dataset Contracts and M3D-C1-Shaped I/O', 'module3_dataset_contracts_m3dc1_io', {'module_1', 'module_2'}, 'scaffold');
specs(4) = makeSpec('module_4', 4, 'Data-Only Surrogate Baseline', 'module4_data_only_surrogate_baseline', {'module_3'}, 'scaffold');
specs(5) = makeSpec('module_5', 5, 'Physics-Informed Surrogate', 'module5_physics_informed_surrogate', {'module_1', 'module_3', 'module_4'}, 'scaffold');
specs(6) = makeSpec('module_6', 6, 'Validation, Diagnostics, and Benchmarking', 'module6_validation_diagnostics_benchmarking', {'module_2', 'module_3', 'module_4', 'module_5'}, 'scaffold');
specs(7) = makeSpec('module_7', 7, 'M3D-C1 Export Adapter and Transfer Learning', 'module7_m3dc1_export_adapter_transfer_learning', {'module_1', 'module_3', 'module_4', 'module_5', 'module_6'}, 'scaffold');
end

function spec = makeSpec(id, number, name, package, dependencies, status)
spec = struct('id', id, 'number', number, 'name', name, ...
    'package', package, 'dependencies', {dependencies}, 'status', status);
end

