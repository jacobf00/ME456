function dy = twoLinkODE_student(t,y)

%% Set up
L1 = 1;
L2 = L1;
p1 = L1/2;
p2 = L2/2;
m1 = 12;
m2 = m1;
I1 = 1;
I2 = I1;
g = 9.8;

%%%%%%%%%%%%%%%%%%%%%%%%%%
% define q1, q2, dq1, dq2, y1, and y2 here

q1 = y(1);
q2 = y(2);
dq1 = y(3);
dq2 = y(4);
q = [1:2];
dq = [3:4];
%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Mass matrix
m11 = m2*L1^2 + 2*m2*cos(q2)*L1*p2 + m1*p1^2 + m2*p2^2 + I1 + I2;
m12 = m2*p2^2 + L1*m2*cos(q2)*p2 + I2;
m22 = m2*p2^2 + I2;

M = [m11 m12; m12 m22];

%% C matrix
c11 = -2*L1*dq2*m2*p2*sin(q2);
c12 = -L1*dq2*m2*p2*sin(q2);
c21 = (L1*m2*p2*sin(q2)*(2*dq1 - dq2))/2;
c22 = (L1*dq1*m2*p2*sin(q2))/2;

C = [c11 c12; c21 c22];

%% Gravity vector
G = [ 
 g*m2*(p2*cos(q1 + q2) + L1*cos(q1)) + g*m1*p1*cos(q1)
                                  g*m2*p2*cos(q1 + q2)];

%% Torque
%%%%%%%%%%%%%%%%%%%%%%%%%%
% define torque here
tau = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%

%% EOM
%%%%%%%%%%%%%%%%%%%%%%%%%%
% define EOM here
% define dy
dy = [dq; inv(M)*(tau - C*dq - G)]
%%%%%%%%%%%%%%%%%%%%%%%%%%

%% For part c) - Kinetic energy
%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate kinetic energy here

%%%%%%%%%%%%%%%%%%%%%%%%%%

%% For part c) - Potential energy
%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate potential energy here
V = m1*g*p1*s1 + m2*g*(p2*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + L1*sin(q1))
%%%%%%%%%%%%%%%%%%%%%%%%%%

