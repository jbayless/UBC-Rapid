
freq = 10000000;
w = 2*pi*freq;
c = 299792458;
k = w/c;
rin = 1.5/1000;


J0_rin = 0.99999997529181439990060378332603783326031985870406572482588091251819629860601;
1-J0_rin

J0_krin = besselj(0,k*rin);

1-J0_krin