clc,clear,close

%% Set up
syms q1 q2 real
syms a1 a2 p1 p2 real
syms m1 m2 I1 I2 real
syms dq1 dq2 real
syms r1 r2 real
syms g real
T01 = modDH(0,0,q1,0);
T12 = modDH(pi/2,0,0,q2);
T23 = modDH(0,a2,0,0);
T02 = T01*T12;

q = [q1 q2]';
% Position vectors from link frame origin to link COM in link frame
r1g = [
    0
    0
    -q1/2];
r2g = [
    a2/2
    0
    0];

% Inertia matrix
I1 = [
 1/12*m1*(r1^2 + a1^2) 0 0
 0 1/12*m1*(r1^2 + a1^2) 0
 0 0 1/6*m1*r1^2];

I2 = [
 1/6*m2*r2^2 0 0
 0 1/12*m2*(r2^2 + a2^2) 0
 0 0 1/12*m2*(r2^2 + a2^2)];

%% Velocity

dq = [dq1; dq2];

% Velocity of link 1 frame
v11 = [0 0 dq1]';
w11 = [0 0 0]';

v1G1 = v11 + cross(w11,r1g);

% Velocity of link 2 frame
v22 = T12(1:3,1:3)'*(v11 + cross(w11,T12(1:3,4)));
w22 = T12(1:3,1:3)'*w11 + [0 0 dq2]';

v2G2 = v22 + cross(w22,r2g);
%%%%%%%%% ADD CODE HERE %%%%%%%%%

%% Kinetic energy


%%%%%%%%% ADD CODE HERE %%%%%%%%%

KE = collect(simplify(expand((1/2)*(m1*(v1G1'*v1G1) + w11'*I1*w11 + m2*(v2G2'*v2G2) + w22'*I2*w22))),dq);

%% 1a) Find mass matrix

m11 = m1/2 + m2/2;
m12 = a2*m2*cos(q2)/2;
m21 = m12;
m22 = ((m2*a2^2)/6 + (m2*r2^2)/24);

M = [2*m11,m12;
     m21,2*m22]
 
%Check 
disp('If ans = 0, M is correct')
Km = 1/2*dq'*M*dq;
simplify(expand(Km-KE))

%% 1b) Find C matrix

C = sym(zeros(2,2));
for k=1:2
    for j=1:2
        for i=1:2
            C(k,j) = simplify(C(k,j) + (diff(M(k,j),q(i)) - 1/2*diff(M(i,j),q(k)))*dq(i));
        end
    end
end
C

%% Fill in C Matrix

c11 = 0;
c12 = -(a2*dq2*m2*sin(q2))/2;
c21 = -(a2*dq2*m2*sin(q2))/4;
c22 = (a2*dq1*m2*sin(q2))/4;
C = [c11 c12; c21 c22];

%% 1c) Find G vector

%convert COM vectors to frame 0
r1g0 = T01(1:3,1:3)*r1g + T01(1:3,4);
r2g0 = T02(1:3,1:3)*r2g + T02(1:3,4);

% Potential Energy
V = m1*g*r1g0(3) + m2*g*r2g0(3)

G = sym(zeros(2,1));
for k=1:2
 G(k) = simplify(diff(V,q(k)));
end
G

%% Fill in G vector

G =[
  (g*(m1 + 2*m2))/2
(a2*g*m2*cos(q2))/2];

%% Plug in q and dq to check if correct

Mcheck = round(subs(M,[m1 m2 a2 q2 r2], [30 26 .7 -3.56 .1]),2)
Ccheck = round(subs(C,[m2 a2 q2 dq1 dq2], [26 .7 -3.56 -.38 .67]),2)
Gcheck = round(subs(G,[g m1 m2 a2 q2], [9.81 30 26 .7 -3.56]),2)
