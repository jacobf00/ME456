function [dy, K, V] = ODEfun_Project3(t,y)

%% Set up
syms a1 a2 a3 m1 m2 m3 m4 p1 p2 p3 p4 p5 q1 q2 q3 q4 real
L1 = 1;
L2 = L1;
nump1 = -.02;
nump2 = .295;
nump3 = .342;
nump4 = -.05;
nump5 = .025;
I1 = 1;
I2 = I1;
g = 9.81;
a0 = 0;
numa1 = 0;
numa2 = .425;
numa3 = .392;
numm1 = 3.7;
numm2 = 8.393;
numm3 = 2.275;
numm4 = 2.626;
% r1 = .16;
% r2 = .1;

numq1  = y(1);
numq2  = y(2);
numq3 = y(3);
numq4 = y(4);
dq1 = y(5);
dq2 = y(6);
dq3 = y(7);
dq4 = y(8);

%% Mass matrix
%load sybolic matrix
% load('EOMs.mat','M')

M = subs(M,[a1 a2 a3 m1 m2 m3 m4 p1 p2 p3 p4 p5 q1 q2 q3 q4],[numa1 numa2 numa3 numm1 numm2 numm3 numm4 nump1 nump2 nump3 nump4 nump5 numq1 numq2 numq3 numq4]);

% M = subs(M,symvar(M),symvar(M));


%% C matrix
% load('EOMs.mat','C')

C = subs(C,[a1 a2 a3 m1 m2 m3 m4 p1 p2 p3 p4 p5 q1 q2 q3 q4],[numa1 numa2 numa3 numm1 numm2 numm3 numm4 nump1 nump2 nump3 nump4 nump5 numq1 numq2 numq3 numq4]);

%% Gravity vector
% load('EOMs.mat','G')

G = subs(G,[a1 a2 a3 m1 m2 m3 m4 p1 p2 p3 p4 p5 q1 q2 q3 q4],[numa1 numa2 numa3 numm1 numm2 numm3 numm4 nump1 nump2 nump3 nump4 nump5 numq1 numq2 numq3 numq4]);



%% Torque
tau = zeros(4,1);
% tau = calculateTorque(t,y);

%% EOM
dq = y(length(y)/2 + 1:length(y));
ddq = M\(tau-C*dq-G);

dy = [
    dq
    ddq];

%% Kinetic energy
K = 1/2*dq'*M*dq;

%% Potential energy

% load('EOMs','V')

V = subs(V,[a1 a2 a3 m1 m2 m3 m4 p1 p2 p3 p4 p5 q1 q2 q3 q4],[numa1 numa2 numa3 numm1 numm2 numm3 numm4 nump1 nump2 nump3 nump4 nump5 numq1 numq2 numq3 numq4]);


