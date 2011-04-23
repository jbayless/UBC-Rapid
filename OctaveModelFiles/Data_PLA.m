function [Density,ThermalConductivity,T_melt YoungsModulus, Viscosity] = Data_PLA
%function [Density,ThermalConductivity, T_melt, YoungsModulus, Viscosity] = Data_PLA
%Returns some important properties of PLA in SI units
%Also see Data_SpecificHeat_PLA for detailed thermal properties
%
%Jacob Bayless, Feb 2011


Density = 1320; %kg/m^3
ThermalConductivity = 0.3; %W/mK
YoungsModulus = 350000000 ; %Pa
T_melt = 450 %K

return