function [tau, tauFF, tauFB, e, qd] = calculateTorqueFB(t,y)
% Calculate torque for the two link robot using feedback control
% Inputs:
% ~ t: current time, a scalar
% ~ y: current state, a 4 x 1 vector, [q1 q2 dq1 dq2]
% Ouputs:
% ~ tau: total joint torque
% ~ tauFF: the feedforward portion of the joint torque
% ~ taueFB: the feedback portion of the joint torque
% ~ e: the error
% ~ qd: desired joint angles

%% Set up
massErr = 1;
L1 = 1;
L2 = L1;
p1 = L1/2;
p2 = L2/2;
m1 = massErr*12;
m2 = massErr*m1;
I1 = 1;
I2 = I1;
g = 9.8;

q1  = y(1);
q2  = y(2);
q   = y(1:2);
dq1 = y(3);
dq2 = y(4);
dq  = y(3:4);

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
                              
%% Desired motion
q1End = pi/2;
q2End = -pi/4;
T = 2;
qd = [
    6*q1End/T^5*t^5 - 15*q1End/T^4*t^4 + 10*q1End/T^3*t^3
    6*q2End/T^5*t^5 - 15*q2End/T^4*t^4 + 10*q2End/T^3*t^3];
dqd = [
    30*q1End/T^5*t^4 - 60*q1End/T^4*t^3 + 30*q1End/T^3*t^2
    30*q2End/T^5*t^4 - 60*q2End/T^4*t^3 + 30*q2End/T^3*t^2];
ddqd = [
    120*q1End/T^5*t^3 - 180*q1End/T^4*t^2 + 60*q1End/T^3*t
    120*q2End/T^5*t^3 - 180*q2End/T^4*t^2 + 60*q2End/T^3*t];

%% Error
e = q - qd;
de = dq - dqd;

%% Torque
Kp = 100;
Kd = 10;
tauFF = C*dq + G + M*ddqd;
tauFB = -M*(Kp*e + Kd*de);
tau   = tauFB;


