function [normalize_tendon_tension] = force_length_tendon(lt)
    %%%% TASK 1
    % Input Parameters
    %   lt: normalized length of tendon (series elastic element)
    % Output
    %   normalized tension produced by tendon
    lts = 1;
    if lt < lts
        normalize_tendon_tension = 0;
    else 
        normalize_tendon_tension = 10*(lt - lts) + 240*(lt - lts)^2;
    end
end