function [normalize_PE_force] = force_length_parallel(lm)
    %%%% TASK 1
    % Input Parameters
    %   lm: normalized length of muscle (contractile element)
    % Output
    %   normalized force produced by parallel elastic element
    
    slack_length = 1; 
    tight = lm > slack_length; 
    normalize_PE_force = tight .* (3 * (lm - slack_length).^2 ./ max(1e-6, 0.6 + lm - slack_length));
end