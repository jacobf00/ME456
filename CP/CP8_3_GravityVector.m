%% Collaborative Problem 8.3

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

%% a) Potential energy
syms m1 m2 real
syms g real

% T02 = T01*T12;
% T = [T01 T02];
% 
% gv = [0 -g 0]'
% 
% m = [m1 m2];
% r0gi = [r1g r2g];
% 
% V = sym(zeros(1,1));
% 
% for i=1:2
%     V = V + m(i)*(dot(gv,T(i)(1:3,1:3)*r0gi(i)));
% end
% V
%%%%%%%%% ADD CODE HERE %%%%%%%%%

r1g0 = T01(1:3,1:3)*r1g + T01(1:3,4);
r2g0 = T02(1:3,1:3)*r2g + T02(1:3,4);

% Energy
V = m1*g*r1g0(2) + m2*g*r2g0(2)



%% b) G vector
G = sym(zeros(2,1));
for k=1:2
    G(k) = simplify(diff(V,q(k)));
end
G
%%%%%%%%% ADD CODE HERE %%%%%%%%%