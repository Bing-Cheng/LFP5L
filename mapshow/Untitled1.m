close all;
x = 1:25; 
y = FqBTRa; 
xi = 1:0.5:25; 
yi = interp1(x,y,xi,'cubic'); 
plot(x,y,'o',xi,yi)