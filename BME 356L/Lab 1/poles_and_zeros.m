s = tf('s');

Md = 0.152;
Rd = 0.0762;
Mh = 0.012;
Rh = 0.0127;
Mm = 0.016;
Rm = 0.07;

Jd = 0.5 * Md * Rd^2;
Jh = 0.5 * Mh * Rh^2;
Jm = 2 * Mm * Rm^2;     % Two masses
Je = 1.7 * 10^-7;
Jt = Jd + Jh + Jm + Je;

Kt = 0.0241;
Ra = 3.02;
Rt = Ra +  2*0.225;     % Add MOSFET resistance
La = 4.16 * 10^-4;
Ke = (1/396) * 60 / (2*pi);   % Convert to V/(rad/s)
wm = 4680 * 2*pi / 60;
ia = 0.0586;

b = Kt*ia/wm;

P = Kt / (Jt*La*s^3 + (Jt*Rt + b*La)*s^2 + (b*Rt + Kt*Ke)*s);
poles = pole(P);

numerator = Kt / (2.493e-07 * 8341.06665046695)
denominator = -poles(3)
