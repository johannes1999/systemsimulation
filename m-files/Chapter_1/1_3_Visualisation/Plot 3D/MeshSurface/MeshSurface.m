% Surface plot.

clearvars;  % workspace löschen
close all;

x_axis = -10:0.5:10;
y_axis = -10:0.5:10;

[x, y] = meshgrid(x_axis, y_axis);

r = sqrt(x.^2 +y.^2);
z = sin(r)./r;

figure(1);
mesh(x, y, z);
xlabel('x'); ylabel('y');zlabel('z');