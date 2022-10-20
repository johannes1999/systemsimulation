% Mandelbrot Fractal.
clear all;
close all;

MaxCount = 256;

NrRows = 400;
NrCols = 400;

result = zeros(NrRows, NrCols);

yrange = linspace(-1.5, 1.5, NrRows);
xrange = linspace(-2.0, 1.0, NrCols);

for ri = 1:NrRows
    for ci = 1:NrCols
        z = 0;
        c = xrange(ci) + i*yrange(ri);
        count = 0;
        while ( (abs(z) < 16) & (count < MaxCount) )
            z = z^2 + c;
            count = count + 1;
        end
        result(ri, ci) = count;
    end
end

figure(1);
image(result);
colormap('jet')
axis off;
axis equal;
title('Mandelbrot Fractal');