function [waveform] = GetWaveform(t, start, stop, type, total_s, amp, freq, duty)
    % Input Parameters
    %   t:        time in seconds during the gait cycle
    %   start:    start time of swing phase
    %   stop:     end time of swing phase
    %   type:     type of waveform (sine, square, trap)
    %   total_s:  number of seconds in one gait cycle
    %   amp:      amplitude - all waves
    %   freq:     frequency (Hz) - all waves
    %   duty:     duty cycle (int from 0 to 100) - square and trap waves
    % Output
    %   waveform: FES wave from t = 0 to 1 (percent of gait cycle)
    
    waveform = zeros(1, size(t, 2));
    for i = 1:size(t,2)
        if t(i) < start || t(i) > stop
            waveform(i) = 0;
        else
            if strcmp(type, 'sine') 
                waveform(i) = amp/2 * sin(freq*(t(i)-start)) + amp/2;
            elseif strcmp(type, 'square') 
                waveform(i) = amp/2 * square(freq*(t(i)-start), duty) + amp/2;
            elseif strcmp(type, 'trap') 
                margin = (stop - start)*(duty/100)/2;
                if t(i) < start + margin
                    waveform(i) = (amp/margin)*t(i) - start*amp/margin;
                elseif t(i) > stop - margin
                    waveform(i) = -(amp/margin)*t(i) + amp/margin*stop;
                else
                    waveform(i) = amp;
                end
            end
        end
    end

end