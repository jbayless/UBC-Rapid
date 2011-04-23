%function parasiticresistance

R = 3/1000;
Lp = 10/1000;
D = 2*R;
layers = 2;
d = Lp*layers/N
r = d/2;
a = pi*r^2;

L = sqrt((N*2*pi*r)^2+(Lp)^2);

sigma = RTD_calctemp(T);

parasistance = L./(a.*sigma);
T0_index = floor(0.5*numtemps);
T0 = T(T0_index);
parasistance0 = parasistance(find(T==T0));