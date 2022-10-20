% Subplots 2
clear all
close all

x = 0:0.2:2*pi;

figure(1);
subplot(2, 1, 1);
plot(x, cos(x), 'rd-'); 
xlabel('x');
ylabel('function values');
title('Subplot Example');

subplot(2, 2, 3);
plot(x, cos(2*x), 'bo:');
xlabel('x');
ylabel('function values');
legend('cos(2x)');

subplot(2, 2, 4);
plot(x, 1./cosh(x), 'g+--');
xlabel('x');
ylabel('function values');
legend('1/cosh(x)');

subplot(2, 1, 1);
hold on;
plot(x, -1./cosh(x), 'm*-.');
legend('cos(x)', '-1/cosh(x)');