% Surface plot 3.
clear all;
close all;

x_axis = linspace(-10,10, 30);
y_axis = linspace(-1, 10, 30);

[x, y] = meshgrid(x_axis, y_axis);

r = sqrt(x.^2 +y.^2);
z = sin(r)./r;

figure(1);

subplot(3, 2, 1);
mesh(x, y, z);
title('mesh');

subplot(3, 2, 2);
meshc(x, y, z);
title('meshc');

subplot(3, 2, 3);
meshz(x, y, z);
title('meshz');

subplot(3, 2, 4);
surf(x, y, z);
title('surf');

subplot(3, 2, 5);
surfc(x, y, z);
title('surfc');

subplot(3, 2, 6);
waterfall(x, y, z);
title('waterfall');


