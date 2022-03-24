function [normalize_tendon_tension] = force_length_tendon(lt)
    %%%% TASK 1
    % Input Parameters
    %   lt: normalized length of tendon (series elastic element)
    % Output
    %   normalized tension produced by tendon
    
    slack_length = 1; 
    tight = lt >= slack_length; 
    normalize_tendon_tension = tight.*(10 * (lt - slack_length) + 240 * (lt - slack_length).^2); 
end