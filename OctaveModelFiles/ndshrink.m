function vector = ndshrink(ndmatrix,address)
%function vector = ndshrink(ndmatrix,address)
%ndMatrix is the matrix that you'd like to shrink into a vector
%address is a string


eval(strcat("vector = ndmatrix(",address,");"));

vector = flipud(rotdim(vector,1));


return