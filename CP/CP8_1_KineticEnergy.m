%% Collaborative Problem 8.1 and 8.2

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
v11 = [0 0 0]';
w11 = [0 0 dq1]';

v1G1 = v11 + cross(w11,r1g)

% Velocity of link 2 frame
v22 = T12(1:3,1:3)'*(v11 + cross(w11,T12(1:3,4)));
w22 = T12(1:3,1:3)'*w11 + [0 0 dq2]';

v2G2 = v22 + cross(w22,r2g)
%%%%%%%%% ADD CODE HERE %%%%%%%%%

%% b) Kinetic energy
syms m1 m2 I1 I2 real

%%%%%%%%% ADD CODE HERE %%%%%%%%%

KE = collect(simplify(expand((1/2)*(m1*(v1G1'*v1G1) + w11'*I1*w11 + m2*(v2G2'*v2G2) + w22'*I2*w22))),dq)

%% 8.2 a) find mass matrix

m11 = ((m2*L1^2)/2 + m2*cos(q2)*L1*p2 + (m1*p1^2)/2 + (m2*p2^2)/2 + I1/2 + I2/2);
m12 = (m2*p2^2 + L1*m2*cos(q2)*p2 + I2);
m21 = m12;
m22 = ((m2*p2^2)/2 + I2/2);

M = [2*m11,m12;
     m21,2*m22]
 
 
