% Nested for loop example.

N = 5;  % Number of rows.
M = 4;  % Number of columns.

x = 0:0.01:2*pi;

figure(1);

for n = 1:N
    for m = 1:M
        subplot(N, M, M*(n - 1) + m);
        plot(sin(n*x), cos(m*x));
    end
end