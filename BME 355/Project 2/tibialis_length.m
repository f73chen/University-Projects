function [tibialis_anterior_length] = tibialis_length(~)
    % Inputs
    % theta: body angle (up from prone horizontal)
    
    % Output
    % tibialis anterior length
    
    % define rotation matrix
    % rotation = [cos(theta) -sin(theta) 
    %            sin(theta) cos(theta)];
    
    % coordinates in global reference frame
    % origin = rotation * [0.3 -0.03]';
    origin = [0.03 0.3]'; % same coordinate system as insertion
    insertion = [0.06, -0.03]';
    
    difference = origin - insertion;
    tibialis_anterior_length = sqrt(difference(1)^2 + difference(2)^2);
end