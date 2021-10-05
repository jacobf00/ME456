%% Project 1 
%% 2c

time = yout{1}.Values.Time;
x_data = yout{1}.Values.Data;
y_data = yout{2}.Values.Data;
theta_data = yout{3}.Values.Data;

subplot(2,2,1)
plot(x_data, y_data)
title('Time Based control x vs y')
xlabel('x(m)')
ylabel('y(m)')

subplot (2,2,2)
plot(time,x_data)
title('Time Based control x vs t')
xlabel('t(s)')
ylabel('x(m)')

subplot(2,2,3)
plot(time,y_data)
title('Time Based control y vs t')
xlabel('t(s)')
ylabel('y(m)')

subplot(2,2,4)
plot(time,theta_data)
title('Time Based control \theta vs t')
xlabel('t(s)')
ylabel('\theta (rad)')
