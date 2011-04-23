%function circuitanalyze(I0,reflect_resistance,inductance,T,freqrange,freqnumber)
%function circuitanalyze(Vs,reflect_resistance,inductance,T,freqrange,freqnumber)
% UBC Rapid Induction Heater Project File
%"resistance" should be reflected resistance (reflect_resistance), not ring resistance (resistance).
%
%
%
% v 1.0.1
% Jacob Bayless, February 2011
% UBC Rapid Team, RepRap Project
% Licensed for use under the GPL (Gnu Public License)

maxsensfreq=freqrange(freqnumber);
numfreqs=length(freqrange);
numtemps = length(T);
w = 2*pi*freqrange;
w0 = 2*pi*maxsensfreq;
wm = repmat(w,numtemps,1)';

%resistance(freq,temp)
%inductance(freq,temp)

%temperature reference
T0_index = floor(0.5*numtemps);
T0 = T(T0_index)

%calculate betas
[R0, L0, betaR, betaL]=calculatebetas(T,T0,reflect_resistance,inductance);
%use values only from the sensing frequency
R00 = R0(freqnumber)
L00 = L0(freqnumber)
betaR0 = betaR(freqnumber)
betaL0 = betaL(freqnumber)




%Capacitance ratio
c2oc1 = [0.1,0.5,1,2,10];
R3 = R0(freqnumber)./c2oc1;



%Solve capacitance and other variables
a4 = -2*betaR0*(R3.^2)/(((w0*L00).^2).*betaL0);
a3 = -4*(R3.^2)./((w0.*L00).^2);
a0 = -8*betaR0*(R3.^4)/(((w0*L00).^4).*betaL0);


%C2sols = roots([1,0,0,a4,a3,0,0,a0])
%C2 = min(C2sols(find(C2sols==real(C2sols))))
C2 = 1e-8;

C1 = C2./c2oc1
R1 = L00./(C2*R3)
R4 = reflect_resistance(freqnumber,:);
L4 = inductance(freqnumber,:);

Z1 = R1+1./(i*w0*C1);
Z2 = 1./(i*w0*C2);
Z3 = R3;
Z4 =R4.+ i*w0.*L4;

ZA = Z1+Z2;
ZB = repmat(Z3,numtemps,1).'+repmat(Z4,length(c2oc1),1);

Vs=5;
I0=Vs./ZB;
%Vs = I0*ZB;
IA = Vs./ZA;
IB = Vs./ZB;

%for a balanced bridge at T0:
Va = IA.*Z1;
Vb = I0.*repmat(Z4,length(c2oc1),1);
Vab = repmat(Va,numtemps,1).'-Vb;

%next: more graphs...

figure();
title(strcat("Bridge real voltage vs temperature (freq = ",num2str(freqrange(freqnumber)),")"));
xlabel("Temperature (degrees C)")
ylabel("Bridge voltage Vab (V)")


	%Prepare the data
	vab_realplot = real(Vab);
	vab_implot = imag(Vab);
	vab_phaseplot = -unwrap(angle(Vab));
	vab_magplot = sign(vab_phaseplot).*abs(Vab);
%	vab_magplot =abs(Vab(freqnumber,:));


	
axis_xmin = min(T);
axis_xmax = max(T);
axis_ymin = min(min(vab_realplot));
axis_ymax = max(max(vab_realplot));
%axis_ymax = max([max(max(vab_magplot)),max(max(vab_realplot)),max(max(vab_implot))]);
axis([axis_xmin,axis_xmax,axis_ymin,axis_ymax]);


legend_xmin = 0.05*axis_xmax;
legend_xmax = 0.1*axis_xmax;
legend_x=[legend_xmin,legend_xmax];
legend_ymin = 0.5*axis_ymax;
legend_ymax = 0.9*axis_ymax;
legend_y = linspace(legend_ymin,legend_ymax,length(c2oc1));
legend_y = [legend_y;legend_y];


%versus temperature
hold on;
for index1 = 1:length(c2oc1)
	%Pick a colour
%	colour_real = [(index1/numfreqs), 0, 0.5];
%	colour_imag = [(index1/numfreqs), 0.5, 0];
%	colour_mag = [(index1/numtemps), 0, 0];
	colour_real = [index1/length(c2oc1), 0, 0.5];
	colour_imag = [0.5, 0.9, index1/length(c2oc1)];
	colour_mag= [index1/length(c2oc1),0,0];
	

%calculate sensitivity
	vab_sensitivity = (vab_magplot(index1,length(T))-vab_magplot(index1,1))/(T(length(T))-T(1))

	% plot the graphs
	plot(T,vab_realplot(index1,:),"linewidth",2,"color",colour_real)
%	plot(T,vab_implot(index1,:),"linewidth",1,"color",colour_imag)
%	plot(T,0.001*vab_phaseplot,"linewidth",2)
%	plot(T,vab_magplot(index1,:),"linewidth",2,"color",colour_mag)
	
	% legend
	plot(legend_x,legend_y(:,index1),"linewidth",4,"color",colour_mag);
endfor
%legend
% text(legend_xmin*0.95,1.04*legend_ymax,"Temperature (C)");
% text(legend_xmax,legend_ymin,num2str(min(T)));
% text(legend_xmax,legend_ymax,num2str(max(T)));
 
hold off;

figure();
title(strcat("Bridge imaginary voltage vs temperature (freq = ",num2str(freqrange(freqnumber)),")"));
xlabel("Temperature (degrees C)")
ylabel("Bridge voltage Vab (V)")


	
axis_xmin = min(T);
axis_xmax = max(T);
axis_ymin = min(min(vab_implot));
axis_ymax = max(max(vab_implot));
%axis_ymax = max([max(max(vab_magplot)),max(max(vab_realplot)),max(max(vab_implot))]);
axis([axis_xmin,axis_xmax,axis_ymin,axis_ymax]);


legend_xmin = 0.05*axis_xmax;
legend_xmax = 0.1*axis_xmax;
legend_x=[legend_xmin,legend_xmax];
legend_ymin = 0.5*axis_ymax;
legend_ymax = 0.9*axis_ymax;
legend_y = linspace(legend_ymin,legend_ymax,length(c2oc1));
legend_y = [legend_y;legend_y];


%versus temperature
hold on;
for index1 = 1:length(c2oc1)
	%Pick a colour
%	colour_real = [(index1/numfreqs), 0, 0.5];
%	colour_imag = [(index1/numfreqs), 0.5, 0];
%	colour_mag = [(index1/numtemps), 0, 0];
	colour_real = [index1/length(c2oc1), 0, 0.5];
	colour_imag = [0.5, 0.9, index1/length(c2oc1)];
	colour_mag= [index1/length(c2oc1),0,0];
	

%calculate sensitivity
	vab_sensitivity = (vab_magplot(index1,length(T))-vab_magplot(index1,1))/(T(length(T))-T(1))

	% plot the graphs
%	plot(T,vab_realplot(index1,:),"linewidth",2,"color",colour_real)
	plot(T,vab_implot(index1,:),"linewidth",2,"color",colour_imag)
%	plot(T,0.001*vab_phaseplot,"linewidth",2)
%	plot(T,vab_magplot(index1,:),"linewidth",2,"color",colour_mag)
	
	% legend
	plot(legend_x,legend_y(:,index1),"linewidth",4,"color",colour_mag);
endfor
%legend
% text(legend_xmin*0.95,1.04*legend_ymax,"Temperature (C)");
% text(legend_xmax,legend_ymin,num2str(min(T)));
% text(legend_xmax,legend_ymax,num2str(max(T)));
 
hold off;
