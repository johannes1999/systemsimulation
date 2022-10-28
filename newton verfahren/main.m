close all;
clearvars;

FUNKTIONSWERTE = 100;
x = linspace(-2,4, FUNKTIONSWERTE);

y1 = x.^3;
y2 = x.^2;
y2 = y2.*(-2);
y3 = x.*(-5);
y = y1+y2+y3+2;
NST = nullstellen_fun_01(y);




plot(x,diff(y),'b')
