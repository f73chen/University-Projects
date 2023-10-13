function [x_dot] = dynamics(x, tibialis, a)

% Inputs
%  x: state vector (ankle angle, angular velocity, TA normalized CE length)
% tibialis: tibialis anterior muscle (HillTypeModel)

% Output
% x_dot: derivative of state vector

%tibialis_activation = 0.4;
ankle_inertia = 90;

%WRITE CODE HERE TO IMPLEMENT THE MODEL
tibialis_force = tibialis.get_force(tibialis_length(x(1)), x(3));
% The equation derives in the slides is:
% moment of inertia * angular velocity
% = tau soleus - tau tibialis anterior
% - external force * distance * sin theta
% - mass*gravity*distance from centre of mass * cos theta

% External Force = 0 so that term is eliminated
x_dot = zeros(3,1); 
x_dot(1) = x(2);
x_dot(2) = (tibialis_force*0.03 - gravity_moment(x(1))) / ankle_inertia; % 0.03 is moment arm

tibialis_norm_tendon_length = tibialis.norm_tendon_length(tibialis_length(x(1)), x(3)); 
x_dot(3) = get_velocity(a, x(3), tibialis_norm_tendon_length);


end