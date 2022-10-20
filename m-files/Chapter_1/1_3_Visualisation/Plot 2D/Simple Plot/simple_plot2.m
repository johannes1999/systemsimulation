% Simple plot 2
clear all;
close all;

x = 0:0.05:6;
plot(x, cos(x));
hold on;
plot(x, 1./cosh(x));