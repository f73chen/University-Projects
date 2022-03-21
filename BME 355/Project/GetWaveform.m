function [waveform] = GetWaveform(type, amp, freq, duty)
    % Input Parameters
    %   type: type of waveform (sine, square, trap)
    %   amp:  amplitude - all waves
    %   freq: frequency (Hz) - all waves
    %   duty: duty cycle (int from 0 to 100) - square and trap waves
    % Output
    %   waveform: FES wave from t = 0 to 1 (percent of gait cycle)
    
    t = 0:0.01:1; 
    
    function y = wave(x)
        if x < 0.6
            y = 0;
        else
            if strcmp(type, 'sine') 
                y = amp * sin(freq*x);
            elseif strcmp(type, 'square') 
                y = amp * square(freq*x, duty);
            elseif strcmp(type, 'trap') 
                margin = 0.4*(duty/100)/2;
                if x < 0.6 + margin
                    y = (amp/margin)*x - 0.6*amp/margin;
                elseif x > 1 - margin
                    y = -(amp/margin)*x + amp/margin;
                else
                    y = amp;
                end
            end
        end
    end

    waveform = @(t) wave(t);

end