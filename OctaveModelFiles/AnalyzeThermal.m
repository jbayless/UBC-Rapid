
kelvin = 273.15;
[dens_plastic,k_plastic,T_melt] = Data_PLA; %Physical properties of PLA
 [dens_glass, k_glass] = Data_Glass; %Physical properties of glass
 T_env = 20+kelvin;
 L_glass = 60/1000; %60 mm
 
 numpts = 100;
 C_plastic = 2221;
 r_plastic = 1.5/1000; %3mm dia
 r_glass = 3/1000; %6mm dia
 P_in = 10; %watts
 
 [y, T_y, flow, P_in] = HeatTransfer (C_plastic,dens_plastic,r_plastic,r_glass,k_plastic,k_glass,L_glass,numpts,T_env,P_in,T_melt,-1)
 
 plot (y, T_y-kelvin);