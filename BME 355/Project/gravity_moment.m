function [moment] = gravity_moment(theta, t, model)
    % Inputs
    %   theta: ankle angle wrt. tibia
    % Output
    %   moment about ankle due to force of gravity on foot

    tibia_tilt = model.GetTilt(t);
    
    mass = 1.2325;      % Mass of foot
    l_foot = 0.21517;   % Length of foot
    centre_of_mass_distance = 0.442 * l_foot; % COM at 44.2% of the way
    g = 9.81;           % acceleration of gravity
    moment = mass * g * centre_of_mass_distance * cos(theta - tibia_tilt);
end
