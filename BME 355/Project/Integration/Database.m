% Store data from OpenSim
classdef Database < handle
    properties
        table
        tilt
        height
        t_sample
    end
    methods
        % Constructor
        function data = Database(filename)
            data.table = table2array(readtable(filename));
            data.tilt = data.table(:, 7);
            data.height = data.table(:, 8);
            data.t_sample = 0:1/60:1.2;
        end

        % Return interpolated tibia tilt
        function tilt = GetTilt(data, t)
            tilt = interp1(data.t_sample, data.tilt, t);
        end

        % Return interpolated tibia height
        function height = GetHeight(data, t)
            height = interp1(data.t_sample, data.height, t);
        end
    end
end
