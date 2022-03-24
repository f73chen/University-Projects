clear
clc

t = 0:0.01:1.2;

subplot(3,1,1)
plot(t, GetWaveform(t, 'sine', 3, 20, 50));
title('Sine');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([-0.25, 4]);

subplot(3,1,2)
plot(t, GetWaveform(t, 'square', 3, 20, 50));
title('Square');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([-0.25, 4]);

subplot(3,1,3)
plot(t, GetWaveform(t, 'trap', 3, 20, 50));
title('Trapezoidal');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([-0.25, 4]);