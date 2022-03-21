clear
clc

total_s = 5;
t = 0:0.01:total_s;
plot(t, GetWaveform(t, 'square', total_s, 3, 20, 50));