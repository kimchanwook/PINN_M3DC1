classdef ScaffoldModule
    %SCAFFOLDMODULE Nonphysical placeholder used only to verify wiring.

    properties
        moduleId = ''
        requiredProducts = {}
        producedMarker = ''
    end

    methods
        function obj = ScaffoldModule(moduleId, requiredProducts, producedMarker)
            if nargin >= 1
                obj.moduleId = char(moduleId);
            end
            if nargin >= 2
                obj.requiredProducts = requiredProducts;
            end
            if nargin >= 3
                obj.producedMarker = char(producedMarker);
            end
        end

        function state = run(obj, state)
            if ~isa(state, 'pinn_m3dc1.common.ProjectState')
                error('pinn_m3dc1:InvalidState', ...
                    'state must be a pinn_m3dc1.common.ProjectState object.');
            end
            state.require(obj.requiredProducts);
            marker = obj.producedMarker;
            if isempty(marker)
                marker = [obj.moduleId '_scaffold_complete'];
            end
            state.publish(obj.moduleId, marker, true);
        end
    end
end

