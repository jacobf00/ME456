%% Project 3 EOM script
% EOM Script
clc, clear

syms q1 q2 q3 q4 real
syms d1 d2 d3 d4 a2 a3  p1 p2 p3 p4 p5 real
syms g real
T01 = modDH(0,0,d1,q1);
T12 = modDH(pi/2,0,d2,q2);
T23 = modDH(0,a2,d3,q3);
T34 = modDH(0,a3,d4,q4);

T02 = T01 * T12;
T03 = T01 * T12 * T23;
T04 = T01 * T12 * T23 * T34;

r1g = [
    0
    0
    p1];
r2g = [
    p2
    0
    0];
r3g = [
    p3
    0
    0];
r4g = [
    0
    p4
    p5];

I1 = [0.0084 0 0;
    0 0.0064 0;
    0 0 0.0084];
I2 = [0.0078 0 0;
    0 0.21 0;
    0 0 0.21];
I3 = [0.0016 0 0;
    0 0.0462 0;
    0 0 0.0462];
I4 = [0.0032 0 0;
    0 0.0112 0;
    0 0 0.0112];

%%
syms dq1 dq2 dq3 dq4 real

dq = [dq1;dq2;dq3;dq4];
q = [q1 q2 q3 q4]';

% Velocity of link 1 frame
v1 = [0 0 0]';
w1 = [0 0 dq1]';

% Velocity of link 2 frame
v2 = T12(1:3,1:3)'*(v1 + cross(w1,T12(1:3,4)));
w2 = T12(1:3,1:3)'*w1 + [0 0 dq2]';

% Velocity of link 3 frame
v3 = T23(1:3,1:3)'*(v2 + cross(w2,T23(1:3,4)));
w3 = T23(1:3,1:3)'*w2 + [0 0 dq3]';

% Velocity of link 2 frame
v4 = T34(1:3,1:3)'*(v3 + cross(w3,T34(1:3,4)));
w4 = T34(1:3,1:3)'*w3 + [0 0 dq4]';

v1g = v1 + cross(w1,r1g);
v2g = v2 + cross(w2,r2g);
v3g = v3 + cross(w3,r3g);
v4g = v4 + cross(w4,r4g);

%% b) Kinetic energy
syms m1 m2 m3 m4 real

%%%%%%%%% ADD CODE HERE %%%%%%%%%

