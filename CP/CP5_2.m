%% CP 5.2
clc,clear,close

%syms a1 a2 a3

a1 = 1;
a2 = 2;
a3 = 3;

q1 = 90;
q2 = -90;
q3 = -90;


T01 = modDH(0,0,0,q1);
T12 = modDH(0,a1,0,q2);
T23 = modDH(-pi/2,a2,0,q3);
T34 = modDH(0,a3,0,0);

T04 = round(T01*T12*T23*T34)

