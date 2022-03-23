function [normalize_tendon_tension] = force_length_tendon(lt)

% lt: normalized length of tendon (series elastic element)
% Output
% normalized tension produced by tendon

% WRITE YOUR CODE HERE
global tendon_force_length_regression

if lt<=1;
    normalize_tendon_tension = 0;
else
    normalize_tendon_tension = feval(tendon_force_length_regression, lt);
end

end