k1 = .5*m1*(v1g'*v1g) + .5*w1'*I1*w1; 
k2 = .5*m2*(v2g'*v2g) + .5*w2'*I2*w2;
k3 = .5*m3*(v3g'*v3g) + .5*w3'*I3*w3;
k4 = .5*m4*(v4g'*v4g) + .5*w4'*I4*w4;


K = collect(simplify(expand(k1+k2+k3+k4)),dq);


%% Find M
m11 = 2*((1011*cos(2*q2))/20000 + cos(2*q2 + 2*q3 + 2*q4)/500 + (223*cos(2*q2 + 2*q3))/20000 + (a2^2*m3)/4 + (a2^2*m4)/4 + (a3^2*m4)/4 + (d2^2*m2)/2 + (d2^2*m3)/2 + (d2^2*m4)/2 + (d3^2*m3)/2 + (d3^2*m4)/2 + (d4^2*m4)/2 + (m2*p2^2)/4 + (m3*p3^2)/4 + (m4*p4^2)/4 + (m4*p5^2)/2 + d2*d3*m3 + d2*d3*m4 + d2*d4*m4 + d3*d4*m4 + d2*m4*p5 + d3*m4*p5 + d4*m4*p5 + (a2^2*m3*cos(2*q2))/4 + (a2^2*m4*cos(2*q2))/4 + (m2*p2^2*cos(2*q2))/4 - (m4*p4^2*cos(2*q2 + 2*q3 + 2*q4))/4 + (a3^2*m4*cos(2*q2 + 2*q3))/4 + (m3*p3^2*cos(2*q2 + 2*q3))/4 - (a2*m4*p4*sin(2*q2 + q3 + q4))/2 - (a2*m4*p4*sin(q3 + q4))/2 + (a2*a3*m4*cos(q3))/2 + (a2*m3*p3*cos(q3))/2 - (a3*m4*p4*sin(q4))/2 - (a3*m4*p4*sin(2*q2 + 2*q3 + q4))/2 + (a2*a3*m4*cos(2*q2 + q3))/2 + (a2*m3*p3*cos(2*q2 + q3))/2 + 371/5000);
m12 = (- a3*d2*m4*sin(q2 + q3) - a3*d3*m4*sin(q2 + q3) - a3*d4*m4*sin(q2 + q3) - a3*m4*p5*sin(q2 + q3) - d2*m3*p3*sin(q2 + q3) - d3*m3*p3*sin(q2 + q3) - a2*d2*m3*sin(q2) - a2*d2*m4*sin(q2) - a2*d3*m3*sin(q2) - a2*d3*m4*sin(q2) - a2*d4*m4*sin(q2) - a2*m4*p5*sin(q2) - d2*m2*p2*sin(q2) - d2*m4*p4*cos(q2 + q3 + q4) - d3*m4*p4*cos(q2 + q3 + q4) - d4*m4*p4*cos(q2 + q3 + q4) - m4*p4*p5*cos(q2 + q3 + q4));
m21 = m12;
m13 = (- a3*d2*m4*sin(q2 + q3) - a3*d3*m4*sin(q2 + q3) - a3*d4*m4*sin(q2 + q3) - a3*m4*p5*sin(q2 + q3) - d2*m3*p3*sin(q2 + q3) - d3*m3*p3*sin(q2 + q3) - d2*m4*p4*cos(q2 + q3 + q4) - d3*m4*p4*cos(q2 + q3 + q4) - d4*m4*p4*cos(q2 + q3 + q4) - m4*p4*p5*cos(q2 + q3 + q4));
m31 = m13;
m14 = (- d2*m4*p4*cos(q2 + q3 + q4) - d3*m4*p4*cos(q2 + q3 + q4) - d4*m4*p4*cos(q2 + q3 + q4) - m4*p4*p5*cos(q2 + q3 + q4));
m41 = m14;
m24 = (m4*p4^2 - a2*m4*p4*sin(q3 + q4) - a3*m4*p4*sin(q4) + 7/625);
m42 = m24;
m22 = 2*((a2^2*m3)/2 + (a2^2*m4)/2 + (a3^2*m4)/2 + (m2*p2^2)/2 + (m3*p3^2)/2 + (m4*p4^2)/2 - a2*m4*p4*sin(q3 + q4) + a2*a3*m4*cos(q3) + a2*m3*p3*cos(q3) - a3*m4*p4*sin(q4) + 1337/10000);
m23 = (m4*a3^2 - 2*m4*sin(q4)*a3*p4 + a2*m4*cos(q3)*a3 + m3*p3^2 + a2*m3*cos(q3)*p3 + m4*p4^2 - a2*m4*sin(q3 + q4)*p4 + 287/5000);
m32 = m23;
m33 = 2*((m4*a3^2)/2 - m4*sin(q4)*a3*p4 + (m3*p3^2)/2 + (m4*p4^2)/2 + 287/10000);
m34 = (m4*p4^2 - a3*m4*sin(q4)*p4 + 7/625);
m43 = m34;
m44 = 2*((m4*p4^2)/2 + 7/1250);

M = [m11 m12 m13 m14;
    m21 m22 m23 m24;
    m31 m32 m33 m34;
    m41 m42 m43 m44];

simplify(expand(K-.5*dq'*M*dq))

M_numeral = double(subs(M,[m1 m2 m3 m4 q1 q2 q3 q4 d1 d2 d3 d4 a2 a3 p1 p2 p3 p4 p5],[3.7 8.393 2.275 2.626 -2.53 -1.39 .29 2.87 .163 .138 -.131 .127 .425 .392 -.02 .295 .342 -.05 .025]))

%% Potential Energy

m = [m1 m2 m3 m4];

r1g0 = T01(1:3,1:3)*r1g + T01(1:3,4);
r2g0 = T02(1:3,1:3)*r2g + T02(1:3,4);
r3g0 = T03(1:3,1:3)*r3g + T03(1:3,4);
r4g0 = T04(1:3,1:3)*r4g + T04(1:3,4);

V = m1*g*r1g0(3) + m2*g*r2g0(3) + m3*g*r3g0(3) + m4*g*r4g0(3); 

%% G vector
G = sym(zeros(4,1));
for k = 1:4
    G(k) = simplify(diff(V,q(k)));
end 
G;

G_numeral = double(subs(G,[m1 m2 m3 m4 q1 q2 q3 q4 d1 d2 d3 d4 a2 a3 p1 p2 p3 p4 p5 g],[3.7 8.393 2.275 2.626 -2.53 -1.39 .29 2.87 .163 .138 -.131 .127 .425 .392 -.02 .295 .342 -.05 .025 9.81]))


%% C matrix (Problem 1b)
C = sym(zeros(4,4));
for k=1:4
    for j=1:4
        for i=1:4
            C(k,j) = simplify(C(k,j) + (diff(M(k,j),q(i)) - 1/2*diff(M(i,j),q(k)))*dq(i));
        end
    end
end
C;

C_numeral = double(subs(C,[m1 m2 m3 m4 q1 q2 q3 q4 d1 d2 d3 d4 a2 a3 p1 p2 p3 p4 p5 g dq1 dq2 dq3 dq4],[3.7 8.393 2.275 2.626 -2.53 -1.39 .29 2.87 .163 .138 -.131 .127 .425 .392 -.02 .295 .342 -.05 .025 9.81 -.29 6.01 -7.16 -1.56]))


M
C
G
V