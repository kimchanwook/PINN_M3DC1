function validate_registry()
%VALIDATE_REGISTRY Validate IDs, numbering, packages, and dependencies.

specs = pinn_m3dc1.common.registry();
ids = {specs.id};
numbers = [specs.number];
packages = {specs.package};
if numel(unique(ids)) ~= numel(ids)
    error('pinn_m3dc1:DuplicateModuleId', 'Module IDs must be unique.');
end
if numel(unique(numbers)) ~= numel(numbers)
    error('pinn_m3dc1:DuplicateModuleNumber', 'Module numbers must be unique.');
end
if numel(unique(packages)) ~= numel(packages)
    error('pinn_m3dc1:DuplicateModulePackage', 'Module package names must be unique.');
end
if ~isequal(sort(numbers), 1:numel(specs))
    error('pinn_m3dc1:InvalidModuleNumbers', ...
        'Module numbering must be contiguous and start at 1.');
end
for i = 1:numel(specs)
    unknown = setdiff(specs(i).dependencies, ids);
    if ~isempty(unknown)
        error('pinn_m3dc1:UnknownDependency', ...
            '%s has unknown dependencies: %s', specs(i).id, strjoin(unknown, ', '));
    end
    for j = 1:numel(specs(i).dependencies)
        depIndex = find(strcmp(ids, specs(i).dependencies{j}), 1, 'first');
        if specs(depIndex).number >= specs(i).number
            error('pinn_m3dc1:LateDependency', ...
                '%s depends on non-earlier module %s.', ...
                specs(i).id, specs(i).dependencies{j});
        end
    end
end
end

