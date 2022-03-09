function [normalize_PE_force] = force_length_parallel(lm)
    %%%% TASK 1
    % Input Parameters
    %   lm: normalized length of muscle (contractile element)
    % Output
    %   normalized force produced by parallel elastic element
    lpes = 1;
    if lm < lpes
        normalize_PE_force = 0;
    else
        normalize_PE_force = 3*(lm - lpes)^2 / (0.6 + lm - lpes);
    end
end