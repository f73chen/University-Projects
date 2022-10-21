s = tf('s');

H = 651.9;
I = 651.9;
K = 12.9;
d1 = 0.34;
d0 = 0;

%zeta = 0.7448;
zeta = 0.77;
sigma = 23;

wn = sigma / zeta;
a = sigma;
b = wn * sqrt(1 - zeta^2);

Kd = (2*a - d1)/ (H*K);
Kp = (a^2 + b^2 - d0) / (H*K);

P = K / (s^2 + d1*s);
C = Kp + Kd*s;

Tcl = I*C*P / (1 + H*C*P);
tcl = minreal(Tcl);
band = bandwidth(tcl);
time = 2*pi/(band*10);
N = 20 * band;