clc,clear,close




qq = invKin(1,1,.5)

function q = invKin(x,z,phi)

a2 = 1;
a3 = 1;

c2 = (x-a3*cos(phi))/a2;
s2_p = sqrt(1-c2^2);
s2_n = sqrt(1-c2^2);

theta2_p = atan2(s2_p,c2);
theta2_n = atan2(s2_n,c2);

d1_p = z-a3*sin(phi)-a2*sin(theta2_p);
d1_n = z-a3*sin(phi)-a2*sin(theta2_n);

theta3_p = atan2(sin(phi),cos(phi)) - theta2_p;
theta3_n = atan2(sin(phi),cos(phi)) - theta2_n;


q = [d1_p theta2_p theta3_p;
    d1_n theta2_n theta3_n];


end




