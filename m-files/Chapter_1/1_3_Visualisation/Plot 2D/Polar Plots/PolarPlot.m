% Polar Plots
clear all;
close all;

angle = 0:0.05:2*pi;
r_sin = sin(angle);
r_cos = cos(angle);
r_const = 0.5*ones(size(angle));

figure(1);

subplot(2, 1, 1);
polar(angle, r_sin, 'b:');
hold on;
polar(angle, r_cos, 'r--');
polar(angle, r_const, 'g');
title('polar');
legend('sin', 'cos', 'const');

subplot(2, 1, 2);
plot(angle, abs(r_sin), 'b:');
hold on;
plot(angle, abs(r_cos), 'r--');
plot(angle, r_const, 'g');
title('plot');
legend('sin', 'cos', 'const');
