clc,clear,close

%Initialize Robot

p = [-.2 .1]; %Desired end effector pose

DH = [0 0 0 pi/2;
      90*pi/180 0 .3 pi;
      pi/2 0 0 pi/2;
      0 .15 0 0];

L(1) = Link(DH(1,:),'modified','revolute');
L(1).qlim = [30 330]*pi/180;
L(2) = Link(DH(2,:),'modified','prismatic');
L(2).jointtype = 'P';
L(2).qlim = [.1 .4];
L(3) = Link(DH(3,:),'modified','revolute');
L(3).qlim = [-45 225]*pi/180;
robot = SerialLink(L);
T_3T = transl(.15,0,0);
robot.tool = T_3T;

figure
robot.plot([pi/2 .3 pi/2])
