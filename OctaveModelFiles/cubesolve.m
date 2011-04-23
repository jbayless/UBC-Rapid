function x = cubesolve(a2,a1,a0, realonly)
%function x = cubesolve(a2,a1,a0)

Q = (3*a1 - a2^2)/9;
R = (9*a1*a2-27*a0-2*(a2^3))/54;
D = Q^3 + R^2;
S = (R+sqrt(D))^(1/3);
T = (R-sqrt(D))^(1/3);
x1 = (-a2/3)+S+T;
x2 = (-a2/3)-0.5*(S+T)+0.5*i*sqrt(3)*(S-T);
x3 = (-a2/3)-0.5*(S+T)-0.5*i*sqrt(3)*(S-T);

if(realonly)
	
	if(x1>0)
		x = x1;
		return
		endif
	if(x2>0)
		x=x2;
		return
		endif
	if(x3>0)
		x=x3;
		return
		endif
	endif
x = [x1, x2, x3];
return