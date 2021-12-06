function [tau, tauFF, tauFB, e, qd] = calculateTorque_student(t,y)
% Calculate torque for the two link robot using computed torque control
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
L1 = 1;
L2 = L1;
p1 = L1/2;
p2 = L2/2;
m1 = 12;
m2 = m1;
I1 = 1;
I2 = I1;
g = 9.8;
T = 2; %sec

q1  = y(1);
q2  = y(2);
dq1 = y(3);
dq2 = y(4);

%%%%%%%%%%% Define q and dq %%%%%%%%%%%

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
%%%%%%%%%%% Equations describing the desired joint position (qd), velocity
%%%%%%%%%%% (dqd), and acceleration (ddqd) %%%%%%%%%%%
q1d = (3*pi/T^5)*t.^5 - (15*pi/2*T^4)*t.^4 + (5*pi/T^3)*t.^3;
q2d = -(3*pi/2*T^5)*t.^5 + (15*pi/4*T^4)*t.^4 - (5*pi/2*T^3)*t.^3;

q1dcoeff = [(3*pi)/T^5 (-15*pi)/(2*T^4) (5*pi)/T^3 0 0 0];
q2dcoeff = [(-3*pi)/T^5 (15*pi)/(4*t^4) (-5*pi)/(2*T^3) 0 0 0];
q1d = polyval(q1dcoeff,t);
q2d = polyval(q2dcoeff,t);

dq1dcoeff = polyder(q1dcoeff);
dq2dcoeff = polyder(q2dcoeff);
dq1d = polyval(dq1dcoeff);
dq2d = polyval(dq2dcoeff);

ddq1dcoeff = polyder(dq1dcoeff);
ddq2dcoeff = polyder(dq2dcoeff);
ddq1d = polyval(ddq1dcoeff);
ddq2d = polyval(ddq2dcoeff);

%% Error
%%%%%%%%%%% Calculate the error (e) %%%%%%%%%%%

%% Feedback Torque
%%%%%%%%%%% Choose values for Kp and Kd %%%%%%%%%%%
%%%%%%%%%%% Calculate the feedback torque (tauFB) %%%%%%%%%%%

%% Feedforward Torque
%%%%%%%%%%% Calculate the feedforward torque (tauFF) %%%%%%%%%%%

%% Total Torque
%%%%%%%%%%% Calculate the total torque (tau) %%%%%%%%%%%

