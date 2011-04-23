%vac_primary
figure();
title("Primary alternating voltage versus frequency and temperature");
ylabel("Primary voltage (V)");
xlabel("Frequency (Hz)");

axis_xmin = min(freqrange);
axis_xmax = max(freqrange);
axis_ymin = 0;
axis_ymax = max(max(abs(vac_primary)));
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
	colour_mag = [ (index1/numtemps), 0, 0];
	
	%Prepare the data
	vac_primaryplot = abs(vac_primary(:,index1));

	% plot the graphs
	semilogx(freqrange,vac_primaryplot,"linewidth",1,"color",colour_mag)
	
	% legend
	semilogx(legend_x,legend_y(:,index1),"linewidth",4,"color",colour_mag);
 endfor
 %legend
 text(legend_xmin,1.04*legend_ymax,"Temperature (C)");
 text(legend_xmax,legend_ymin,num2str(min(T)));
 text(legend_xmax,legend_ymax,num2str(max(T)));
 
hold off;





figure();
title(strcat("Reflected primary alternating voltage vs temperature (freq = ",num2str(freqrange(freqnumber)),")"));
xlabel("Temperature (degrees C)")
ylabel("Primary Voltage (V)")

axis_xmin = min(T);
axis_xmax = max(T);
axis_ymin = min(abs(vac_primary(freqnumber,:)));
axis_ymax = max(abs(vac_primary(freqnumber,:)));
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
	
	%Prepare the data
	vac_tplot = abs(vac_primary(freqnumber,:));

	% plot the graphs
	plot(T,vac_tplot,"linewidth",2,"color",colour_mag)
	
	% legend
%	plot(legend_x,legend_y(:,index1),"linewidth",4,"color",colour_mag);
% endfor
 %legend
% text(legend_xmin*0.95,1.04*legend_ymax,"Temperature (C)");
% text(legend_xmax,legend_ymin,num2str(min(T)));
% text(legend_xmax,legend_ymax,num2str(max(T)));
 
hold off;
