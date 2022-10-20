% Histogram
clear all
close all

N = 100000; % Number of samples.
M = 50;    % Number of bins.

x_uniform = rand(N, 1);
x_normal = randn(N, 1);

figure(1);
subplot(2, 1, 1);
hist(x_uniform, M);
title('Uniform distribution');

subplot(2, 1, 2);
hist(x_normal, M);
title('Normal distribution');
