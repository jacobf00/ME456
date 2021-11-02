%% Part B 
clc, clear

thetaRi = [100 95 90 90 90];
thetaDHi = [180 -90 0 -90 0];

thetaOi = [thetaRi - thetaDHi]

%% Part C Method 1 Case 1

theta = [180 -90 0 -90 0].*pi/180;
    
TB0 = [1 0 0 0;
    0 1 0 0;
    0 0 1 7.5;
    0 0 0 1];

dh = [pi 0 0 theta(1);
    pi/2 0 0 theta(2);
    0 12.5 0 theta(3);
    0 12.5 0 theta(4);
    pi/2 0 0 theta(5)];
    
T01 = modDH(dh(1,1),dh(1,2),dh(1,3),dh(1,4));
T12 = modDH(dh(2,1),dh(2,2),dh(2,3),dh(2,4));
T23 = modDH(dh(3,1),dh(3,2),dh(3,3),dh(3,4));
T34 = modDH(dh(4,1),dh(4,2),dh(4,3),dh(4,4));
T45 = modDH(dh(5,1),dh(5,2),dh(5,3),dh(5,4));

T5T = [1 0 0 0;
    0 1 0 0;
    0 0 1 -19.5;
    0 0 0 1];

TBT = TB0*T01*T12*T23*T34*T45*T5T

%% Part C Method 1 Case 2

theta = [180 -90 -90 -90 0].*pi/180;
    
TB0 = [1 0 0 0;
    0 1 0 0;
    0 0 1 7.5;
    0 0 0 1];

dh = [pi 0 0 theta(1);
    pi/2 0 0 theta(2);
    0 12.5 0 theta(3);
    0 12.5 0 theta(4);
    pi/2 0 0 theta(5)];
    
T01 = modDH(dh(1,1),dh(1,2),dh(1,3),dh(1,4));
T12 = modDH(dh(2,1),dh(2,2),dh(2,3),dh(2,4));
T23 = modDH(dh(3,1),dh(3,2),dh(3,3),dh(3,4));
T34 = modDH(dh(4,1),dh(4,2),dh(4,3),dh(4,4));
T45 = modDH(dh(5,1),dh(5,2),dh(5,3),dh(5,4));

T5T = [1 0 0 0;
    0 1 0 0;
    0 0 1 -19.5;
    0 0 0 1];

TBT = TB0*T01*T12*T23*T34*T45*T5T

%% Construct robot
close all

theta = [180 -90 0 -90 0].*pi/180;

dh = [pi 0 0 theta(1);
    pi/2 0 0 theta(2);
    0 12.5 0 theta(3);
    0 12.5 0 theta(4);
    pi/2 0 0 theta(5)];
    
Flipped_dh = flip_rows(dh);


L(1) = Link([Flipped_dh(1,1),Flipped_dh(1,2),Flipped_dh(1,3),Flipped_dh(1,4)],'modified','revolute');
L(1).qlim = [80 260].*pi/180;

L(2) = Link([Flipped_dh(2,1),Flipped_dh(2,2),Flipped_dh(2,3),Flipped_dh(2,4)],'modified','revolute');
L(2).qlim = [-170 -20].*pi/180;

L(3) = Link([Flipped_dh(3,1),Flipped_dh(3,2),Flipped_dh(3,3),Flipped_dh(3,4)],'modified','revolute');
L(3).qlim = [-90 90].*pi/180;

L(4) = Link([Flipped_dh(4,1),Flipped_dh(4,2),Flipped_dh(4,3),Flipped_dh(4,4)],'modified','revolute');
L(4).qlim = [-180 0].*pi/180;

L(5) = Link([Flipped_dh(5,1),Flipped_dh(5,2),Flipped_dh(5,3),Flipped_dh(5,4)],'modified','revolute');
L(5).qlim = [-90 90].*pi/180;


robot = SerialLink(L);
T5T = transl(0, 0, -19.5);
robot.tool = T5T;
robot.base = [0,0,7.5];

robot.plot(theta)
% robot.teach


%% Theta DH to theat Ri
thetaRi = [100 95 90 90 90];
thetaDHi = [180 -90 0 -90 0];

thetaOi = (thetaRi - thetaDHi);

thetaDHi = [180 -90 -90 -90 0]; % change this one
ThetaRi = thetaDHi+thetaOi

%% Arduino
% clear a s
% a = arduino('COM3','Uno','Libraries','Servo');
% s = servo(a,'A5');
% writePosition(s,.5)
%% Write pos

