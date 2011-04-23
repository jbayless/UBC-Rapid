function sigma = RTD_calctemp(T,T0,alpha,sigma0)
%function sigma = RTD_calctemp(T,(T0),(alpha),(sigma0))
%
% UBC Rapid Induction Heater Project File
%Calculate conductance as a function of temperature
%Assuming first-order model of temperature-dependent resistance
%Default: Returns conductane of copper
%
% Inputs:
% T - Temperature vector (Celsius)
% T0 - Material calibration temperature (Celsius). Defaults to room temperature.
% alpha - first-order temperature coefficient of resistivity (per Celsius). Defaults to coefficient for copper.
% sigma0 - Material calibration conductivity (Siemens per meter). Defaults to conductivity of copper.
%
% Outputs:
% Sigma - vector of conductivities (Siemens per meter).
%
% v 1.0.1
% Jacob Bayless, February 2011
% UBC Rapid Team, RepRap Project
% Licensed for use under the GPL (Gnu Public License)


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