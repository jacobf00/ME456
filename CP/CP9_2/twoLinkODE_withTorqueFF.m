function [dy, K, V] = twoLinkODE_withTorqueFF(t,y)

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

q1  = y(1);
q2  = y(2);
dq1 = y(3);
dq2 = y(4);

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
tau = calculateTorqueFF(t,y);

%% EOM
dq = y(3:4);
ddq = M\(tau-C*dq-G);

dy = [
    dq
    ddq];

%% Kinetic energy
K = 1/2*dq'*M*dq;

%% Potential energy
V = g*m2*(p2*(cos(q1)*sin(q2) + cos(q2)*sin(q1)) + L1*sin(q1)) + g*m1*p1*sin(q1);
