function [moment] = gravity_moment(theta)
    % Inputs
    % theta: angle of body segment (up from prone)
    
    % Output
    % moment about ankle due to force of gravity on body
    
    mass = 1.2325; % foot mass
    l_foot = 0.21517; % length of foot
    centre_of_mass_distance = 0.442 * l_foot; % distance from ankle to body segment centre of mass (m)
    g = 9.81; % acceleration of gravity
    moment = mass * g * centre_of_mass_distance * cos(theta);
end
