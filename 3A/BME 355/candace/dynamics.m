function [x_dot] = dynamics(x, tibialis)
    % Inputs
    % x: state vector (ankle angle, angular velocity, TA normalized CE length)
    % tibialis: tibialis anterior muscle (HillTypeModel)
    
    % Output
    % x_dot: derivative of state vector
    
    % soleus_activation = 0.05;
    tibialis_activation = 0.4;
    ankle_inertia = 90;
    
    % WRITE CODE HERE TO IMPLEMENT THE MODEL
    tibialis_force = tibialis.get_force(tibialis_length(x(1)), x(3)); 
      
    x_dot = zeros(3,1); 
    x_dot(1) = x(2); 
    x_dot(2) = (tibialis_force*0.03 + gravity_moment(x(1))) / ankle_inertia; % 0.05 and 0.03 are moment arms 
      
    tibialis_norm_tendon_length = tibialis.norm_tendon_length(tibialis_length(x(1)), x(3)); 
    x_dot(3) = get_velocity(tibialis_activation, x(3), tibialis_norm_tendon_length);
end