function [waveform] = GetWaveform(type, total_s, amp, freq, duty)
    % Input Parameters
    %   type:     type of waveform (sine, square, trap)
    %   total_s:  number of seconds in one gait cycle
    %   amp:      amplitude - all waves
    %   freq:     frequency (Hz) - all waves
    %   duty:     duty cycle (int from 0 to 100) - square and trap waves
    % Output
    %   waveform: FES wave from t = 0 to 1 (percent of gait cycle)
    
    t = 0:0.01:s;  % x axis range for one gait cycle
    swing = total_s*0.6; % start of the swing phase 
    
    function y = wave(x)
        if x < swing
            y = 0;
        else
            if strcmp(type, 'sine') 
                y = amp * sin(freq*x);
            elseif strcmp(type, 'square') 
                y = amp * square(freq*x, duty);
            elseif strcmp(type, 'trap') 
                margin = (total_s - swing)*(duty/100)/2;
                if x < swing + margin
                    y = (amp/margin)*x - swing*amp/margin;
                elseif x > total_s - margin
                    y = -(amp/margin)*x + amp/margin;
                else
                    y = amp;
                end
            end
        end
    end

    waveform = @(t) wave(t);

end