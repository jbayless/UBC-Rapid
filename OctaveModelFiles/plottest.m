EE = zeros(length(Escale),1);
sss = zeros(length(s),1);
n=1
for index2 = 1:length(Escale)
	EE(index2)=Escale(n,1,index2);
	sss(index2) = s(n,1,index2);
endfor

figure();
plot(sss,EE);
figure();
plot(s(n,1,:),Escale(n,1,:));
figure();
plot(sss,Escale(n,1,:));
figure();
plot(s(n,1,:),EE);