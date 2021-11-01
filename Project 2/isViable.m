function viable = isViable(q,minMaxDH,type)
%script for comparing numerical inverse kine solution to DH limits to
%determine if solution is viable. returns 1 if is viable and 0 otherwise
numRows = length(q);
viable = 0;

if type=='rad'
    q = q.*(180/pi);
end

for i=1:numRows
    min = minMaxDH(i,1);
    max = minMaxDH(i,2);
    if(q(i) > min && q(i) < max)
        viable = 1;
    else
        if(q(i) < -180)
            q(i) = q(i) + 360;
            if(q(i) > min && q(i) < max)
                viable = 1;
            end
        end
        if(q(i) > 180)
            q(i) = q(i) - 360;
            if(q(i) > min && q(i) < max)
                viable = 1;
            end
        end
    end
        
            
            


end

