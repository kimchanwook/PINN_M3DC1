function specs = registry()
%REGISTRY Return the five active PINN_M3DC1 modules.

specs = repmat(struct('id', '', 'number', 0, 'name', '', 'package', '', ...
    'dependencies', {{}}, 'status', ''), 1, 5);
specs(1) = makeSpec('module_1', 1, 'Reduced Resistive-MHD Physics and Conventions', 'module1_reduced_mhd_physics_conventions', {}, 'scaffold');
specs(2) = makeSpec('module_2', 2, 'Generate and Save MHD Simulation Data', 'module2_generate_and_save_mhd_data', {'module_1'}, 'scaffold');
specs(3) = makeSpec('module_3', 3, 'Physics-Informed Surrogate', 'module3_physics_informed_surrogate', {'module_1', 'module_2'}, 'scaffold');
specs(4) = makeSpec('module_4', 4, 'Validation, Diagnostics, and Benchmarking', 'module4_validation_diagnostics_benchmarking', {'module_2', 'module_3'}, 'scaffold');
specs(5) = makeSpec('module_5', 5, 'M3D-C1 Export Adapter and Transfer Learning', 'module5_m3dc1_export_adapter_transfer_learning', {'module_1', 'module_2', 'module_3', 'module_4'}, 'scaffold');
end

function spec = makeSpec(id, number, name, package, dependencies, status)
spec = struct('id', id, 'number', number, 'name', name, ...
    'package', package, 'dependencies', {dependencies}, 'status', status);
end
