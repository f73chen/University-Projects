function [normalize_tendon_tension] = force_length_tendon(lt)
    %%%% TASK 1
    % Input Parameters
    %   lt: normalized length of tendon (series elastic element)
    % Output
    %   normalized tension produced by tendon
    
    lts = 1;
    normalize_tendon_tension = zeros(1, size(lt,2));
    for i = 1:size(lt,2)
        if lt(i) >= lts
            normalize_tendon_tension(i) = 10*(lt(i) - lts) + 240*(lt(i) - lts)^2;
        end
    end
end