% Plot exercise.
close all;
clear all;

% Set values for voltage source and R1.
u = 1;
r1 = 1;

% Generate vector of values for R2.
r2 = linspace(0, 5*r1, 30);

% Current through voltage divider.
i = u ./ (r1 + r2);

% Voltages over resistors.
u_r1 = i * r1;
u_r2 = i .* r2;

% Power consumed by resistors.
p_r1 = i .* u_r1;
p_r2 = i .* u_r2;


% Solution:

% Draw results in a figure.
figure(1);
% Top subplot, the voltages.
subplot(3, 1, 1);
plot(r2, u_r1, 'r--d');
hold on;
plot(r2, u_r2, 'b-^');
grid on;
title('Voltage divider');
ylabel('Voltage [V]');
legend('U_{R1}', 'U_{R2}');
% Middle subplot, the current.
subplot(3, 1, 2);
plot(r2, i, 'm-o');
grid on;
ylabel('Current [A]');
legend('I');
% Bottom subplot, the powers.
subplot(3, 1, 3);
plot(r2, p_r1, 'r--d');
hold on;
plot(r2, p_r2, 'b-^');
grid on;
ylabel('Power [W]');
xlabel('R2 [\Omega]');
legend('P_{R1}', 'P_{R2}');