clc,clear,close all
load('EOMs.mat')
[t,y] = ode23(@ODEfun_Project3,[0 5],[.4 1.3 -.7 1.8 0 0 0 0]');

figure
subplot(1,2,1)

plot(t,y(:,1))
xlabel('Time (s)')
ylabel('q_1 (m)')
title('q_1 vs Time')

subplot(1,2,2)

plot(t,y(:,2))
xlabel('Time(s)')
ylabel('q_2 (rad)')

title('q_2 vs Time')

%% 3a) Energy

K = zeros(length(t));
V = zeros(length(t));


for i=1:length(t)
    [dy,K(i),V(i)] = ODEfun_Project3(t(i),y(i,:)');
end

figure
hold on
plot(t,V)
plot(t,K)
plot(t,K+V)
xlabel('Time (s)')
ylabel('Energy (J)')
hold off
legend('V','K','Total')


