%% Problem 1
clc, clear, close
Rx90 = [1, 0, 0;
        0, 0, -1;
        0, 1, 0];
Rz90 = [0, -1, 0;
        1, 0, 0;
        0, 0, 1];
Ryneg90 = [0, 0, -1;
           0, 1, 0;
           1, 0, 0];
       
ARB = Rx90*Rz90*Ryneg90;

%% Problem 2
clc, clear, close

% Rx = [1, 0, 0;
%       0, cosd(thetax),-sind(thetax);
%       0, sind(thetax),cosd(thetax)];
%   
% Ry = [cosd(thetay), 0, sind(thetay);
%       0, 1, 0
%       -sind(thetay), 0, cosd(thetay)];
%   
% Rz = [cos(thetaz), -sind(thetaz), 0;
%       sind(thetaz), cosd(thetaz), 0;
%       0, 0, 1];
  
yaw = -107; %deg
pitch = -3; %deg
roll = 4; %deg

ApD = [86.2,-9.2,-18.2];
%ApD = transpose(ApD);

ApF = transpose([50,11,0,1]);

aRd = trotz(yaw,'deg')*troty(pitch,'deg')*trotx(roll,'deg');

aTd = transl(ApD)*aRd;

dTa = inv(aTd);

DpF = dTa*ApF;
DpF = transpose(DpF);
DpF = DpF(1:end-1);

fprintf('The position of the friend relative to the drone is (%5.2f x, %5.2f y, %5.2f z) (ft).\n',DpF(1),DpF(2),DpF(3))
% 
% hold on
% trplot(aTd)
% plot3(ApD(1),ApD(2),ApD(3), 'o')
% hold off


