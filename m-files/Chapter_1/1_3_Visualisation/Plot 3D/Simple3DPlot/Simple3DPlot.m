% Simple 3D Plot.
clear all;
close all;
T = 40;
t = 0:0.01:T;

x1 = sin(t);
y1 = cos(t);
z1 = t/T;

x2 = t.*sin(t)/max(t);
y2 = t.*cos(t)/max(t);
z2 = t/T;

figure(1);
plot3(x1, y1, z1, 'r');
hold on;
plot3(x2, y2, z2, 'b');
grid on;
legend('Red spiral', 'Blue spiral');
title('Spirals in 3D');