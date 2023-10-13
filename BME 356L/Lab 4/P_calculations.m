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
Kd = 0.01432;
% Kp = 3950/7816.3;
% Kd = 85/7816.3;
% Ki = 70500/7816.3;

C = Kp + Kd*s;
Tcl = I*C*P / (1+H*C*P);
Tcl = minreal(Tcl);
band = bandwidth(Tcl) / (2*pi);
period = 1/band;

sys_pd = s / (s^2 + 3.419*s + 4097);
sys_pi1 = 1 / (s^3 + 3.419*s^2 + 4096.7*s);
sys_pi2 = s / (s^3 + 3.491*s^2 - 41.27*s + 6750);
sys_pid_d1 = s^2 / (s^3 + 3.491*s^2 + (K*H*Kp-41.27)*s + K*H*Ki);
sys_pid_p1 = s / (s^3 + (3.491 + 7816.3*Kd)*s^2 - 41.27*s + 7816.3*Ki);
sys_pid_i1 = 1 / (s^3 + (3.491 + 7816.3*Kd)*s^2 + (-41.27 + 7816.3*Kp)*s);

Tloop = C*P*H;
















