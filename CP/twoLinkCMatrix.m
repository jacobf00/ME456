%% Find the C matrix for the two-link robot
% Copy over the mass matrix CP 8.2 and then find C matrix

%% Set up
syms q1 q2 real
syms dq1 dq2 real
syms L1 L2 p1 p2 real
syms m1 m2 I1 I2 real

% Generalized coordinates
q = [q1 q2]';
dq = [dq1, dq2]';

% Mass matrix
m11 = m2*L1^2 + 2*m2*cos(q2)*L1*p2 + m1*p1^2 + m2*p2^2 + I1 + I2;
m12 = m2*p2^2 + L1*m2*cos(q2)*p2 + I2;
m22 = m2*p2^2 + I2;

M = [m11 m12; m12 m22];


%% C matrix
C = sym(zeros(2,2));
for k=1:2
    for j=1:2
        for i=1:2
            C(k,j) = simplify(C(k,j) + (diff(M(k,j),q(i)) - 1/2*diff(M(i,j),q(k)))*dq(i));
        end
    end
end
C

