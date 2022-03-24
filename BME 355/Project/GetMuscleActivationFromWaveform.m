function [muscle_activation] = GetMuscleActivationFromWaveform(t, type, amp, freq, duty, phase)
    % initialize waveform
    waveform = GetWaveform(t, type, amp, freq, duty, phase);
    
    % find the max point of the dataset (assume min point is 0)
    max_point = 10; % defined for our use case, for individual mapping this should be max(waveform)
    scale_factor = 1;
    
    % apply sigmoid function with modifications
    % shift the x-axis so smoothing occurs at a more popular region
    mapped_waveform = 6 * waveform / max_point - 3;
    muscle_activation = scale_factor ./ (1 + exp(-mapped_waveform));
end