%% Problem 1
clc,clear,close

t = [0:.1:15];
T = 15; %seconds


A = [0, 0, 0, 0, 0, 1;
     0, 0, 0, 0, 1, 0;
     0, 0, 0, 1, 0, 0;
     T^5,T^4,T^3,T^2,T,1;
     20*T^3,12*T^2,6*T,2,0,0;
     60*T^2,24*T,6,0,0,0];
 
b = [0;0;0;40;0;0];

coeffs = A\b;

s = polyval(coeffs,t);

figure(1)
plot(t,s)
xlabel('time (s)')
ylabel('position (ft)')
title('position vs time')

%% Problem 2
clc,clear,close

x0 = 0;
xf = 50;
M = 50;
vmax = 1.25; %m/s

[s,ds,dds] = lspb(x0,xf,M,vmax);

while dds(1) >= .1
    M = M + 1;
    [s,ds,dds] = lspb(x0,xf,M,vmax);
    
end

lspb(x0,xf,M,vmax);


%% Problem 3
clc,clear,close

w = .8; %m/s
v = 2; %m/s
theta_dot  = .8; %rad/s



