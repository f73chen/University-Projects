s = tf('s');

m = 0.0128;
Jt = 5.71E-04;
l = 0.184;
g = 9.81;

Kt = 0.0241;
Ra = 3.02;
Rt = Ra +  2*0.225;     % Add MOSFET resistance
La = 0;
Ke = (1/396) * 60 / (2*pi);   % Convert to V/(rad/s)
wm = 4680 * 2*pi / 60;
ia = 0.0586;

b = Kt*ia/wm;

P = Kt / (Jt*Rt*s^2 + (b*Rt + Ke*Kt)*s - m*g*l*Rt);
P = minreal(P);
