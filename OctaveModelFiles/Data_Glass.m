function [Density,ThermalConductivity, YoungsModulus, CoeffExp] = Data_Glass
%function [Density,ThermalConductivity, YoungsModulus, Viscosity] = Data_Glass
%Returns some important properties of glass in SI units
%
%
%Jacob Bayless, Feb 2011


Density = 2230; %kg/m^3
ThermalConductivity = 1.005; %W/mK
YoungsModulus = 62784000000; %Pa
CoeffExp = 3.25e-7; %/K

return