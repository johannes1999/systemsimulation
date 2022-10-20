% Programming exercise.
close all;
clear all;

v0 = 4;     % Start velocity [m/s].
dt = 0.01; % Time steps [s].
t0 = 10;    % Ball thrown at this time [s].

% Calculate trajectory.
[height, time] = ball(v0, dt);

% Draw trajectory.
figure(1);
plot(time, height, 'r-');
grid on;
title('Ball trajectory');
xlabel('Time [s]');
ylabel('Height[m]');