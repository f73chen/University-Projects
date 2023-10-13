clear
clc

t = 0:0.01:1.2;

subplot(4,1,1)
plot(t, GetMuscleActivationFromWaveform(t, 'sine', 10, 12, 50, 0.32));
title('Sine');
xlabel('Time (s)'); 
ylabel('Activation');
ylim([0, 1]);

subplot(4,1,2)
plot(t, GetMuscleActivationFromWaveform(t, 'square', 10, 20, 50, 0));
title('Square');
xlabel('Time (s)'); 
ylabel('Activation');
ylim([0, 1]);

subplot(4,1,3)
plot(t, GetMuscleActivationFromWaveform(t, 'trap', 10, 20, 50, 0));
title('Trapezoidal');
xlabel('Time (s)'); 
ylabel('Activation');
ylim([0, 1]);

subplot(4,1,4)
plot(t, GetMuscleActivationFromWaveform(t, 'constant', 3, 20, 50, 0));
title('Constant');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([0, 1]);
