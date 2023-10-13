s = tf('s');

H = 651.9;
I = 651.9;
K = 12.9;

zeta = 0.7448;
ts = 0.2; % settling time
sigma = 4.6 / ts; 
sigma1 = 0;
sigma2 = 0.34;

wn = sigma / zeta;

Kp = (wn^2 - sigma1*sigma2) / (H*K);

P = K / (s^2 + sigma2*s);
C = Kp;

Tcl = I*C*P / (1 + H*C*P);
tcl = minreal(Tcl);
band = bandwidth(tcl);
time = 2*pi/(band*10);
N = 20 * band;