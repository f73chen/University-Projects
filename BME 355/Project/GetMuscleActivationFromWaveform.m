function [muscle_activation] = GetMuscleActivationFromWaveform(t, type, total_s, amp, freq, duty)

% initialize waveform
waveform = GetWaveform(t, type, total_s, amp, freq, duty);

% find the max point of the dataset (assume min point is 0)
max_point = 5; % defined 5 for our use case, for individual mapping this should be max(waveform)

% apply sigmoid function with modifications (translation and stretch
% factor) so max x value fits the max dataset
mapped_waveform = zeros(size(waveform));
muscle_activation = zeros(size(waveform));

for i = 1:length(waveform)
    mapped_waveform(i) = 6 * waveform(i) / max_point - 3;
    muscle_activation(i) = 0.175/(1 + exp(-mapped_waveform(i)));
end

end