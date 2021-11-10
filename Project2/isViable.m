function viable = isViable(q,minMaxDH,type)
%script for comparing numerical inverse kine solution to DH limits to
%determine if solution is viable. returns 1 if is viable and 0 otherwise
numRows = length(q);
viable = 0;

original_viable = 0;
negative_viable = 0;
positive_viable = 0;

if(type=='rad')
    q = q.*(180/pi);
end

for i=1:numRows
    min = minMaxDH(i,1) - 5;
    max = minMaxDH(i,2) + 5;
    if(q(i) >= min && q(i) <= max)
        viable = viable + 1;
        original_viable = original_viable + 1;
    else
        if(q(i) <= -180)
            q(i) = q(i) + 360;
            if(q(i) >= min && q(i) <= max)
                viable = viable + 1;
                negative_viable = negative_viable + 1;
            end
        elseif(q(i) >= 180)
            q(i) = q(i) - 360;
            if(q(i) >= min && q(i) <= max)
                viable = viable + 1;
                positive_viable = positive_viable + 1;
            end
        end
    end
%     fprintf('q is %d\n',q) 
end

viable
if viable == 5
    viable = 1;
else
    viable = 0;


end

