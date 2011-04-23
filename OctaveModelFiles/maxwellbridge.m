%function maxwellbridge(Vs,reflect_resistance,inductance,T,freqrange,freqnumber)
%function maxwellbridge(Vs,reflect_resistance,inductance,T,freqrange,freqnumber)
%"resistance" should be reflected resistance (reflect_resistance), not ring resistance (resistance).

Vs=2.5;

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




%Arbitrary: C2, R3
numpoints = 100
%C2 = logspace(-12,-1,numpoints)(4);
C2 = 1e-6;
R3 = logspace(log(R00),log(R00)+2,numpoints);

%Balanced bridge:
R2 = L00./(R00.*C2);
R1 = R00.*R2./R3;

R4 = reflect_resistance(freqnumber,:);
L4 = inductance(freqnumber,:);

Z1 = R1;
Z2 = 1./(i*w0.*C2+1./R2);
Z3 = R3;
Z4 =R4.+ i*w0.*L4;

ZA = Z1+Z2;
ZB = repmat(Z3,numtemps,1).'+repmat(Z4,length(Z3),1);

IB=Vs./ZB;
IA = Vs./ZA;

%Bridge Voltages
Va = IA.*Z1;
Vb = IB.*repmat(Z4,length(Z3),1);
Vab = repmat(Va,numtemps,1).'.-Vb;

%next: more graphs...

figure();
title(strcat("Bridge voltage magnitude vs temperature (freq = ",num2str(freqrange(freqnumber)),")"));
xlabel("Temperature (degrees C)")
ylabel("Bridge voltage Vab (V)")


	%Prepare the data
	vab_realplot = real(Vab);
	vab_implot = imag(Vab);
	vab_phaseplot = -unwrap(angle(Vab)-pi/2);
	vab_magplot = sign(vab_phaseplot).*abs(Vab);
%	vab_magplot =abs(Vab(freqnumber,:));


	
axis_xmin = min(T);
axis_xmax = max(T);
axis_ymin = min(min(vab_magplot));
axis_ymax = max(max(vab_magplot));
%axis_ymax = max([max(max(vab_magplot)),max(max(vab_realplot)),max(max(vab_implot))]);
axis([axis_xmin,axis_xmax,axis_ymin,axis_ymax]);


legend_xmin = 0.05*axis_xmax;
legend_xmax = 0.1*axis_xmax;
legend_x=[legend_xmin,legend_xmax];
legend_ymin = 0.5*axis_ymax;
legend_ymax = 0.9*axis_ymax;
legend_y = linspace(legend_ymin,legend_ymax,numpoints);
legend_y = [legend_y;legend_y];


%versus temperature
hold on;
for index1 = 1:numpoints
	%Pick a colour
%	colour_real = [index1/numpoints, 0, 0.5];
%	colour_imag = [0.5, 0.9, index1/numpoints];
	colour_mag= [index1/numpoints,0.5,1-index1/numpoints];
	

%calculate sensitivity
	vab_sensitivity(index1) = (vab_magplot(index1,length(T))-vab_magplot(index1,1))/(T(length(T))-T(1));

	% plot the graphs
	plot(T,vab_magplot(index1,:),"linewidth",2,"color",colour_mag)
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

maxsensindex = find(abs(vab_sensitivity)==max(abs(vab_sensitivity)));
maxsensR3 = R3(maxsensindex)
maxsensitivity = vab_sensitivity(maxsensindex)

if(maxsensindex < 2)
	disp("Range too small: Maximum is lowest tested value");
elseif(maxsensindex > length(vab_sensitivity)-2)
	disp("Range too small: Maximum is highest tested value");
endif

figure();
title(strcat("Bridge voltage magnitude vs temperature at max sensitivity (freq = ",num2str(freqrange(freqnumber))," Hz)"));
xlabel("Temperature (degrees C)")
ylabel("Bridge voltage Vab (V)")
axis([axis_xmin,axis_xmax,axis_ymin,axis_ymax]);
hold on;
plot(T,vab_magplot(maxsensindex,:),"linewidth",2,"color",[0,0,0]);
hold off;