s = tf('s');

I = 651.9;
H = 651.9;
K = 11.99;
d1 = 3.491;
d0 = -41.27;

P = K / (s^2 + d1*s + d0);

% Steady-State Error Kp
ess = -0.01 * 15 * (pi/180) * 651.9;
Kp = (15*pi/180)*(I - ess) / (ess * H * 11.99 / -41.27);
Kd = 0.01086;

C = Kp + Kd*s;
Tcl = I*C*P / (1+H*C*P);
Tcl = minreal(Tcl);
band = bandwidth(Tcl) / (2*pi);
period = 1/band;

sys = s / (s^2 + 3.419*s + 4097);
