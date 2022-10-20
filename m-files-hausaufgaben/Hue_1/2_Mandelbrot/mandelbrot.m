% m-file mandelbrot
%
% Dieser m-file ist eine Information zur Hausübung 1.2 
%
% Erklärung 
%  Beschreibung der Madelbrot-Menge siehe 
%  https://de.wikipedia.org/wiki/Mandelbrot-Menge
%	
% Quelle: https://de.mathworks.com/help/distcomp/examples/
%         illustrating-three-approaches-to-gpu-computing-the-mandelbrot-set.html
%
%  Dieser m-File wurde zur Vorbereitung der Hausübung 1.2 SS 2020 
%  genutzt.
%
% Datum:    2020-04-16
% Änderung: 
%
% Benötigte eingene externe functions: keine
%
% siehe auch: apfel
%
%--------------------------------------------------------------------------
close all;
clearvars;

maxIterations = 500;
gridSize = 1000;
xlim = [-0.748766713922161, -0.748766707771757];
ylim = [ 0.123640844894862,  0.123640851045266];

% Setup
t = tic();
x = linspace( xlim(1), xlim(2), gridSize );
y = linspace( ylim(1), ylim(2), gridSize );
[xGrid,yGrid] = meshgrid( x, y );
z0 = xGrid + 1i*yGrid;
count = ones( size(z0) );

% Calculate
z = z0;
for n = 0:maxIterations
    z = z.*z + z0;
    inside = abs( z )<=2;
    count = count + inside;
end
count = log( count );

% Show
cpuTime = toc( t );

figure
imagesc( x, y, count );
colormap( [jet();flipud( jet() );0 0 0] );
axis off
title( sprintf( '%1.2fsecs (without GPU)', cpuTime ) );

figure
histogram(count)