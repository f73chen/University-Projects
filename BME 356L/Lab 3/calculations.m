s = tf('s');

peak = 0.3973;
final = 0.294524;
delta_t = 1.48297 - 0.501002;

OS = (peak - final) / final * 100;
zeta = -log(OS/100) / sqrt(pi^2 + log(OS/100)^2);
wd = 2*pi / delta_t;
wn = wd / sqrt(1 - zeta^2);
K = (final - 0) / (12*85/1023 - 0);

P = (K * wn^2) / (s^2 + 2*zeta*wn*s - wn^2);

Rv = 12*R / 1023;