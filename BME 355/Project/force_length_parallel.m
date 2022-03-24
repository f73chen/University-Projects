function [normalize_PE_force] = force_length_parallel(lm)

% Input Parameters
% lm: normalized length of muscle (contractile element)
% Output
% normalized force produced by parallel elastic element

% WRITE YOUR CODE HERE
global parallel_force_length_regression 

normalize_PE_force = feval(parallel_force_length_regression, lm);

end
