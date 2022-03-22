function [theta, toe_y] = GetTheta() % put fm back as input
    % Input 
    %   fm:       vector of muscle forces w/ sampling rate matching opensim data
    % Outputs
    %   theta:    vector of ankle angles (deg) wrt/ tibia frame of reference at each time step
    %   toe_y:    vector of toe heights (m) with respect to ground at each time step

    l_foot = 0.28635 - 0.07118; % length (m) of 50th percentile male foot (ankle to toe) 
    m_foot = 0.0145*85; % mass (kg) of 50th percentile US male foot
    g = 9.81; % gravity constant

    tibia_angle_l = readmatrix('data.xlsx', 'Sheet', 1, 'Range', 'G2:G74');
    ankle_ty = readmatrix('data.xlsx', 'Sheet', 1, 'Range', 'H2:H74');
    
    % testing
    fm = repelem(0.1950308, length(ankle_ty));
    fm = fm.'; % transpose to column vector

    arg = (fm.*0.03)./(m_foot*g*0.442*l_foot); % scalar multiplication and division to muscle force matrix

    foot_angle = asin(arg); % returns angles in rad
    foot_angle = rad2deg(foot_angle); % convert to deg
    theta = foot_angle - tibia_angle_l;
    
    toe_y = ankle_ty + sin(deg2rad(theta)).*l_foot;
end

% references
% male foot length (ankle to toe): https://www.researchgate.net/figure/Percentiles-of-Foot-Dimensions-mm_tbl1_327021689
% male foot mass = 0.0145M, where M = total body mass (from ME 598 course)
% male body mass: https://www.researchgate.net/figure/10th-50th-and-90th-mass-and-height-percentiles-for-male-and-female-adults-for-Caucasian_tbl1_51180593