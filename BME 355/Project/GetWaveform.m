function [waveform] = GetWaveform(t, type, total_s, amp, freq, duty)
    % Input Parameters
    %   t:        time in seconds during the gait cycle
    %   type:     type of waveform (sine, square, trap)
    %   total_s:  number of seconds in one gait cycle
    %   amp:      amplitude - all waves
    %   freq:     frequency (Hz) - all waves
    %   duty:     duty cycle (int from 0 to 100) - square and trap waves
    % Output
    %   waveform: FES wave from t = 0 to 1 (percent of gait cycle)
    
    swing = total_s*0.6; % start of the swing phase 
    
    waveform = zeros(1, size(t, 2));
    for i = 1:size(t,2)
        if t(i) < swing
            waveform(i) = 0;
        else
            if strcmp(type, 'sine') 
                waveform(i) = amp * sin(freq*t(i));
            elseif strcmp(type, 'square') 
                waveform(i) = amp * square(freq*t(i), duty);
            elseif strcmp(type, 'trap') 
                margin = (total_s - swing)*(duty/100)/2;
                if t(i) < swing + margin
                    waveform(i) = (amp/margin)*t(i) - swing*amp/margin;
                elseif t(i) > total_s - margin
                    waveform(i) = -(amp/margin)*t(i) + amp/margin*total_s;
                else
                    waveform(i) = amp;
                end
            end
        end
    end
end