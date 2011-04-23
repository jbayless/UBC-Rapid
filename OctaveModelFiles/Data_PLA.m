function [Density,ThermalConductivity,T_melt YoungsModulus, Viscosity] = Data_PLA
%function [Density,ThermalConductivity, T_melt, YoungsModulus, Viscosity] = Data_PLA
% UBC Rapid Induction Heater Project File
%Returns some important properties of PLA in SI units
%Also see Data_SpecificHeat_PLA for detailed thermal properties
%
%Jacob Bayless, Feb 2011
% UBC Rapid Team, RepRap Project
% Licensed for use under the GPL (Gnu Public License)


Density = 1320; %kg/m^3
ThermalConductivity = 0.3; %W/mK
YoungsModulus = 350000000 ; %Pa
T_melt = 450 %K

return