s = tf('s');

Md = 0.152;
Rd = 0.0762;
Mh = 0.012;
Rh = 0.0127;
Mm = 0.016;
Rm = 0.07;

Jd = 0.5 * Md * Rd^2;
Jh = 0.5 * Mh * Rh^2;
Jm = Mm * Rm^2;
Je = 1.7 * 10^-7;
Jt = Jd + Jh + Jm + Je;

Kt = 0.0241;
Ra = 3.02;
La = 4.16 * 10^-4;
Ke = 1/396;
wm = 4680 * 2*pi / 60;
ia = 0.0586;

b = Kt*ia/wm;

P = Kt / (Jt*La*s^3 + (Jt*Ra + b*La)*s^2 + (b*Ra + Kt*Ke)*s);
poles = pole(P);
