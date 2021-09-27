%% Problem 1
clc,clear,close

x0 = [-8 5 0];
x0 = x0.';

%L = [1 -3 4];
L = [3 -1 4];


%% Prob 1 plotting
clc

x = [-15:.5:15];
y = (L(1)*x + L(3))/-L(2);

figure(1)
hold on
plot(out.y(:,1),out.y(:,2))
plot(x,y,'linestyle','--')
xlabel('x (m)')
ylabel('y (m)')
title('trajectory')



%% Problem 2

%% save data
save('initial_data.mat')

%% load initial data
ti = out.tout;
xi = out.yout{1}.Values.Data;
yi = out.yout{2}.Values.Data;
thetai = out.yout{3}.Values.Data;
vi = out.yout{6}.Values.Data;
vRi = out.yout{4}.Values.Data;
vLi = out.yout{5}.Values.Data;

%% plot
clc,close

w = .8; %m
p = [6 8];
kh = 1;
kv = 1;

%IC = [0 0 0 ];
IC = [3 2 -pi];

t = out.tout;
x = out.yout{1}.Values.Data;
y = out.yout{2}.Values.Data;
theta = out.yout{3}.Values.Data;
v = out.yout{6}.Values.Data;
vR = out.yout{4}.Values.Data;
vL = out.yout{5}.Values.Data;

save('initial_data.mat')

figure(1)
hold on
plot(x,y,'linestyle','--')
plot(xi,yi)
xlabel('x (m)')
ylabel('y (m)')
title('trajectory')
hold off

figure(2)
hold on
plot(t,theta,'linestyle','--')
plot(ti,thetai)
xlabel('time (s)')
ylabel('theta (rad)')
title('theta vs time')
hold off

figure(3)
hold on
plot(t,v,'linestyle','--')
plot(ti,vi)
xlabel('time (s)')
ylabel('v (m/s)')
title('velocity vs time')
hold off

figure(4)
hold on
plot(t,vR,'linestyle','--')
plot(ti,vRi)
xlabel('time (s)')
ylabel('vR (m/s)')
title('right wheel velocity vs time')
hold off

figure(5)
hold on
plot(t,vL,'linestyle','--')
plot(ti,vLi)
xlabel('time (s)')
ylabel('vL (m/s)')
title('left wheel velocity vs time')
hold off


