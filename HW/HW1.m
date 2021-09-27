%% Problem 2
clc, clear, close
theta = -140;
b_to_c = [3,2];
bTc = [cosd(theta),-sind(theta),3;
       sind(theta),cosd(theta),2;
       0          ,0          ,1];
cP = [1.5;-.5;1];
bP = bTc*cP;
bP = bP(1:2)

figure(1)
hold on
C = transl(b_to_c(1),b_to_c(2),0)*trotz(theta);
trplot(C)

xlim([0 5])
ylim([-1 5])
xlabel('X (m)')
ylabel('Y (m)')
plot(bP(1),bP(2),'o')
hold off

%% Problem 3
clc,clear,close
R = [0.2779,0.9081;-.9081,0.2779];

if norm(R) == 1
    disp("The Rotation matrix is valid because the vectors are orthonormal")
else
    disp("The Rotation matrix is NOT valid because the vectors are not orthonormal")
end

if det(R) == 1
    disp("The Rotation matrix is valid because the determinant is 1")
else
    disp("The Rotaion matrix is NOT valid because the determinant is not 1")
end
