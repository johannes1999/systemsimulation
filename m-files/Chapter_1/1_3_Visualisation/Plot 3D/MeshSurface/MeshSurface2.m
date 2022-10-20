% Surface plot 2.
clear all;
close all;

x_axis = linspace(-10, 10, 50);
y_axis = linspace(-10, 10, 50);

[x, y] = meshgrid(x_axis, y_axis);

r = sqrt(x.^2 +y.^2);
z = sin(r)./r;

figure(1)
mesh(x, y, z);
title('mesh');

figure(2);
surf(x, y, z);
shading faceted;
title('surf, shading faceted');

figure(3);
surf(x, y, z);
shading flat;
title('surf, shading flat');

figure(4);
surf(x, y, z);
shading interp;
title('surf, shading interp');
