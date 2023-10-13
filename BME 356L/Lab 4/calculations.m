s = tf('s');

% P Controller
ess = 0.01;
I = 651.9;
H = 651.9;
sigma = 23;
sigma1 = 8.4026;
sigma2 = -4.9116;
zeta = 0.6901;
wn1 = sigma/zeta;                   % Settling time
wn2 = (sigma1 + sigma2) / (2*zeta); % Overshoot

P = 11.99 / (s^2 + 3.491*s - 41.27);
Kp1 = (I - ess) / (ess * H * 11.99 / -41.27);
Kp2 = (wn1^2 - sigma1*sigma2) / (11.99*H);  % Settling time
Kp3 = (wn2^2 - sigma1*sigma2) / (11.99*H);  % Overshoot

C = Kp3;
Tcl = I*C*P / (1 + H*C*P);
Tcl = minreal(Tcl);
band = bandwidth(Tcl) / (2*pi);
period = 1/band/100;