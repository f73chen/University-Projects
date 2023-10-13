z = tf('z');

a = 2;
b = 21;
c = 10;
d = 23;
Ts = 0.003;

z1 = exp(-a*Ts);
p1 = exp(-b*Ts);
p2 = exp(-c*Ts);
p3 = exp(-d*Ts);

lhs = 100*2 / (21*10*23);
rhs = (1-z1) / ((1-p1)*(1-p2)*(1-p3));
k = lhs/rhs;

C = k*(z-z1) / ((z-p1)*(z-p2)*(z-p3));