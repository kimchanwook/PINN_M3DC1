classdef ProjectState < handle
    %PROJECTSTATE Named cross-module products with publication history.

    properties
        fields = struct()
        metadata = struct()
        history = {}
    end

    methods
        function obj = ProjectState(metadata)
            if nargin >= 1
                if ~isstruct(metadata)
                    error('pinn_m3dc1:InvalidMetadata', ...
                        'metadata must be a structure.');
                end
                obj.metadata = metadata;
            end
        end

        function require(obj, varargin)
            names = varargin;
            if numel(names) == 1 && iscell(names{1})
                names = names{1};
            end
            missing = {};
            for i = 1:numel(names)
                name = char(names{i});
                if ~isfield(obj.fields, name)
                    missing{end + 1} = name; %#ok<AGROW>
                end
            end
            if ~isempty(missing)
                error('pinn_m3dc1:MissingProducts', ...
                    'Missing required state products: %s', strjoin(missing, ', '));
            end
        end

        function publish(obj, moduleId, varargin)
            if isempty(varargin) || mod(numel(varargin), 2) ~= 0
                error('pinn_m3dc1:InvalidPublishArguments', ...
                    'At least one product name-value pair is required.');
            end
            productNames = cell(1, numel(varargin) / 2);
            for i = 1:2:numel(varargin)
                name = char(varargin{i});
                if ~isvarname(name)
                    error('pinn_m3dc1:InvalidProductName', ...
                        'Invalid MATLAB product name: %s', name);
                end
                obj.fields.(name) = varargin{i + 1};
                productNames{(i + 1) / 2} = name;
            end
            obj.history{end + 1} = struct( ...
                'module', char(moduleId), 'products', {productNames});
        end
    end
end

