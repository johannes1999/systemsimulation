% Contour 2.
clear all;
close all;

% MATLAB test function.
[x, y, z] = peaks; 

figure(1);

subplot(2, 1, 1);
mesh(x, y, z);
title('mesh');

subplot(2, 1, 2);
contourf(x, y, z, 20)
colorbar('vert');
title('contourf');