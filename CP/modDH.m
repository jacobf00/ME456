function T = modDH(alpha,a,d,theta)

T = trotx(alpha)*transl(a,0,0)*transl(0,0,d)*trotz(theta);