function [reflect_resistance,resistance,current,I2R,inductance,vac_primary,s,E,B] = maxwell(I0,N,Lp,Ls,rin,rout,R,freq,sigma,numxvals)
%function [reflect_resistance,resistance,current,I2R,inductance,vac_primary,vac_primary2,s,E,B] = maxwell(I0,N,Ls,rin,rout,R,freq,sigma,numxvals)
% UBC Rapid Induction Heater Project File
% This function solves the electric and magnetic field distributions in the ring extruder, and finds the effective resistance, inductance, current distribution, etc.
% Assumes a semi-infinite cylindrically-symmetric system
% For mathematical details, see ExactMaxwell3.docx
%
%
% Inputs:
%
% I0 - The peak amplitude of the driving current in the primary coil. I(t) = I0*sin(2*pi*freq*t)
% N - Number of windings in the primary coil
% Lp - Length of the primary coil, in metres. Typical value: 10/1000 (1 cm)
% Ls - Length of the secondary "coil" (actually just a metal ring, so it's the height of the ring), in metres. Typical value: 2/1000 (2 mm)
% rin - Inner radius of the secondary coil (ring inner radius). Typical value: 1/1000 (1 mm)
% rout - Outer radius of the secondary coil (ring outer radius). Typical value: 1.5/1000 (1.5 mm, for a 3 mm diameter ring)
% R - radius of primary coil (outer radius of glass tube). Typical value: 3/1000 (3 mm, for a 6 mm diameter tube)
% freq -  frequency of the driving current in the primary coil.  I(t) = I0*sin(2*pi*freq*t)
% sigma - Conductivity of the metal ring in Siemens per metre. Should be a single number. Typical value: 5.69e7 (Copper at room temperature)
% numxvals - Fineness of length scale of output. Each of the four spatial regions are discretized into this many points, so the output data has 4*numxvals entries.
%
% Outputs:
% 
% reflect_resistance - The power-dissipation equivalent resistance of the ring as a load on the primary coil (Ohms)
% resistance - The power-dissipation equivalent resistance seen by the current in the secondary ring (Ohms)
% current - The total current circulating in the secondary (Amps)
% I2R - The power dissipated in the secondary ring (Watts)
% inductance - the inductance of the system as it appears to the primary coil (Henries)
% vac_primary - the voltage phasor on the primary coil (Volts)
% s - the array of spatial coordinates used in the calculation (in metres)
% E - the circumferential electric field phasor at the points 's' (Volts/metre)
% B - the axial magnetic flux density phasor at the points 's' (Tesla)
%
% 
% v 1.0.12
% Jacob Bayless, April 2011
% UBC Rapid Team, RepRap Project
% Licensed for use under the GPL (Gnu Public License)


%define error output values
resistance = -1;
current = -1;
I2R = -1;
inductance =-1;
vac_primary = -1;
ier = 1;
s = -1;
E = -1;
B = -1;

% Construction geometry (mm/1000 = m)

t = rout-rin;
%rout = rin + t;
%Lp = 1/1000; %used to be 10
%Ls = 3/1000;

din = 2*rin;
dout = 2*rout;
D = 2*R;

% radius variable s
s0 = linspace(0,rin,numxvals);
s1 = linspace(rin,rout,numxvals);
s2 = linspace(rout,R,numxvals);
s3 = linspace(R,2*R,numxvals);
s = [s0,s1,s2,s3];
sscale=s/rout;

% Driving frequency
%freq = 5*10^5;
%freq = 1;
%freq = 10^3;
w = 2*pi*freq;

% Driving current (amps) and windings
%I0 = 2;
%N = 60;

% Physical constants
mu0 = 1.25663706e-6;
eps0 = 8.85418782e-12;
c = 299792458;
k = w/c;

% Metal properties: Copper
%sigma = 1;
%sigma = 5.69e7;
%experimental: Modify conductivity by the length ratio
sigma = sigma.*Ls./Lp;
% experimental:
Ls = Lp;
mur = 1;
mu = mur*mu0;
epsr = 1;
epst = epsr*eps0;
kappa = sqrt(bsxfun(@plus,i*mu*sigma*w, mu*epst.*w.^2));

% Common Bessel Functions
% at rin
J0_krin = besselj(0,k*rin);
J0_kapparin = besselj(0,kappa*rin);
Y0_krin = bessely(0,k*rin);
Y0_kapparin = bessely(0,kappa*rin);

J1_krin = besselj(1,k*rin);
J1_kapparin = besselj(1,kappa*rin);
Y1_krin = bessely(1,k*rin);
Y1_kapparin = bessely(1,kappa*rin);

% at rout
J0_krout = besselj(0,k*rout);
J0_kapparout = besselj(0,kappa*rout);
Y0_krout = bessely(0,k*rout);
Y0_kapparout = bessely(0,kappa*rout);

J1_krout = besselj(1,k*rout);
J1_kapparout = besselj(1, kappa*rout);
Y1_krout = bessely(1, k*rout);
Y1_kapparout = bessely(1, kappa*rout);

% at R

J0_kR = besselj(0,k*R);
Y0_kR = bessely(0,k*R);
J1_kR = besselj(1,k*R);
Y1_kR = bessely(1,k*R);


% A constants
%A15 = (J0_krin/J0_kapparin)-(((kappa/k)*J1_krin*Y0_krin)-(J0_krin/J0_kapparin)*J1_kapparin*Y0_kapparin)/(Y1_kapparin*J0_kapparin-J1_kapparin*Y0_kapparin);

%A15 = (J0_krin/J0_kapparin)-(Y0_kapparin/J0_kapparin)*((kappa/k)*J0_kapparin*J1_krin-J0_krin*J1_kapparin)/(Y1_kapparin*J0_kapparin-Y0_kapparin*J1_kapparin);
A16 = ((kappa/k)*J0_kapparin*J1_krin-J0_krin*J1_kapparin)/(Y1_kapparin*J0_kapparin-Y0_kapparin*J1_kapparin);
A15 =  (J0_krin/J0_kapparin)-(Y0_kapparin/J0_kapparin)*A16;

%A57 = (J0_kapparout/J0_krout)*(1+((k/kappa)*(J0_krout/J0_kapparout)*J1_kapparout-J1_krout)/(J1_krout+J0_krout*(Y1_krout/Y0_krout)));
%A67 = (Y0_kapparout/J0_krout)*(1+((k/kappa)*(J0_krout/Y0_kapparout)*Y1_kapparout-J1_krout)/(J1_krout+J0_krout*(Y1_krout/Y0_krout)));

%A58 = (J0_kapparout*J1_krout-(k/kappa)*J0_krout*J1_kapparout)/(Y0_krout*J1_krout+Y1_krout*J0_krout);
%A68 = (Y0_kapparout*J1_krout-(k/kappa)*J0_krout*Y1_kapparout)/(Y0_krout*J1_krout+Y1_krout*J0_krout);



A57 = (J0_kapparout/J0_krout)-(Y0_krout/J0_krout)*((k/kappa)*J1_kapparout*J0_krout-J0_kapparout*J1_krout)/(Y1_krout*J0_krout-Y0_krout*J1_krout);
A67 = (Y0_kapparout/J0_krout)-(Y0_krout/J0_krout)*((k/kappa)*Y1_kapparout*J0_krout-Y0_kapparout*J1_krout)/(Y1_krout*J0_krout-Y0_krout*J1_krout);

A58 = ((k/kappa)*J1_kapparout*J0_krout-J0_kapparout*J1_krout)/(Y1_krout*J0_krout-Y0_krout*J1_krout);
A68 = ((k/kappa)*Y1_kapparout*J0_krout-Y0_kapparout*J1_krout)/(Y1_krout*J0_krout-Y0_krout*J1_krout);


%A79 = J0_kR/(J0_kR+i*Y0_kR);
%A89 = Y0_kR/(J0_kR+i*Y0_kR);
%BI09 = -(mu0*N/Lp)/(J0_kR+i*Y0_kR);

%A59 = A57*((J1_kR/(J1_kR+i*Y1_kR))-A79)+A58*((Y1_kR/(J1_kR+i*Y1_kR))-A89);
%A69 = A67*((J1_kR/(J1_kR+i*Y1_kR))-A79)+A68*((Y1_kR/(J1_kR+i*Y1_kR))-A89);

A79 = J1_kR/(J1_kR+i*Y1_kR);
A89 = Y1_kR/(J1_kR+i*Y1_kR);

A5 = A57*(J0_kR-A79*(J0_kR+i*Y0_kR))+A58*(Y0_kR-A89*(J0_kR+i*Y0_kR));
A6 = A67*(J0_kR-A79*(J0_kR+i*Y0_kR))+A68*(Y0_kR-A89*(J0_kR+i*Y0_kR));


% C constants
%c1 = I0*BI09/(A15*A59+A16*A69);
c1 = I0*(mu0*N/Lp)/(A15*A5+A16*A6); % Bug: A15, A5, A16, A6  Sometimes cancel?
c2 = 0;
c5 = c1*A15;
c6 = c1*A16;
c7 = c5*A57+c6*A67;
c8 = c5*A58+c6*A68;
%c9 = c7*A79+c8*A89+I0*BI09;
c9 = c7*A79+c8*A89;
c10 = i*c9;


% Electromagnetic fields
% in the middle area
B0 = c1*besselj(0,k*s0);
E0 = i*c*c1*besselj(1,k*s0);

% inside the conductive ring
B1 = c5*besselj(0,kappa*s1)+c6*bessely(0,kappa*s1);
E1 = (i*w/kappa)*(c5*besselj(1,kappa*s1)+c6*bessely(1,kappa*s1));

% outside the conductive ring
B2 = c7*besselj(0,k*s2) + c8*bessely(0,k*s2);
E2 = i*c*(c7*besselj(1,k*s2)+c8*bessely(1,k*s2));

% outside the solenoid
B3 = c9*besselj(0,k*s3)+c10*bessely(0,k*s3);
E3 = i*c*(c9*besselj(1,k*s3)+c10*bessely(1,k*s3));

% Total fields
B = [B0,B1,B2,B3];
E = [E0,E1,E2,E3];

% Real and imaginary parts
Breal = real(B);
Bimag = imag(B);
Ereal = real(E);
Eimag = imag(E);

% field amplitudes
Bamp = abs(B);
Eamp = abs(E);

%Electromagnetic field matrix
Bmatrix = [s;Breal;Bimag;Bamp;Ereal;Eimag;Eamp];

% Calculate the important values

x1=s1*kappa; %nondimensional distance variable for inside the metal

% experimental: Find primary voltage by integrating electric field around a circle
vac_primary = 2*pi*N*R.*E3(1);
reflect_resistance = abs(real(vac_primary)./I0);
inductance = abs(imag(vac_primary)./(I0.*w));
% Ohm's law
currentdensity = E1*sigma;
currentdensity_real = real(currentdensity);
currentdensity_imag = imag(currentdensity);
% integrate current density over the area
current_real = trapz(s1,s1.*Ls.*currentdensity_real);
current_imag = trapz(s1,s1.*Ls.*currentdensity_imag);
% RMS: Divide by sqrt 2
current = sqrt(0.5*(current_real^2 + current_imag^2));
% Power: Integrate J^2
I2R = trapz(s1,pi*s1.*Ls.*(abs(currentdensity).*abs(E1)));
%Resistance: Divide power by current squared
if(current ~= 0)
resistance = I2R/(current^2);
else
resistance = inf;
endif


%Next: What are the loading effects on the primary?

%reflect_resistance = 2*I2R/(I0^2);
%flux = 2*pi*Lp*trapz(s,s.*Bamp);
%magenergy = pi*Lp*(1/mu0)*trapz(s,s.*Bamp.*Bamp);
%inductance = 2*magenergy/(I0^2);
%vac_primary = I0*(reflect_resistance+i*w*inductance); %alternate way of finding vac_primary; should give the same result

return

%verbose
J0_krin
J0_kapparin
Y0_krin
Y0_kapparin

J1_krin
J1_kapparin
Y1_krin
Y1_kapparin

% at rout
J0_krout
J0_kapparout
Y0_krout
Y0_kapparout

J1_krout 
J1_kapparout 
Y1_krout
Y1_kapparout

% at R

J0_kR
Y0_kR
J1_kR
Y1_kR
c1
Lp
A15
A5
A16
A6
A15*A5
A16*A6
A57
A79
A58
A89
A67
A79
A68
A89

A15/A16
kappa
k
kappa/k

t
freq
sigma
rin
rout


"----------"


endfunction