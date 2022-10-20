% Other 3D Plots.
clear all;
close all;
T = 20;
t = 0:0.1:T;

x1 = sin(t);
y1 = cos(t);
z1 = t/T;

x2 = t.*sin(t)/max(t);
y2 = t.*cos(t)/max(t);
z2 = t/T;

figure(1);
stem3(x1, y1, z1, 'r');
title('Spirals in 3D');