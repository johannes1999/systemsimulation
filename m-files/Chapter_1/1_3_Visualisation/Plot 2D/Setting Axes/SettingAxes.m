% Setting axes.
clear all
close all

t = 0:0.001:20*pi;

x  = t.*sin(t)/max(t);
yb = t.*cos(2*t)/max(t);
yr = t.*sin(2*t)/max(t);

figure(1);

subplot(1, 2, 1);
plot(x, yb, 'b'); 
hold on;
plot(x, yr, 'r');
axis([-1 1 -1 1]);

subplot(2, 2, 2);
plot(x, yb, 'b'); 
hold on;
plot(x, yr, 'r');
axis([-0.3 0.4 -0.2 0.5]);

subplot(2, 2, 4);
plot(x, yb, 'b'); 
hold on;
plot(x, yr, 'r');
axis([-0.9 -0.5 -1 -0.6]);

