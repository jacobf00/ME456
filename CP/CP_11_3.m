clc,clear,close

syms q1 q2 dq1 dq2 L1 L2 real
T01 = modDH(0,0,0,q1);
T12 = modDH(0,L1,0,q2);
T23 = modDH(0,L2,0,0);

v11 = [0 0 0]'
w11 = [0 0 dq1]'

v22 = T12(1:3,1:3)'*(v11+cross(w11,T12(1:3,4)))
w22 = T12(1:3,1:3)'*w11 + [0 0 dq2]'

v33 = T23(1:3,1:3)'*(v22+cross(w22,T23(1:3,4)))
w33 = T23(1:3,1:3)'*w22

T03 = T01*T12*T23;
v03 = simplify(T03(1:3,1:3)*v33)
w03 = T03(1:3,1:3)*w33