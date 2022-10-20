function [h, t] = ball(v0, dt)
% At t = 0 the ball is thrown up in the air with
% starting velocity v0. This function calculates
% the ball's trajectory h(t) until it hits the
% ground again (h = 0). Points on the trajectory
% are separated dt seconds in time.

% Gravity [m/s^2]
g = 9.81;  

i = 1;
h(i) = 0;
t(i) = 0;
while (i == 1 || h(i) > 0)
    i = i + 1;
    t(i) = t(i-1) + dt;
    h(i) = v0*t(i) - 0.5*g*t(i)^2;
end    