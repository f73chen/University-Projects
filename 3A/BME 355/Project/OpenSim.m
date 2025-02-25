% Store model from OpenSim
classdef OpenSim < handle
    properties
        table
        tilt
        height
        ankle_angle
        t_sample
    end
    methods
        % Constructor
        function model = OpenSim(filename)
            model.table = table2array(readtable(filename));
            model.ankle_angle = model.table(:, 6);
            model.tilt = model.table(:, 7);
            model.height = model.table(:, 8);
            model.t_sample = 0:1/60:1.2;
        end

        % Return interpolated tibia tilt
        function tilt = GetTilt(model, t)
            if t < 0
                tilt = model.tilt(1);
            elseif t > 1.2
                tilt = model.tilt(end);
            else
                tilt = interp1(model.t_sample, model.tilt, t);
            end
        end

        % Return interpolated tibia height
        function height = GetHeight(model, t)
            if t < 0
                height = model.height(1);
            elseif t > 1.2
                height = model.height(end);
            else
                height = interp1(model.t_sample, model.height, t);
            end
        end

        % Return reference ankle angle
        function height = GetAnkleAngle(model, t)
            if t < 0
                height = model.ankle_angle(1);
            elseif t > 1.2
                height = model.ankle_angle(end);
            else
                height = interp1(model.t_sample, model.ankle_angle, t);
            end
        end
    end
end
