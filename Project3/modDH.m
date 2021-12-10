function T = modDH(alpha,a,d,theta)

T = trotx(alpha)*transl(a,0,0)*trotz(theta)*transl(0,0,d);