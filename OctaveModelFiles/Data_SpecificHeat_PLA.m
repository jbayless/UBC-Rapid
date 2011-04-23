function [Temperatures, SpecificHeats, index_room, index_glasstrans, index_melt,avgSpecHeatSolid,avgSpecHeatGlass] = Data_SpecificHeat_PLA
%function [Temperatures, SpecificHeats] = Data_SpecificHeat_PLA
%Returns a vector of temperatures between 5 and 600 K, and of the corresponding specific heat capacities of polylactic acid in J/kgK
%Also returns indices of room temperature, glass transition point, and melting point for convenient calculation of average values, etc
%
%Source:
%Pyda, M., Bopp, R., Wunderlich, B. 2004. Heat capacity of poly(lactic acid), J. Chem. 
%
%Jacob Bayless, Feb 2011

Temperatures =[5,6,7,8,9,10,15,20,25,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,190,200,210,220,230,240,250,260,270,280,290,298.15,300,310,320,330,332.5,340,350,360,370,380,390,400,410,420,430,440,450,460,470,480,490,500,510,520,530,540,550,560,570,580,590,600];
SpecificHeats =[4.30197058,8.326394671,13.18345823,18.59561477,24.70163752,31.22398002,67.30502359,107.4104913,146.8914793,182.4868165,250.6244796,313.4193727,368.7898973,422.6339162,474.5351096,524.1465445,570.9825146,616.1532057,659.450458,701.0824313,741.187899,779.9056342,818.4845962,856.3696919,852.0677213,930.8909242,967.9433805,1004.024424,1040.244241,1075.631418,1111.990008,1149.042465,1169.164585,1208.853733,1246.461282,1283.374965,1314.043852,1322.50902,1361.781848,1409.797391,1556.480711,2018.318068,2026.228143,2036.77491,2047.321676,2057.868443,2068.41521,2078.961976,2089.508743,2100.055509,2110.602276,2121.149042,2131.695809,2142.242576,2152.789342,2163.336109,2173.882875,2184.429642,2194.976409,2205.523175,2216.069942,2226.616708,2237.163475,2247.710241,2258.257008,2268.803775,2279.350541,2289.897308,2300.444074];
index_room = find(Temperatures == 290);
index_glasstrans = find(Temperatures == 332.5);
index_melt = find(Temperatures == 450);

avgSpecHeatSolid = mean(SpecificHeats(index_room:(index_glasstrans-1)));
avgSpecHeatGlass = mean(SpecificHeats(index_glasstrans:(index_melt-1)));

return