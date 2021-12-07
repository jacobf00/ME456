function [dy, K, V] = twoLinkODE_HW9(t,y)

%% Set up
L1 = 1;
L2 = L1;
p1 = L1/2;
p2 = L2/2;
m1 = 12;
m2 = m1;
I1 = 1;
I2 = I1;
g = 9.81;
a1 = .5;
a2 = .7;
m1 = 30;
m2 = 26;
r1 = .16;
r2 = .1;

q1  = y(1);
q2  = y(2);
dq1 = y(3);
dq2 = y(4);

%% Mass matrix
% m11 = m2*L1^2 + 2*m2*cos(q2)*L1*p2 + m1*p1^2 + m2*p2^2 + I1 + I2;
% m12 = m2*p2^2 + L1*m2*cos(q2)*p2 + I2;
% m22 = m2*p2^2 + I2;

M = [m1 + m2,          (a2*m2*cos(q2))/2;
(a2*m2*cos(q2))/2, (m2*a2^2)/3 + (m2*r2^2)/12];

%% C matrix
C = [                     0, -(a2*dq2*m2*sin(q2))/2;
-(a2*dq2*m2*sin(q2))/4,  (a2*dq1*m2*sin(q2))/4];

%% Gravity vector
G = [ 
 (g*(m1 + 2*m2))/2;
(a2*g*m2*cos(q2))/2];

%% Torque
tau = zeros(2,1);
% tau = calculateTorque(t,y);

%% EOM
dq = y(3:4);
ddq = M\(tau-C*dq-G);

dy = [
    dq
    ddq];

%% Kinetic energy
K = 1/2*dq'*M*dq;

%% Potential energy

V = (g*m1*q1)/2 + g*m2*(q1 + (a2*sin(q2))/2);


