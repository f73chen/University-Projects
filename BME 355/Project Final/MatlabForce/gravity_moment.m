function [moment] = gravity_moment(theta)

% Inputs
% theta: angle of body segment (up from prone)

% Output
% moment about ankle due to force of gravity on body

mass = 0.0145*85; % mass (kg) of 50th percentile US male foot
l = 0.28635 - 0.07118; % length (m) of 50th percentile male foot (ankle to toe) 
centre_of_mass_distance = 0.442*l; % distance from ankle to body segment centre of mass (m)
g = 9.81; % acceleration of gravity
moment = mass * g * centre_of_mass_distance * sin(theta);
end
