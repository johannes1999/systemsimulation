% Other Plots
clear all;
close all;

phi = 0:0.3:2*pi;
y1 = sin(phi);
y2 = cos(phi)/2;
y3 = sin(phi)/2;

figure(1);

subplot(3, 2, 1);
plot(phi, y1, 'r');
axis([0 2*pi -1.5 1.5]); grid on;
title('plot');

subplot(3, 2, 2);
stem(phi, y1, 'filled', 'k');
axis([0 2*pi -1.5 1.5]); grid on;
title('stem');

subplot(3, 2, 3);
area(phi, y1);
axis([0 2*pi -1.5 1.5]); grid on;
title('area');

subplot(3, 2, 4);
stairs(phi, y1);
axis([0 2*pi -1.5 1.5]); grid on;
title('stairs');

subplot(3, 2, 5);
bar(phi, [y1;y2;y3]', 'stacked');
axis([0 2*pi -2 2]); grid on;
title('bar');

subplot(3, 2, 6);
errorbar(phi, y1, y2, 'm:');
axis([0 2*pi -1.5 1.5]); grid on;
title('errorbar');

