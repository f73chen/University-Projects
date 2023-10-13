s = tf('s');
I = 50;
H = 50;

Kp = 10;
Kd = 0.8;
K = 0.002;
w = 30;
z = 0.1;

C = Kp + Kd * s;
P = K * w^2 / (s^2 + 2*z*w*s + w^2);

% 1. a) Poles and zeros of the plant
pole(P)
zero(P)

% 1. b) Poles and zeros of the closed-loop system
Tcl = I*C*P/(1 + H*C*P);
pole(Tcl)
zero(Tcl)

% 2. Bandwidth of the closed-loop system
bandwidth(Tcl)

% 3. Phase and gain margins of the closed-loop system
Tloop = C*P*H;
margin(Tloop)

% 4. 
Kp = 1;
Kd = 0.03;
K = 0.004;
w = 10;
z = 0.9;

C2 = Kp + Kd * s;
P2 = K * w^2 / (s^2 + 2*z*w*s + w^2);
Tcl2 = I*C2*P2/(1 + H*C2*P2);

pole(P2)
zero(P2)
pole(Tcl2)
zero(Tcl2)

% Part 2 or something bruh
% 1. Kp should be between 8 and 9.5 for all 3 poles to be stable
I = 100;
H = 100;
K = 0.01;
a = 3;
b = 0.5;
c = -8;

C = Kp;
P = K / (s^3 + a*s^2 + b*s + c);

sys = P*H;
rlocus(sys);

% 2. Kp should be between 0.1 and 0.2
a = 20;
b = 5;
c = -100;

C = Kp;
P = K / (s^3 + a*s^2 + b*s + c);

sys = P*H;
rlocus(sys);


