%% Collaborative Problem 8.1

%% Set up
syms q1 q2 real
syms L1 L2 p1 p2 real
T01 = modDH(0,0,0,q1);
T12 = modDH(0,L1,0,q2);
T23 = modDH(0,L2,0,0);
T02 = T01*T12;

% Position vectors from link frame origin to link COM in link frame
r1g = [
    p1
    0
    0];
r2g = [
    p2
    0
    0];

%% a) Velocity
syms dq1 dq2 real
dq = [dq1; dq2];

% Velocity of link 1 frame
v1 = [0 0 0]';
w1 = [0 0 dq1]';

% Velocity of link 2 frame
v2 = T12(1:3,1:3)'*(v1 + cross(w1,T12(1:3,4)));
w2 = T12(1:3,1:3)'*w1 + [0 0 dq2]';

%%%%%%%%% ADD CODE HERE %%%%%%%%%

%% b) Kinetic energy
syms m1 m2 I1 I2 real

%%%%%%%%% ADD CODE HERE %%%%%%%%%
