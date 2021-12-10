clc,clear,close

syms q0 q1 q2 q3 real
% q1 = 1;
% q2 = 2;
% q3 = 3;

fun = q1 + q1*q2 + q3;

C = symvar(fun);

subs(fun,[q0 q1 q2 q3], [0 1 2 3])

% Cnum = subs(,length(C));

% for i=1:length(C)
%     
% C(i)
% 
% end

