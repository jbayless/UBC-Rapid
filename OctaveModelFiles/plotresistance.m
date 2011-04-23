%resistance
figure();
title("Resistance versus frequency and temperature");
ylabel("Heater resistance (Ohms)");
xlabel("Frequency (Hz)");

axis_xmin = min(freqrange);
axis_xmax = max(freqrange);
axis_ymin = 0;
axis_ymax = max(max(resistance));
axis([axis_xmin,axis_xmax,axis_ymin,axis_ymax]);


legend_xmin = axis_xmin*1.1;
legend_xmax = axis_xmin*1.6;
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
	resistanceplot = resistance(:,index1);

	% plot the graphs
	semilogx(freqrange,resistanceplot,"linewidth",2,"color",colour_mag)
	
	% legend
	semilogx(legend_x,legend_y(:,index1),"linewidth",4,"color",colour_mag);
 endfor
 %legend
 text(legend_xmin,1.04*legend_ymax,"Temperature (C)");
 text(legend_xmax,legend_ymin,num2str(min(T)));
 text(legend_xmax,legend_ymax,num2str(max(T)));
 
hold off;
