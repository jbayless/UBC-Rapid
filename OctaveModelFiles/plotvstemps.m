
freqnumber = 4

figure();
title(strcat("Electric field magnitude plot vs temperature (freq = ",num2str(freqrange(freqnumber)),")"));
xlabel("Radius (mm)")
ylabel("Electric field (V/m)")

axis_xmin = smin*1000;
axis_xmax = smax*1000;
axis_ymin = 0;
axis_ymax = max(max(Emag(freqnumber,:,:)));
axis([axis_xmin,axis_xmax,axis_ymin,axis_ymax]);


legend_xmin = 0.05*axis_xmax;
legend_xmax = 0.1*axis_xmax;
legend_x=[legend_xmin,legend_xmax];
legend_ymin = 0.5*axis_ymax;
legend_ymax = 0.9*axis_ymax;
legend_y = linspace(legend_ymin,legend_ymax,numtemps);
legend_y = [legend_y;legend_y];

splot = 1000*ndshrink(s,"1,1,:");

hold on;
for index1 = 1:numtemps
	%Pick a colour
%	colour_real = [ (index1/numtemps), 0, 0.5];
%	colour_imag = [ (index1/numtemps), 0.5, 0];
	colour_mag = [ (index1/numtemps), 0, 0];
	
	%Prepare the data
%	Eplot_real = ndshrink(Ereal,strcat(num2str(freqnumber),",",num2str(index1),",:"));
%	Eplot_imag = ndshrink(Eimag,strcat(num2str(freqnumber),",",num2str(index1),",:"));
	Eplot_mag = ndshrink(Emag,strcat(num2str(freqnumber),",",num2str(index1),",:"));


	% plot the graphs
%	plot(splot,Eplot_real,"linewidth",1,"color",colour_real)
%	plot(splot,Eplot_imag,"linewidth",1,"color",colour_imag)
	plot(splot,Eplot_mag,"linewidth",2,"color",colour_mag)
	
	% legend
	plot(legend_x,legend_y(:,index1),"linewidth",4,"color",colour_mag);
 endfor
 %legend
 text(legend_xmin*0.95,1.04*legend_ymax,"Temperature (C)");
 text(legend_xmax,legend_ymin,num2str(min(T)));
 text(legend_xmax,legend_ymax,num2str(max(T)));
 
hold off;



figure();
title(strcat("Magnetic field magnitude plot vs temperature (freq = ",num2str(freqrange(freqnumber)),")"));
xlabel("Radius (mm)")
ylabel("Magnetic field (Tesla)")

axis_xmin = smin*1000;
axis_xmax = smax*1000;
axis_ymin = 0;
axis_ymax = max(max(Bmag(freqnumber,:,:)));
axis([axis_xmin,axis_xmax,axis_ymin,axis_ymax]);


legend_xmin = 0.8*axis_xmax;
legend_xmax = 0.85*axis_xmax;
legend_x=[legend_xmin,legend_xmax];
legend_ymin = 0.5*axis_ymax;
legend_ymax = 0.9*axis_ymax;
legend_y = linspace(legend_ymin,legend_ymax,numtemps);
legend_y = [legend_y;legend_y];

hold on;
for index1 = 1:numtemps
	%Pick a colour
%	colour_real = [ (index1/numtemps), 0, 0.5];
%	colour_imag = [ (index1/numtemps), 0.5, 0];
	colour_mag = [ (index1/numtemps), 0, 0];
	
	%Prepare the data
%	Bplot_real = ndshrink(Breal,strcat(num2str(freqnumber),",",num2str(index1),",:"));
%	Bplot_imag = ndshrink(Bimag,strcat(num2str(freqnumber),",",num2str(index1),",:"));
	Bplot_mag = ndshrink(Bmag,strcat(num2str(freqnumber),",",num2str(index1),",:"));


	% plot the graphs
%	plot(splot,Bplot_real,"linewidth",1,"color",colour_real)
%	plot(splot,Bplot_imag,"linewidth",1,"color",colour_imag)
	plot(splot,Bplot_mag,"linewidth",2,"color",colour_mag)
	
	% legend
	plot(legend_x,legend_y(:,index1),"linewidth",4,"color",colour_mag);
 endfor
 %legend
 text(legend_xmin*0.95,1.04*legend_ymax,"Temperature (C)");
 text(legend_xmax,legend_ymin,num2str(min(T)));
 text(legend_xmax,legend_ymax,num2str(max(T)));
 
hold off;