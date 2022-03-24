clear
clc

t = 0:0.01:1.2;

subplot(3,1,1)
plot(t, GetWaveform(t, 0.35, 0.95, 'sine', 3, 20, 50));
title('Sine');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([-0.25, 4]);

subplot(3,1,2)
plot(t, GetWaveform(t, 0.35, 0.95, 'square', 3, 20, 50));
title('Square');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([-0.25, 4]);

subplot(3,1,3)
plot(t, GetWaveform(t, 0.35, 0.95, 'trap', 3, 20, 50));
title('Trapezoidal');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([-0.25, 4]);

% hold on
% plot(t, GetWaveform(t, 'trap', total_s, 4, 20, 50));
% plot(t, GetMuscleActivationFromWaveform(t, 'square', total_s, 3, 20, 50));
% plot(t, GetMuscleActivationFromWaveform(t, 'square', total_s, 5, 20, 50));
% plot(t, GetMuscleActivationFromWaveform(t, 'trap', total_s, 4, 20, 50));
% hold off