% Double Y-Axis - Different axis styles
clear all;
close all;

x = 0:0.05:6;
plotyy(x, cos(x), x, 1./cosh(x), @plot, @semilogy);

xlabel('x');
ylabel('function values');
title('Double y-axis - Different axis styles');