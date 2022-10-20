% Axis Linking.
clear all
close all

% Time.
t_max = 10;
t = 0:0.001:t_max;

% Linear frequency sweep from 0 to f_max.
f_max = 20;  
y  = sin(pi*f_max/t_max*t.^2);

% N-th order moving average filter.
N = 150;
yf = filter(ones(1,N)/N, 1, y);

% Plot data and filtered data.
figure(1);

h1 = subplot(2, 1, 1);
plot(t, y, 'b');
axis([0 t_max -1.5 1.5]);
title('Frequency sweep');

h2 = subplot(2, 1, 2);
plot(t, yf, 'r');
axis([0 t_max -1.5 1.5]);
title('Filtered frequency sweep');

%linkaxes.......
