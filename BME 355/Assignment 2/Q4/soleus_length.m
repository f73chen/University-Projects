function [soleus_length] = soleus_length(theta)

% Inputs
% theta: body angle (up from prone horizontal)

% Output
% soleus length

% define rotation matrix
rotation = [cos(theta) sin(theta) 
   sin(theta) cos(theta)];

% coordinates in global reference frame
origin = rotation * [0.3 0.03]';
insertion = [-0.05, -0.02]';

difference = origin - insertion;
soleus_length = sqrt(difference(1)^2 + difference(2)^2);

end
