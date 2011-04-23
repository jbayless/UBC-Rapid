figure();
title(strcat("Absolute sensitivity of reflected voltage to temperature"));
xlabel("Frequency (Hz)")
ylabel("Sensitivity (V/degree C)")

axis_xmin = min(freqrange);
axis_xmax = max(freqrange);
axis_ymin = min(Tsensitivity);
axis_ymax = max(Tsensitivity);
axis([axis_xmin,axis_xmax,axis_ymin,axis_ymax]);


%legend_xmin = 0.05*axis_xmax;
%legend_xmax = 0.1*axis_xmax;
%legend_x=[legend_xmin,legend_xmax];
%legend_ymin = 0.5*axis_ymax;
%legend_ymax = 0.9*axis_ymax;
%legend_y = linspace(legend_ymin,legend_ymax,numtemps);
%legend_y = [legend_y;legend_y];


hold on;
%for index1 = 1:numtemps
	%Pick a colour
	colour_mag = [ 0, 0, 0];
	
	% plot the graphs
	semilogx(freqrange,Tsensitivity,"linewidth",2,"color",colour_mag)
	
	% legend
%	plot(legend_x,legend_y(:,index1),"linewidth",4,"color",colour_mag);
% endfor
 %legend
% text(legend_xmin*0.95,1.04*legend_ymax,"Temperature (C)");
% text(legend_xmax,legend_ymin,num2str(min(T)));
% text(legend_xmax,legend_ymax,num2str(max(T)));
 
hold off;

figure();
title(strcat("Relative sensitivity of reflected voltage to temperature"));
xlabel("Frequency (Hz)")
ylabel("Sensitivity (per degree C)")

axis_xmin = min(freqrange);
axis_xmax = max(freqrange);
axis_ymin = min(Tsens_rel);
axis_ymax = max(Tsens_rel);
axis([axis_xmin,axis_xmax,axis_ymin,axis_ymax]);


%legend_xmin = 0.05*axis_xmax;
%legend_xmax = 0.1*axis_xmax;
%legend_x=[legend_xmin,legend_xmax];
%legend_ymin = 0.5*axis_ymax;
%legend_ymax = 0.9*axis_ymax;
%legend_y = linspace(legend_ymin,legend_ymax,numtemps);
%legend_y = [legend_y;legend_y];


hold on;
%for index1 = 1:numtemps
	%Pick a colour
	colour_mag = [ 0, 0, 0];
	
	% plot the graphs
	semilogx(freqrange,Tsens_rel,"linewidth",2,"color",colour_mag)
	semilogx(maxsensfreq,Tsens_rel(freqnumber),"o","color",[0,1,0])
	% legend
%	plot(legend_x,legend_y(:,index1),"linewidth",4,"color",colour_mag);
% endfor
 %legend
% text(legend_xmin*0.95,1.04*legend_ymax,"Temperature (C)");
% text(legend_xmax,legend_ymin,num2str(min(T)));
% text(legend_xmax,legend_ymax,num2str(max(T)));
 
hold off;