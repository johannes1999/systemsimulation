% Multiple Plots
clear all
close all

x = 0:0.2:2*pi;

figure(1);
plot(x, cos(x), 'rd-'); 
xlabel('x');
ylabel('function values');
title('Line Type Example');

figure(2);
plot(x, cos(2*x), 'bo:');
xlabel('x');
ylabel('function values');
title('Line Type Example');
legend('cos(2x) - blue circle dotted');

figure(3);
plot(x, 1./cosh(x), 'g+--');
xlabel('x');
ylabel('function values');
title('Line Type Example');
legend('1/cosh(x) - green plus dashed');

figure(1);
hold on;
plot(x, -1./cosh(x), 'm*-.');
legend('cos(x) - red diamond solid', ...)
       '-1/cosh(x) - mangenta star dash-dotted');