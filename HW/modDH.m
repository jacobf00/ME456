function T = modDH(dh)

T = trotx(dh(1))*transl(dh(2),0,0)*transl(0,0,dh(3))*trotz(dh(4));