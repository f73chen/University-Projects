function [x_dot] = dynamics(x, soleus, tibialis)

% Inputs
%  x: state vector (ankle angle, angular velocity, soleus normalized CE length, TA normalized CE length)
% soleus: soleus muscle (HillTypeModel)
% tibialis: tibialis anterior muscle (HillTypeModel)

% Output
% x_dot: derivative of state vector

soleus_activation = 0.05;
tibialis_activation = 0.4;
ankle_inertia = 90;

%WRITE CODE HERE TO IMPLEMENT THE MODEL

end