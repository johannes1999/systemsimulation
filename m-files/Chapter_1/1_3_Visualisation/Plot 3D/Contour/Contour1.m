% Contour 1.
clear all;
close all;

% MATLAB test function.
[x, y, z] = peaks; 

figure(1);

subplot(2, 2, 1);
mesh(x, y, z);
title('mesh');

subplot(2, 2, 2);
[C, h] = contour(x, y, z)
clabel(C, h);
title('contour');

subplot(2, 2, 3);
[C, h] = contour(x, y, z, 10)
clabel(C, h);
title('contour: 10 contour lines');

subplot(2, 2, 4);
height = [-8 -4 -2 0 2 4 8];
[C, h] = contour(x, y, z, height)
clabel(C, h);
title('contour: define contours');