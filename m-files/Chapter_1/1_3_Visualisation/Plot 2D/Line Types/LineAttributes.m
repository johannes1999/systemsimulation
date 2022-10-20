% Line Attributes
% Example

x = linspace(0, 4*pi, 40);
y = sin(x);

plot(x, y, 'r--d');
axis([min(x) max(x) min(y)*1.1 max(y)*1.1]);