% Simple plot 4
clear all;
close all;

x = 0:0.05:6;
plot(x, cos(x));
hold on;
plot(x, 1./cosh(x));

xlabel('x');
ylabel('function values');
title('Simple plot of two crossing curves');

text(2.1,  0.3, '1/cosh(x)');
text(1.2, -0.4, 'cos(x)');