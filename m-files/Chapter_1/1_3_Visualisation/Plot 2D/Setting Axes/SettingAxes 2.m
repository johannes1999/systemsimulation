% Setting axes 2.
clear all
close all

t = 0:0.001:20*pi;

x = t.*sin(t)/max(t);
y = t.*cos(t)/max(t);

figure(1);

subplot(3, 2, 1);
plot(x, y, 'b');
axis normal;
title('axis normal');

subplot(3, 2, 2);
plot(x, y, 'b');
axis square;
title('axis square');

subplot(3, 2, 3);
plot(x, y, 'b');
axis equal;
title('axis equal');

subplot(3, 2, 4);
plot(x, y, 'b');
axis tight;
title('axis tight');

subplot(3, 1, 3);
plot(x, y, 'b');
axis tight;
axis off;
title('axis tight; axis off');
