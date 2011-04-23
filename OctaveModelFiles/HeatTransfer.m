function [y, T_y, flow, P_in] = HeatTransfer (C_plastic,dens_plastic,r_plastic,r_glass,k_plastic,k_glass,L_glass,numpts,T_env,P_in,T_melt,flow)
%function [T_y, flow, P_in] = HeatTransfer (C_plastic,dens_plastic,r_plastic,r_glass,k_plastic,k_glass,L_glass,T_env,P_in,T_melt,flow)
%Calculates the temperature distribution in a glass extruder, using a one-dimensional model with heat conduction and plastic flow
%
%T_y is the temperature as a function of the distance y from the heater plate (K)
%flow is the volume flow rate in the extruder (m^3/s)
%P_in is the input heating power (W)
%
%C_plastic is the specific heat capacity of the plastic (J/kgK)
%
%dens_plastic is the density of the plastic (kg/m^3)
%r_plastic is the radius of plastic filament (m)
%r_glass is the outer radius of the extruder barrel (m)
%k_plastic is the thermal conductivity of the plastic (W/mK)
%k_glass is the thermal conductivity of the glass (W/mK)
%L_glass is the length of the glass barrel, or the distance to the heat sink (m)
%numpts is the number of locations at which to calculate the temperature between 0 and L_glass
%T_env is the atmospheric temperature (Celsius)
%P_in is the input heating power (W), put -1 if unknown
%T_melt is the maximum temperature achieved in the extruder (K), put -1 if unknown
%flow is the volume flow rate in the extruder (m^3/s), put -1 or leave blank if unknown
%
%two of P_in, T_melt, or flow must be specified. The third will be calculated based on the other two.
%
% Jacob Bayless, January 2011
% UBC Rapid and RepRap


%Check for insufficient inputs



if(nargin < 10)
	disp("Heat Transfer: Insufficient  arguments")
	return
endif
numUnknowns = 0;
if(P_in < 0)
	numUnknowns++;
endif
if(T_melt < 0)
	numUnknowns++;
endif
if(or(flow < 0, nargin == 10))
	numUnknowns++;
endif
if(numUnknowns~=1)
	disp("Heat Transfer: Insufficient arguments")
	return
endif


y = linspace(0,L_glass,numpts); %linear spaced array of heights

A_plastic = pi*r_plastic^2;
A_glass = pi*(r_glass^2 - r_plastic^2);
kA = k_plastic*A_plastic + k_glass*A_glass; %combined thermal conductivity
[Temperatures, SpecificHeats, index_room, index_glasstrans, index_melt,avgSpecHeatSolid,avgSpecHeatGlass] = Data_SpecificHeat_PLA;

if(flow >=0) %flow rate is known
	vapc = flow*dens_plastic*C_plastic;
	vapka = vapc/ka;
	exp1 = exp(-vapka*L_glass);
	exp2 = exp(-vapka.*y);
	exp3 = 1-exp1;
	exp4 = 1-exp2;
	exp5=exp(vapka*L_glass)-1;
	if(T_melt >=0) %T_melt is known
	
		%Calculate P_in
		P_in =vapc*(T_melt-T_env)*(1+1/exp5);
	else %P_in is known

		%Calcualte T_melt
		T_melt = (P_in/(vapka*(1+1/exp5)))+T_env;		
		
	endif
	%Calculate T_y
		T_y = T_melt + (T_env - T_melt).*exp4./exp3;
else
	%flow rate is unknown
	%this is a transcendental equation so it must be solved differently
	guess = P_in/((T_melt-T_env)*dens_plastic*C_plastic)
	equilibrium = @(flow) (P_in - flow*dens_plastic*C_plastic*(T_melt-T_env)*(1+1/(exp(flow*dens_plastic*C_plastic*L_glass/kA)-1)))
	[flow,FVAL,INFO]= fzero (equilibrium, [0.5*guess,2*guess])
	vapc = flow*dens_plastic*C_plastic;
	
	%Calculate T_y
	vapka = vapc/kA;
	exp1 = exp(-vapka*L_glass);
	exp2 = exp(-vapka.*y);
	exp3 = 1-exp1;
	exp4 = 1-exp2;
	T_y = T_melt + (T_env - T_melt).*exp4./exp3;
endif
	
return
