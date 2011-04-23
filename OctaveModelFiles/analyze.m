% analyze.m
% UBC Rapid Induction Heater Project File
% This is the file that is called to start the computational analysis of the electromagnetic system
% To run, move to the directory containing this file and type "analyze" in the Octave command line
% 
% Parameters to control the simulation are most easily set in this file
% Note: This is not a function, so variables are directly in the workspace. This makes debugging more convenient. But it might overwrite any variables already present in the workspace with the same names.
% 
% 
% v 1.0.10
% Jacob Bayless, February 2011
% UBC Rapid Team, RepRap Project
% Licensed for use under the GPL (Gnu Public License)




%debug_on_warning(1); %Uncomment for debugging purposes




%----------------------------------%
% SIMULATION PARAMETERS %
%----------------------------------%
%
% Adjust these values to test different combinations in the simulation
rin = 1/1000; 	%inner radius of metal ring used to be 1.5
rout = 1.5/1000; 	%outer radius of sample
R = 3/1000; 		%outer radius of glass
Ls = 1/1000; 	%length of ring
Lp = 10/1000; 	%length of primary coil
numfreqs = 100; 	%frequency resolution of simulation
numtemps = 240;	%temperature resolution of simulation
T_room = 20;	%minimum temperature to simulate (Celsius)
T_melt = 260;	%maximum temperature to simulate (Celsius)
freqexp_min = 4;	%minimum frequency to simulate is 10^4 Hz
freqexp_max = 6;	%maximum frequency to simulate is 10^6 Hz. *Note* Model can become numerically unstable at higher frequencies. (When this happens, it will be obvious). Recommend 64-bit calculations in the future.
I0=0.5; 		%Peak current amplitude flowing in the primary coil (amps). I(t) = I0*sin(2*pi*freq*t)
N=30;			%Number of windings of primary coil
%
%----------------------------------%


% Generate the frequency and temperature variables
freqrange = logspace(freqexp_min,freqexp_max,numfreqs);
T = linspace(T_room,T_melt,numtemps);
%freqrange = logspace(3,5.5,numfreqs); %frequency range

sigmarange = RTD_calctemp(T); %Uses copper by default
%figure(1);
%title("Sigmas versus temperatures");
%plot(T,sigmarange);
numxvals = 100;
totxvals = numxvals*4;
%primary current and windings



% Define the returned data
%Two-dimensional matrices: (freq1;freq2, temp1,temp2)
resistance = zeros(numfreqs,numtemps);
current = zeros(numfreqs,numtemps);
I2R = zeros(numfreqs,numtemps);

%Three-dimensional matrices: (freq1;freq2, temp1;temp2, s1;s2)
E =zeros (numfreqs, numtemps, totxvals);
B =zeros(numfreqs, numtemps, totxvals);
s=zeros (numfreqs, numtemps, totxvals);




for index1 = 1:numfreqs
	for index2 = 1:numtemps
		freq = freqrange(index1);
		sigma = sigmarange(index2);
		[reflect_resistance(index1,index2),resistance(index1,index2),current(index1,index2),I2R(index1,index2),inductance(index1,index2),vac_primary(index1,index2),s(index1,index2,:),E(index1,index2,:),B(index1,index2,:)] = maxwell(I0,N,Lp,Ls,rin,rout,R,freq,sigma,numxvals);
	 endfor

endfor

%determine temperature sensitivity (endpoints method)
Tsensitivity = zeros(1, numfreqs);
Tsens_rel = zeros(1, numfreqs);
for index1 = 1:numfreqs
	Tsensitivity(index1) = abs((vac_primary(index1,numtemps)-vac_primary(index1,1))/(T(numtemps)-T(1)));
	Tsens_rel(index1) =  abs((vac_primary(index1,numtemps)-vac_primary(index1,1))/(max(vac_primary(index1,floor(0.5*numtemps)))*(T(numtemps)-T(1))));
endfor
%max(Tsensitivity)

freqnumber = find((Tsens_rel == max(Tsens_rel)));
if(length(freqnumber)>1) %error condition
	freqnumber=floor(mean(max(freqnumber),min(freqnumber)));
	disp("temperature sensitivity detection error: multiple peak frequencies");
endif
maxsensfreq = freqrange(freqnumber)

%plot the results
%E&M curves
Ereal = real(E);
Eimag = imag(E);
Emag = abs(E);
Breal = real(B);
Bimag = imag(B);
Bmag = abs(B);
Emax = max(max(max(Emag)))
Bmax = max(max(max(Bmag)))
Escale = Emag./Emax;
Bscale = Bmag./Bmax;
smin = min(min(min(s)));
smax = max(max(max(s)));


%return %uncomment to return without plotting


%plot the electric and magnetic field distributions
%plotEBvsfreqs
%plotEBvstemps

%plot the results versus frequency and temperature
%plotpower
%plotcurrent
%plotresistance
%plotreflect_resistance
%plotinductance
%plotvacprimary
%plotTsensitivity

parasiticresistance
maxwellbridge