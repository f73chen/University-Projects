clear
clc

total_s = 5;
t = 0:0.01:total_s;
plot(t, GetWaveform(t, 'trap', total_s, 1, 20, 50));