s = tf('s');

Kt = 0.0241;
Ra = 3.02;
La = 4.16e-4;
Ke = 0.0241;
theta_dot_m = 490;
ia = 0.0586;
J_total = 5.71e-4;
b = 2.88e-6;

P = Kt / (J_total*La*s^3 + (J_total*Ra + b*La)*s^2 + (b*Ra + Kt*Ke)*s);
P_normalized = minreal(P);