%% Part d analytical
clc, clear, close all
syms q1 q2 q3 q4 q5 x y z

theta = [q1 q2 q3 q4 q5];

dh = [pi 0 0 theta(1);
    pi/2 0 0 theta(2);
    0 12.5 0 theta(3);
    0 12.5 0 theta(4);
    pi/2 0 0 theta(5)];

TB0 = transl(0,0,7.5);
T01 = modDH(dh(1,1),dh(1,2),dh(1,3),dh(1,4));
T12 = modDH(dh(2,1),dh(2,2),dh(2,3),dh(2,4));
T23 = modDH(dh(3,1),dh(3,2),dh(3,3),dh(3,4));
T34 = modDH(dh(4,1),dh(4,2),dh(4,3),dh(4,4));
T45 = modDH(dh(5,1),dh(5,2),dh(5,3),dh(5,4));
T5T = transl(0, 0, -19.5);



% TB5 = TBT*(T5T^-1);
% T15 = simplify((T01^-1)*TB5)

% T05 = T01*T12*T23*T34*T45;
% T15_1 = simplify((T01^-1)*T05)
% T15_2 = simplify(T12*T23*T34*T45)
% 
% 
% T1T = T12*T23*T34*T45*T5T
TBT = simplify(TB0*T01*T12*T23*T34*T45*T5T) %r's and p's
% TBTG = 

TB2 = TB0*T01*T12;
T25 = simplify((TB2^-1)*TB5)

%% Part D numerical 
clc, clear, close all

T_BT_G = transl(5,-5,45)*trotz(atan2(-5,5))*troty(180,'deg')*trotz(90,'deg');
mask = [1 1 1 0 1 1];

% Make robot and guess

theta = [180 -90 0 -90 0].*pi/180;

dh = [pi 0 0 theta(1);
    pi/2 0 0 theta(2);
    0 12.5 0 theta(3);
    0 12.5 0 theta(4);
    pi/2 0 0 theta(5)];
    
Flipped_dh = flip_rows(dh);


L(1) = Link([Flipped_dh(1,1),Flipped_dh(1,2),Flipped_dh(1,3),Flipped_dh(1,4)],'modified','revolute');
L(1).qlim = [80 260].*pi/180;

L(2) = Link([Flipped_dh(2,1),Flipped_dh(2,2),Flipped_dh(2,3),Flipped_dh(2,4)],'modified','revolute');
L(2).qlim = [-170 -20].*pi/180;

L(3) = Link([Flipped_dh(3,1),Flipped_dh(3,2),Flipped_dh(3,3),Flipped_dh(3,4)],'modified','revolute');
L(3).qlim = [-90 90].*pi/180;

L(4) = Link([Flipped_dh(4,1),Flipped_dh(4,2),Flipped_dh(4,3),Flipped_dh(4,4)],'modified','revolute');
L(4).qlim = [-180 0].*pi/180;

L(5) = Link([Flipped_dh(5,1),Flipped_dh(5,2),Flipped_dh(5,3),Flipped_dh(5,4)],'modified','revolute');
L(5).qlim = [-90 90].*pi/180;

robot = SerialLink2(L);
T5T = transl(0, 0, -19.5);
robot.tool = T5T;
robot.base = [0,0,7.5];

robot.teach
hold on 
trplot(T_BT_G,'length',10)


%% extract initial pose

% q0 = robot.getpos
% q0 = [3.1241   -2.4609    0.8482   -1.5080   -0.7540]; % first guess
q0 = [3.6582   -1.5272   -1.3509   -0.3770   -1.2252]; % second guess
% q0 = [1.3963   -1.7628    0.0314   -0.7226    0.4084]; % third guess
%% Solve numerical

q = robot.ikine(T_BT_G,'q0',q0)
hold on
trplot(T_BT_G,'length',10)
robot.plot(q)

% Check
q_check = robot.fkine(q)



%% Moving the robot grab block
clc, clear, close all

%grab block
T_BT_G = transl(25.5,23,1.25)*trotz(-140,'deg')*troty(90,'deg')

% Make robot and guess

theta = [180 -90 0 -90 0].*pi/180;

dh = [pi 0 0 theta(1);
    pi/2 0 0 theta(2);
    0 12.5 0 theta(3);
    0 12.5 0 theta(4);
    pi/2 0 0 theta(5)];
    
Flipped_dh = flip_rows(dh);


L(1) = Link([Flipped_dh(1,1),Flipped_dh(1,2),Flipped_dh(1,3),Flipped_dh(1,4)],'modified','revolute');
L(1).qlim = [80 260].*pi/180;

