% Construction geometry (mm/1000 = m)
rin = 1.5/1000;
t = 0.5/1000;
rout = rin + t;
R = 3/1000;
Lp = 10/1000;
Ls = 10/1000;

din = 2*rin;
dout = 2*rout;
D = 2*R;

% radius variable s
s0 = linspace(0,rin,100);
s1 = linspace(rin,rout,100);
s2 = linspace(rout,R,100);
s3 = linspace(R,2*R,100);
s = [s0,s1,s2,s3];
sscale=s/rout;

% Driving frequency
freq = 5*10^5;
%freq = 1;
%freq = 10^3;
w = 2*pi*freq;

% Driving current (amps) and windings
I0 = 1;
N = 30;

% Physical constants
mu0 = 1.25663706e-6;
eps0 = 8.85418782e-12;
c = 299792458;
k = w/c;

% Metal properties: Copper
%sigma = 1;
sigma = 5.69e7;
mur = 1;
mu = mur*mu0;
epsr = 1;
eps = epsr*eps0;
kappa = sqrt(i*w*mu*sigma + mu*eps*w^2);

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

A15 = (J0_krin/J0_kapparin)-(Y0_kapparin/J0_kapparin)*((kappa/k)*J0_kapparin*J1_krin-J0_krin*J1_kapparin)/(Y1_kapparin*J0_kapparin-Y0_kapparin*J1_kapparin);
A16 = ((kappa/k)*J0_kapparin*J1_krin-J0_krin*J1_kapparin)/(Y1_kapparin*J0_kapparin-Y0_kapparin*J1_kapparin);

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
c1 = I0*(mu0*N/Lp)/(A15*A5+A16*A6);
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


%% Boundary Condition Tests
%% at rin:
Brin1 = c1*besselj(0,k*rin);
Brin2 =  c5*besselj(0,kappa*rin)+c6*bessely(0,kappa*rin);
Erin1 = i*c*c1*besselj(1,k*rin);
Erin2 =  (i*w/kappa)*(c5*besselj(1,kappa*rin)+c6*bessely(1,kappa*rin));

Brin1
Brin2
Erin1
Erin2


%% at rout:
Brout1 = c5*besselj(0,kappa*rout)+c6*bessely(0,kappa*rout);
Brout2 = c7*besselj(0,k*rout) + c8*bessely(0,k*rout);
Erout1 =  (i*w/kappa)*(c5*besselj(1,kappa*rout)+c6*bessely(1,kappa*rout));
Erout2 = i*c*(c7*besselj(1,k*rout)+c8*bessely(1,k*rout));

Brout1
Brout2
Erout1
Erout2

%% at R:
BR1 =  c7*besselj(0,k*R) + c8*bessely(0,k*R);
BR1plus = BR1 - mu0*I0*N/Lp;
BR2 = c9*besselj(0,k*R)+c10*bessely(0,k*R);
ER1 =  i*c*(c7*besselj(1,k*R)+c8*bessely(1,k*R));
ER2 =  i*c*(c9*besselj(1,k*R)+c10*bessely(1,k*R));

BR1
BR1plus
BR2
ER1
ER2

%%% Track down algebra mistakes:
c7*J1_krout+c8*Y1_krout
(k/kappa)*(c5*J1_kapparout+c6*Y1_kapparout)
% Error is in c7 and/or c8

