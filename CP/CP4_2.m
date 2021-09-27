clc,clear,close
%eyes open
load('C:\Users\fould\MATLAB Drive\MobileSensorData\eyes_open')
ax2 = Acceleration.X.^2;
ay2 = Acceleration.Y.^2;
az2 = Acceleration.Z.^2;

g = sqrt(ax2 + ay2 + az2);
g1 = g;
t = Acceleration.Timestamp;
std_open = std(g)
mean_open = mean(g)

figure(1)
hold on
plot(g)
xlabel('time')
ylabel('gravity (m/s^2)')
title('measured gravity over time (eyes open)')

%eyes closed
load('C:\Users\fould\MATLAB Drive\MobileSensorData\eyes_closed')
ax2 = Acceleration.X.^2;
ay2 = Acceleration.Y.^2;
az2 = Acceleration.Z.^2;

g = sqrt(ax2 + ay2 + az2);
g2 = g;
t = Acceleration.Timestamp;
std_closed = std(g)
mean_closed = mean(g)

plot(g)
xlabel('time')
ylabel('gravity (m/s^2)')
title('measured gravity over time')
legend('eyes open','eyes closed')
hold off

K = std_open/(std_open + std_closed);
g1 = g1(1:numel(g2));
g3 = g1 + K.*(g2-g1)
std3 = (1-K)*std_open