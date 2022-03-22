function [muscle_activation] = GetMuscleActivationFromWaveform(t, type, total_s, amp, freq, duty)

% initialize waveform
waveform = GetWaveform(t, type, total_s, amp, freq, duty);

% find the max point of the dataset (assume min point is 0)
max_point = 5; % defined 5 for our use case, for individual mapping this should be max(waveform)

% apply sigmoid function with modifications (translation and stretch
% factor) so max x value fits the max dataset
mapped_waveform = 6 * waveform / max_point - 3;
muscle_activation = 0.175 * (1 + exp(-mapped_waveform)) .^ -1;

end