L(2) = Link([Flipped_dh(2,1),Flipped_dh(2,2),Flipped_dh(2,3),Flipped_dh(2,4)],'modified','revolute');
L(2).qlim = [-170 -20].*pi/180;

L(3) = Link([Flipped_dh(3,1),Flipped_dh(3,2),Flipped_dh(3,3),Flipped_dh(3,4)],'modified','revolute');
L(3).qlim = [-90 90].*pi/180;

L(4) = Link([Flipped_dh(4,1),Flipped_dh(4,2),Flipped_dh(4,3),Flipped_dh(4,4)],'modified','revolute');
L(4).qlim = [-180 0].*pi/180;

L(5) = Link([Flipped_dh(5,1),Flipped_dh(5,2),Flipped_dh(5,3),Flipped_dh(5,4)],'modified','revolute');
L(5).qlim = [-90 90].*pi/180;

robot = SerialLink(L);
T5T = transl(0, 0, -19.5);
robot.tool = T5T;
robot.base = [0,0,7.5];

robot.teach()
hold on 
trplot(T_BT_G,'length',10)

%% get guess
% q0 = robot.getpos
q0 = [2.3387   -2.4435   -0.7854   -1.8850         0]

%% Solve numerical and check if viable

minMax = [80 260;
          -170 -20;
          -90 90;
          -180 0;
          -90 90];
%grab block
T_BT_G = transl(25.5,23,1.25)*trotz(-140,'deg')*troty(90,'deg')
mask = [1 1 1 0 1 1];


q = robot.ikine(T_BT_G,'q0',q0,'mask',mask)
hold on
trplot(T_BT_G,'length',10)
robot.plot(q)

thetaRi = [100 95 90 90 90];
thetaDHi = [180 -90 0 -90 0];

thetaOi = (thetaRi - thetaDHi);

qdeg = q*180/pi
ThetaRi = qdeg+thetaOi

viable = isViable(q,minMax,'rad')

%% To top of block
clc, clear, close all

%grab block
T_BT_G = transl(36,-10,16.5)*trotz(-200,'deg')*troty(90,'deg')

% Make robot and guess

theta = [180 -90 0 -90 0].*pi/180;

dh = [pi 0 0 theta(1);
    pi/2 0 0 theta(2);
    0 12.5 0 theta(3);
    0 12.5 0 theta(4);
    pi/2 0 0 theta(5)];
    
Flipped_dh = flip_rows(dh);


L(1) = Link([Flipped_dh(1,1),Flipped_dh(1,2),Flipped_dh(1,3),Flipped_dh(1,4)],'modified','revolute');
L(1).qlim = [80 260].*pi/180;

L(2) = Link([Flipped_dh(2,1),Flipped_dh(2,2),Flipped_dh(2,3),Flipped_dh(2,4)],'modified','revolute');
L(2).qlim = [-170 -20].*pi/180;

L(3) = Link([Flipped_dh(3,1),Flipped_dh(3,2),Flipped_dh(3,3),Flipped_dh(3,4)],'modified','revolute');
L(3).qlim = [-90 90].*pi/180;

L(4) = Link([Flipped_dh(4,1),Flipped_dh(4,2),Flipped_dh(4,3),Flipped_dh(4,4)],'modified','revolute');
L(4).qlim = [-180 0].*pi/180;

L(5) = Link([Flipped_dh(5,1),Flipped_dh(5,2),Flipped_dh(5,3),Flipped_dh(5,4)],'modified','revolute');
L(5).qlim = [-90 90].*pi/180;

robot = SerialLink(L);
T5T = transl(0, 0, -19.5);
robot.tool = T5T;
robot.base = [0,0,7.5];

robot.teach
hold on 
trplot(T_BT_G,'length',10)
hold off
%% get guess
% q0 = robot.getpos
q0 = [3.5640   -2.1293   -1.2881   -1.2566         0]

%% Solve numerical


% grab block
T_BT_G = transl(36,-10,16.5)*trotz(-200,'deg')*troty(90,'deg')
mask = [1 1 1 0 1 1];


q = robot.ikine(T_BT_G,'q0',q0,'mask',mask)
hold on
trplot(T_BT_G,'length',10)
robot.plot(q)

thetaRi = [100 95 90 90 90];
thetaDHi = [180 -90 0 -90 0];

thetaOi = (thetaRi - thetaDHi)

qdeg = q*(180/pi)
ThetaRi = qdeg+thetaOi
possibleq1 = ThetaRi(1)+360