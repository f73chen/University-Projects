% Store model from OpenSim
classdef OpenSim < handle
    properties
        table
        tilt
        height
        t_sample
    end
    methods
        % Constructor
        function model = OpenSim(filename)
            model.table = table2array(readtable(filename));
            model.tilt = model.table(:, 7);
            model.height = model.table(:, 8);
            model.t_sample = 0:1/60:1.2;
        end

        % Return interpolated tibia tilt
        function tilt = GetTilt(model, t)
            tilt = interp1(model.t_sample, model.tilt, t);
        end

        % Return interpolated tibia height
        function height = GetHeight(model, t)
            height = interp1(model.t_sample, model.height, t);
        end
    end
end
