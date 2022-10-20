% Surface plot.

clearvars;  % workspace löschen
close all;

x_axis = -pi:0.1:pi;
y_axis = -2:0.2:2;
[x, y] = meshgrid(x_axis, y_axis);

z = sin(x);
z2=x/max(x_axis)+y/max(y_axis);
figure;
mesh(x, y, z);
hold
mesh(x, y, z2);
xlabel('x'); ylabel('y');zlabel('z');

figure
plot(x_axis, z(1,:))
grid

figure
plot(y_axis, z(:,10))
grid
