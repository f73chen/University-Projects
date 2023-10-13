function [x_dot] = dynamics(x, soleus, tibialis)
    % Inputs
    % x: state vector (ankle angle, angular velocity, soleus normalized CE length, TA normalized CE length)
    % soleus: soleus muscle (HillTypeModel)
    % tibialis: tibialis anterior muscle (HillTypeModel)
    
    % Output
    % x_dot: derivative of state vector
    
    soleus_activation = 0.05;
    tibialis_activation = 0.4;
    ankle_inertia = 90;
    
    %WRITE CODE HERE TO IMPLEMENT THE MODEL

    % Assume no external force --> f_ext = 0
    % Based on the equation from "Musculoskeletal System with Hill-Type Muscles"
    soleus_moment_arm = 0.05;
    tibialis_moment_arm = 0.03;
    tau_s  = soleus.f0M * soleus.get_force(soleus_length(x(1)), x(3)) * soleus_moment_arm;
    tau_ta = tibialis.f0M * tibialis.get_force(tibialis_length(x(1)), x(4)) * tibialis_moment_arm;

    x_dot = [x(2);
             (tau_s - tau_ta + gravity_moment(x(1))) / ankle_inertia;
             get_velocity(soleus_activation, x(3), soleus.norm_tendon_length(soleus_length(x(1)), x(3)));
             get_velocity(tibialis_activation, x(4), tibialis.norm_tendon_length(tibialis_length(x(1)), x(4)))];
end