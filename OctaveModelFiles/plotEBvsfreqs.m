


figure();
title("Electric field magnitude plot vs frequency (T=20 C)");
xlabel("Radius (mm)")
ylabel("Electric field (V/m)")

axis_xmin = smin*1000;
axis_xmax = smax*1000;
axis_ymin = 0;
axis_ymax = max(max(max((Emag))));
axis([axis_xmin,axis_xmax,axis_ymin,axis_ymax]);


legend_xmin = 0.05*axis_xmax;
legend_xmax = 0.1*axis_xmax;
legend_x=[legend_xmin,legend_xmax];
legend_ymin = 0.5*axis_ymax;
legend_ymax = 0.9*axis_ymax;
legend_y = linspace(legend_ymin,legend_ymax,numfreqs);
legend_y = [legend_y;legend_y];

splot = 1000*ndshrink(s,"1,1,:");

hold on;
for index1 = 1:numfreqs
	%Pick a colour
%	colour_real = [0, 0, (index1/numfreqs)];
%	colour_imag = [0, 0.5, (index1/numfreqs)];
	colour_mag = [0, 1, (index1/numfreqs)];
	
	%Prepare the data
%	Eplot_real = ndshrink(Ereal,strcat(num2str(index1),",1,:"));
%	Eplot_imag = ndshrink(Eimag,strcat(num2str(index1),",1,:"));
	Eplot_mag = ndshrink(Emag,strcat(num2str(index1),",1,:"));


	% plot the graphs
%	plot(splot,Eplot_real,"linewidth",1,"color",colour_real)
%	plot(splot,Eplot_imag,"linewidth",1,"color",colour_imag)
	plot(splot,Eplot_mag,"linewidth",2,"color",colour_mag)
	
	% legend
	plot(legend_x,legend_y(:,index1),"linewidth",4,"color",colour_mag);
 endfor
 %legend
 text(legend_xmin*0.95,1.04*legend_ymax,"Frequency (Hz)");
 text(legend_xmax,legend_ymin,num2str(min(freqrange)));
 text(legend_xmax,legend_ymax,num2str(max(freqrange)));
 %mark metal ring
 plot([splot(numxvals);splot(numxvals)],[axis_ymin;axis_ymax],"linewidth",1,"color",[1,0.6,0]);
  plot([splot(2*numxvals);splot(2*numxvals)],[axis_ymin;axis_ymax],"linewidth",1,"color",[1,0.6,0]);
hold off;



figure();
title("Magnetic field magnitude plot vs frequency");
xlabel("Radius (mm)")
ylabel("Magnetic field (Tesla)")

axis_xmin = smin*1000;
axis_xmax = smax*1000;
axis_ymin = 0;
axis_ymax = max(max(max((Bmag))));
axis([axis_xmin,axis_xmax,axis_ymin,axis_ymax]);


legend_xmin = 0.8*axis_xmax;
legend_xmax = 0.85*axis_xmax;
legend_x=[legend_xmin,legend_xmax];
legend_ymin = 0.5*axis_ymax;
legend_ymax = 0.9*axis_ymax;
legend_y = linspace(legend_ymin,legend_ymax,numfreqs);
legend_y = [legend_y;legend_y];

hold on;
for index1 = 1:numfreqs
	%Pick a colour
%	colour_real = [0, 0, (index1/numfreqs)];
%	colour_imag = [0, 0.5, (index1/numfreqs)];
	colour_mag = [0, 1, (index1/numfreqs)];
	
	%Prepare the data
%	Bplot_real = ndshrink(Breal,strcat(num2str(index1),",1,:"));
%	Bplot_imag = ndshrink(Bimag,strcat(num2str(index1),",1,:"));
	Bplot_mag = ndshrink(Bmag,strcat(num2str(index1),",1,:"));


	% plot the graphs
%	plot(splot,Bplot_real,"linewidth",1,"color",colour_real)
%	plot(splot,Bplot_imag,"linewidth",1,"color",colour_imag)
	plot(splot,Bplot_mag,"linewidth",2,"color",colour_mag)
	
	% legend
	plot(legend_x,legend_y(:,index1),"linewidth",4,"color",colour_mag);
 endfor
 %legend
 text(legend_xmin*0.95,1.04*legend_ymax,"Frequency (Hz)");
 text(legend_xmax,legend_ymin,num2str(min(freqrange)));
 text(legend_xmax,legend_ymax,num2str(max(freqrange)));
  %mark metal ring
 plot([splot(numxvals);splot(numxvals)],[axis_ymin;axis_ymax],"linewidth",1,"color",[1,0.6,0]);
  plot([splot(2*numxvals);splot(2*numxvals)],[axis_ymin;axis_ymax],"linewidth",1,"color",[1,0.6,0]);
hold off;