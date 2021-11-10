clc,clear,close

%% 1a
syms q1 dq1 q2 dq2 q3 dq3 real

T01 = modDH(0,0,0,q1);
T12 = modDH(pi/2,40,0,q2);
T23 = modDH(0,40,0,q3);
T34 = modDH(0,15,0,0);

v11 = [0 0 0]';
w11 = [0 0 dq1]';

v22 = T12(1:3,1:3)'*(v11+cross(w11,T12(1:3,4)));
w22 = T12(1:3,1:3)'*w11 + [0 0 dq2]';

v33 = T23(1:3,1:3)'*(v22+cross(w22,T23(1:3,4)));
w33 = T23(1:3,1:3)'*w22 + [0 0 dq3]';

v44 = T34(1:3,1:3)'*(v33+cross(w33,T34(1:3,4)));
w44 = T34(1:3,1:3)'*w33;

T04 = T01*T12*T23*T34;
v04 = simplify(T04(1:3,1:3)*v44)
w04 = simplify(T04(1:3,1:3)*w44)

nu04 = [v04;w04];

J = simplify(jacobian(nu04,[dq1 dq2 dq3]))

%verify velocities are same
vAll = simplify(J*[dq1 dq2 dq3]');

%% 2a,2b
clc,clear close


q = [98 21 78]*pi/180;
dq = [.7 -.2 .6];

q1 = q(1);
q2 = q(2);
q3 = q(3);

dq1 = dq(1);
dq2 = dq(2);
dq3 = dq(3);


T01 = modDH(0,0,0,q1);
T12 = modDH(pi/2,40,0,q2);
T23 = modDH(0,40,0,q3);
T34 = modDH(0,15,0,0);


v11 = [0 0 0]';
w11 = [0 0 dq1]';

v22 = T12(1:3,1:3)'*(v11+cross(w11,T12(1:3,4)));
w22 = T12(1:3,1:3)'*w11 + [0 0 dq2]';

v33 = T23(1:3,1:3)'*(v22+cross(w22,T23(1:3,4)));
w33 = T23(1:3,1:3)'*w22 + [0 0 dq3]';

v44 = T34(1:3,1:3)'*(v33+cross(w33,T34(1:3,4)));
w44 = T34(1:3,1:3)'*w33;

T04 = T01*T12*T23*T34;
v04 = T04(1:3,1:3)*v44;
w04 = T04(1:3,1:3)*w44;

nu04 = [v04;w04]

J = [-5*sin(q1)*(3*cos(q2 + q3) + 8*cos(q2) + 8), -5*cos(q1)*(3*sin(q2 + q3) + 8*sin(q2)), -15*sin(q2 + q3)*cos(q1);
      5*cos(q1)*(3*cos(q2 + q3) + 8*cos(q2) + 8), -5*sin(q1)*(3*sin(q2 + q3) + 8*sin(q2)), -15*sin(q2 + q3)*sin(q1);
                                          0,            15*cos(q2 + q3) + 40*cos(q2),          15*cos(q2 + q3);
                                          0,                                 sin(q1),                  sin(q1);
                                          0,                                -cos(q1),                 -cos(q1);
                                          1,                                       0,                        0];
 
%% 2c
clc,clear

q = [98 21 78]*pi/180;
dq = [.7 -.2 .6];

q1 = q(1);
q2 = q(2);
q3 = q(3);

dq1 = dq(1);
dq2 = dq(2);
dq3 = dq(3);


T01 = modDH(0,0,0,q1);
T12 = modDH(pi/2,40,0,q2);
T23 = modDH(0,40,0,q3);
T34 = modDH(0,15,0,0);



J = [-5*sin(q1)*(3*cos(q2 + q3) + 8*cos(q2) + 8), -5*cos(q1)*(3*sin(q2 + q3) + 8*sin(q2)), -15*sin(q2 + q3)*cos(q1);
      5*cos(q1)*(3*cos(q2 + q3) + 8*cos(q2) + 8), -5*sin(q1)*(3*sin(q2 + q3) + 8*sin(q2)), -15*sin(q2 + q3)*sin(q1);
                                          0,            15*cos(q2 + q3) + 40*cos(q2),          15*cos(q2 + q3)];
nu04 = [-4 8 3]';

%verify velocities are same


dq_from_J = J\nu04


%% Problem 3
clc,clear

q = [90 90 0]*pi/180;
dq = [0 0 1];

q1 = q(1);
q2 = q(2);
q3 = q(3);

dq1 = dq(1);
dq2 = dq(2);
dq3 = dq(3);



J = [-5*sin(q1)*(3*cos(q2 + q3) + 8*cos(q2) + 8), -5*cos(q1)*(3*sin(q2 + q3) + 8*sin(q2)), -15*sin(q2 + q3)*cos(q1);
      5*cos(q1)*(3*cos(q2 + q3) + 8*cos(q2) + 8), -5*sin(q1)*(3*sin(q2 + q3) + 8*sin(q2)), -15*sin(q2 + q3)*sin(q1);
                                          0,            15*cos(q2 + q3) + 40*cos(q2),          15*cos(q2 + q3)];
v04 = J*dq'

