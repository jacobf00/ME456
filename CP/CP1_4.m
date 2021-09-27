clc,clear,close

zeroTR = [.837,-.479,.267,5;
           .483,.874,.053,1;
           -.259,.084,.962,-2;
           0,   0,  0,  1];
   
RpF = [.4,.5,-.1,1];
RpF = transpose(RpF);

zeropF = zeroTR * RpF