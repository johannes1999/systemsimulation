% Line Types
clear all
close all

x = 0:0.2:2*pi;
plot(x, cos(x), 'rd-'); 
hold on;
plot(x, cos(2*x), 'bo:');
plot(x, 1./cosh(x), 'g+--');
plot(x, -1./cosh(x), 'm*-.');

xlabel('x');
ylabel('function values');
title('Line Type Example');

legend('cos(x) - red diamond solid', ...
       'cos(2x) - blue circle dotted', ...
       '1/cosh(x) - green plus dashed', ...
       '-1/cosh(x) - mangenta star dash-dotted');