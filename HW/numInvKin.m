%% Make robot - 2-link planar robot
L(1) = Link([0 0 0 0],'modified','revolute');
L(1).qlim = [-150 150]*pi/180;
L(2) = Link([0 0 1 0],'modified','revolute');
L(2).qlim = [-150 150]*pi/180;
robot = SerialLink(L);
T_2T = transl(1,0,0);
robot.tool = T_2T;

figure
robot.plot([0 0])

%% Specify goal
T_0T_G = transl(0.8,0.5,0)
mask = [1 1 0 0 0 0];

%% Find initial guess
robot.teach
hold on
trplot(T_0T_G)

% After playing around
q0 = [-24 117]*pi/180;

%% Find solution
q = robot.ikine(T_0T_G,'q0',q0,'mask',mask)
robot.plot(q)

%% Check solution
robot.fkine(q)