clear
clc

t = 0:1/60:1.2;

subplot(4,1,1)
plot(t, GetWaveform(t, 'sine', 3, 12, 50, 0.32));
title('Sine');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([-0.25, 4]);

subplot(4,1,2)
plot(t, GetWaveform(t, 'square', 3, 20, 50, 0));
title('Square');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([-0.25, 4]);

subplot(4,1,3)
plot(t, GetWaveform(t, 'trap', 3, 20, 50, 0));
title('Trapezoidal');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([-0.25, 4]);

subplot(4,1,4)
plot(t, GetWaveform(t, 'constant', 3, 20, 50, 0));
title('Constant');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([-0.25, 4]);