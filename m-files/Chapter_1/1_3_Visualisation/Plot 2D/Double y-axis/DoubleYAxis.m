% Double Y-Axis
clear all;
close all;

x = 0:0.05:6;
plotyy(x, cos(x), x, 1./cosh(x));

xlabel('x');
ylabel('function values');
title('Double y-axis');