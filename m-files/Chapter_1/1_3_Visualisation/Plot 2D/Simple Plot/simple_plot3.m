% Simple plot 3
clear all;
close all;

x = 0:0.05:6;
plot(x, cos(x));
hold on;
plot(x, 1./cosh(x));

xlabel('x');
ylabel('function values');
title('Simple plot of two crossing curves');