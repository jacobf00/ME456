%% Problem 2
clc,clear,close

thetas = [32 -78 111 50 -62 19 0];
thetas = thetas*(pi/180);

T01 = modDH(0,0,0,thetas(1));
T12 = modDH(pi/2,90,0,thetas(2));
T23 = modDH(pi,450,0,thetas(3));
T34 = modDH(pi/2,0,400,thetas(4));
T45 = modDH(pi/2,0,0,thetas(5));
T56 = modDH(pi/2,0,0,thetas(6));
T67 = modDH(0,0,80,thetas(7));

T07 = T01*T12*T23*T34*T45*T56*T67