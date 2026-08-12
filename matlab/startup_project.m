function startup_project()
%STARTUP_PROJECT Add PINN_M3DC1 MATLAB source and cases to the path.

matlabRoot = fileparts(mfilename('fullpath'));
addpath(fullfile(matlabRoot, 'src'));
addpath(fullfile(matlabRoot, 'cases'));
fprintf('PINN_M3DC1 MATLAB paths added from %s\n', matlabRoot);
end

