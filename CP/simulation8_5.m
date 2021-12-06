clc,clear,close

[t,y] = ode23(@twoLinkODE_student,[0 5],zeros(4,1));

subplot(1,2,1)
hold on
for i=1:2
    plot(t,y(:,i))
end
xlabel('time (s)')
ylabel('Angle (rad)')
legend('q1','q2')
hold off

subplot(1,2,2)
hold on
for i=3:4
    plot(t,y(:,i))
end
plot(t,zeros(length(y))')

%% Energy

% K = zeros(length(t));
% V = zeros(length(t));
% 
% for i=1:length(t)
%     [dy,K(i),V(i)] = twoLinkODE_student(
    