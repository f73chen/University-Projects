function [x_dot] = dynamics(t, x, tibialis, model, type, amp, freq, duty, phase)
    % Inputs
    % x: state vector (ankle angle, angular velocity, soleus normalized CE length, TA normalized CE length)
    % soleus: soleus muscle (HillTypeModel)
    % tibialis: tibialis anterior muscle (HillTypeModel)
    
    % Output
    % x_dot: derivative of state vector
    
    % Get TA activation from FES
    tibialis_activation = GetMuscleActivationFromWaveform(t, type, amp, freq, duty, phase);

    % m = 1.2325 --> mass (kg) of 50th percentile US male foot
    % l = 0.21517 --> length (m) of 50th percentile male foot (ankle to toe) 
    % Approximate as a rod --> I = ml^2 / 3
    foot_inertia = 0.01902; % kg*m^2
    
    % WRITE CODE HERE TO IMPLEMENT THE MODEL
    tibialis_force = tibialis.get_force(tibialis_length(x(1)), x(3));
      
    x_dot = zeros(3,1); 
    x_dot(1) = x(2); 
    x_dot(2) = (tibialis_force*0.03 - gravity_moment(x(1), t, model)) / foot_inertia;

    tibialis_norm_tendon_length = tibialis.norm_tendon_length(tibialis_length(x(1)), x(3)); 
    x_dot(3) = get_velocity(tibialis_activation, x(3), tibialis_norm_tendon_length);
end