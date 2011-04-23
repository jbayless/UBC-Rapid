function sigma = RTD_calctemp(T,T0,alpha,sigma0)
%function sigma = RTD_calctemp(T,T0,alpha,sigma0)

sigma = 0;
TKelvin = 273.15;
T=T+TKelvin;
if(nargin < 4)
	sigma0 = 5.69e7;
	endif
	
if(nargin < 3)
	alpha = 0.004041;
	endif

if (nargin < 2)
	T0 = 20 + TKelvin;
	endif

rho0 = 1/sigma0;
rho = rho0.*(1+alpha.*(T-T0));
sigma = 1./rho;

%figure(2);
%plot(T,rho);
endfunction