function [normalize_PE_force] = force_length_parallel(lm)
    %%%% TASK 1
    % Input Parameters
    %   lm: normalized length of muscle (contractile element)
    % Output
    %   normalized force produced by parallel elastic element
    
    lpes = 1;
    % Create empty array
    normalize_PE_force = zeros(1, size(lm,2));
    % Only change tension when the parallel element is elongated
    for i = 1:size(lm,2)
        if lm(i) >= lpes
            normalize_PE_force(i) = 3*(lm(i) - lpes)^2 / (0.6 + lm(i) - lpes);
        end
    end
end