%% Collaborative Problem 8.5 Solution

%% Integrate
[t, y] = ode23(@twoLinkODE,[0 5],zeros(4,1));

figure
plot(t,y(:,1:2))
xlabel('Time (s)')
ylabel('Angle (rad)')
legend('show','q_1','q_2')

%% Energy
K = zeros(size(t));
V = zeros(size(t));
for i=1:length(t)
    [dy, K(i), V(i)] = twoLinkODE(t(i),y(i,:)');
end
E = K+V;

figure
plot(t,K, t,V, t,E)
xlabel('Time (s)')
ylabel('Energy (J)')
legend('show','K','V','Total')