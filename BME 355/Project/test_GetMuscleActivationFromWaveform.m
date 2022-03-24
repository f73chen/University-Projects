clear
clc

t = 0:0.01:1.2;

subplot(3,1,1)
plot(t, GetMuscleActivationFromWaveform(t, 'sine', 10, 20, 50));
title('Sine');
xlabel('Time (s)'); 
ylabel('Activation');
ylim([0, 1]);

subplot(3,1,2)
plot(t, GetMuscleActivationFromWaveform(t, 'square', 10, 20, 50));
title('Square');
xlabel('Time (s)'); 
ylabel('Activation');
ylim([0, 1]);

subplot(3,1,3)
plot(t, GetMuscleActivationFromWaveform(t, 'trap', 10, 20, 50));
title('Trapezoidal');
xlabel('Time (s)'); 
ylabel('Activation');
ylim([0, 1]);
