function [normalize_PE_force] = force_length_parallel(lm)
    %%%% TASK 1
    % Input Parameters
    %   lm: normalized length of muscle (contractile element)
    % Output
    %   normalized force produced by parallel elastic element
    
    lpes = 1;
    normalize_PE_force = zeros(1, size(lm,2));
    for i = 1:size(lm,2)
        if lm(i) >= lpes
            normalize_PE_force(i) = 3*(lm(i) - lpes)^2 / (0.6 + lm(i) - lpes);
        end
    end
end