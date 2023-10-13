clear
clc

t = 0:1/60:1.2;
start = 0.35;
stop = 0.95;

subplot(4,1,1)
plot(t, GetWaveform(t, start, stop, 'sine', 8, 12, 50, 0.32));
title('Sine');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([-0.25, 10]);

subplot(4,1,2)
plot(t, GetWaveform(t, start, stop, 'square', 8, 20, 50, 0));
title('Square');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([-0.25, 10]);

subplot(4,1,3)
plot(t, GetWaveform(t, start, stop, 'trap', 8, 20, 50, 0));
title('Trapezoidal');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([-0.25, 10]);

subplot(4,1,4)
plot(t, GetWaveform(t, start, stop, 'constant', 8, 20, 50, 0));
title('Constant');
xlabel('Time (s)'); 
ylabel('Voltage (V)');
ylim([-0.25, 10]);