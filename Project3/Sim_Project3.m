clc,clear,close all

[t,y] = ode23(@ODEfun_Project3,[0 5],[.4 1.3 -.7 1.8 0 0 0 0]');

figure
subplot(1,2,1)

plot(t,y(:,1), t, y(:,2), t, y(:,3), t, y(:,4))
xlabel('Time (s)')
ylabel('q (m)')
title('q vs Time')

subplot(1,2,2)

plot(t,y(:,5), t, y(:,6), t, y(:,7), t, y(:,8))
xlabel('Time(s)')
ylabel('dq (rad/sec)')

title('dq vs Time')

%%Energy

K = zeros(length(t));
V = zeros(length(t));


for i=1:length(t)
    [dy,K(i),V(i)] = ODEfun_Project3(t(i),y(i,:)');
end

figure(2)
plot(t,V, t,K)
xlabel('Time (s)')
ylabel('Energy (J)')
legend('V','K')


