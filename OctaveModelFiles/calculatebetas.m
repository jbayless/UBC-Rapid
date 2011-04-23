function [R0, L0, betaR, betaL] = calculatebetas (T,T0,resistance,inductance)
%function [R0, L0, betaR, betaL] = calculatebetas (T,T0,resistance,inductance)

% what are betas?
%if resistance and inductance don't change much over the range of temperatures, then we can represent them by a linear function
%beta is the slope
% R(T) = R0(T0) + betaR*(T-T0)
% L(T) = L0(T0) + betaL*(T-T0)
% one way to calculate the betas is to take the slope about T0
% Another way is to calculate the average slope of the entire function by dividing the range by the domain
% Which method is the best approximation depends on which temperature is chosen to be T0
%Note, this method assumes a linspaced T.

T0_index = find(T == T0);
T0_indp = T0_index+1;
T0_indpp = T0_index+2;
T0_indm = T0_index-1;
T0_indmm = T0_index-2;
dT4 = T(T0_indpp)-T(T0_indmm);
dT = 0.25*dT4;

R0 = resistance(:,T0_index);
L0 = inductance(:,T0_index);

%use the five-point stencil to calculate the first derivative
if(and((T0_indp < length(T)),(T0_indm>1)))	
	betaR = (-resistance(:,T0_indpp)+8*resistance(:,T0_indp)-8*resistance(:,T0_indm)+resistance(:,T0_indmm))/(3*dT4);
	betaL = (-inductance(:,T0_indpp)+8*inductance(:,T0_indp)-8*inductance(:,T0_indm)+inductance(:,T0_indmm))/(3*dT4);
	return
	endif
	
%if we're too close to the endpoint to use the five-point stencil
if(or((T0_indp == length(T)),(T0_indm == 1)))	
	betaR = (resistance(:,T0_indp)-resistance(:,T0_indm))/(2*dT);
	betaL = (inductance(:,T0_indp)-inductance(:,T0_indm))/(2*dT);
	return
	endif
	
%if T0 is right at the leading edge
if(T0_index == 1)	
	betaR = (resistance(:,T0_indp)-resistance(:,T0_index))/dT;
	betaL = (inductance(:,T0_indp)-inductance(:,T0_index))/dT;
	return
	endif
	
	%if T0 is right at the trailing edge
if(T0_index == length(T))	
	betaR = (resistance(:,T0_index)-resistance(:,T0_indm))/dT;
	betaL = (inductance(:,T0_index)-inductance(:,T0_indm))/dT;
	return
	endif
	
