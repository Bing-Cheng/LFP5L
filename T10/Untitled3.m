clear;
a= [1:4];
b= fft(a)
c = angle(b)
d = real(b)./imag(b)