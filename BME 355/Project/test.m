clear
clc

total_s = 5;
t = 0:0.01:total_s;
hold on
plot(t, GetWaveform(t, 'square', total_s, 3, 20, 50));
plot(t, GetWaveform(t, 'trap', total_s, 4, 20, 50));
plot(t, GetMuscleActivationFromWaveform(t, 'square', total_s, 3, 20, 50));
% plot(t, GetMuscleActivationFromWaveform(t, 'square', total_s, 5, 20, 50));
plot(t, GetMuscleActivationFromWaveform(t, 'trap', total_s, 4, 20, 50));
hold off