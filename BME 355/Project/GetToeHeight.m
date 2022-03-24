function toe_height = GetToeHeight(model, t, theta_prime)
    % Parameters
    %   model:  OpenSim model containing reference data
    %   t:      current time frame in range [0, 1.2]
    %   theta_prime: current ankle angle wrt. tibia (radians)
    % Outputs
    %   toe_y:  toe height (m) wrt ground at current time

    l_foot = 0.21517;   % length (m) of 50th percentile male foot (ankle to toe)

    tibia_angle = model.GetTilt(t);     % Read the current tibia tilt
    tibia_height = model.GetHeight(t);  % Read the current tibia height
    
    theta = theta_prime - tibia_angle;  % Ankle angle wrt. ground
    toe_height = tibia_height + l_foot * sin(theta);
end

% references
% male foot length (ankle to toe): https://www.researchgate.net/figure/Percentiles-of-Foot-Dimensions-mm_tbl1_327021689
% male foot mass = 0.0145*M, where M = total body mass (from ME 598 course)
% male body mass: https://www.researchgate.net/figure/10th-50th-and-90th-mass-and-height-percentiles-for-male-and-female-adults-for-Caucasian_tbl1_51180593