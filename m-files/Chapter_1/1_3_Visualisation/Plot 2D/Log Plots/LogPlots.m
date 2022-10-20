% Logirithmic Plots.
clear all
close all

x  = 1:0.01:10;
y1 = x;
y2 = 0.1*x.^2;
y3 = exp(x/5);

figure(1);

subplot(2, 2, 1);
plot(x,y1,'r-',  x,y2,'b--',  x,y3,'g-.');
grid on; axis([1 10 1 10]);
title ('plot');

subplot(2, 2, 2);
semilogx(x,y1,'r-',  x,y2,'b--',  x,y3,'g-.');
grid on; axis([1 10 1 10]);
title ('semilogx');

subplot(2, 2, 3);
semilogy(x,y1,'r-',  x,y2,'b--',  x,y3,'g-.');
grid on; axis([1 10 1 10]);
title ('semilogy');

subplot(2, 2, 4);
loglog(x,y1,'r-',  x,y2,'b--',  x,y3,'g-.');
grid on; axis([1 10 1 10]); 
title ('loglog');