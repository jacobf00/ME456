
clc,clear,close

DH = [0 0 0 0;
      pi/2 0 .138 0;
      0 .425 -.131 0;
      0 .392 .127 0;
      pi/2 0 .1 0;
      -pi/2 0 .1 0];
  

[r,c] = size(DH);
NDH = zeros(r,c);

for row=1:r
    new_row = DH(row,:);
    new_row = new_row(end:-1:1);
    NDH(row,:) = new_row;
end
  
DH = NDH;

%L = zeros(1,6);
%L(1) = Link((DH(1,:))(end:-1:1),'modified','revolute')

robot = SerialLink(DH,'modified');
robot.name = 'UR5';
robot.display
%robot.plot(zeros(1,6))

%% b c

T0G = transl(.3,.5,-.163)*trotx(pi);

q = robot.ikine(T0G,'q0',zeros(1,6));
figure
robot.plot(q)
hold on 
trplot(T0G)

fprintf('This set of joint angles is not acceptable because one or more of the robot''s joints is currently in the table')

%% d
clc,close

robot.teach()

%% d2
T0G = transl(.3,.5,-.163)*trotx(pi);

current_pose = robot.getpos();

q = robot.ikine(T0G,'q0',current_pose);
figure
robot.plot(q)
hold on 
trplot(T0G)