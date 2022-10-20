% Line Attributes
% Example
clear all;
close all;

attributes = [{'r-o'}, {'g--s'}, {'b:h'}, {'c-.^'}, {'k->'}, {'m--*'},];

x = linspace(1, length(attributes), 10);

for i = 1:length(attributes)
    plot(x, ones(size(x))*i, attributes{i});
    hold on;
end
axis([min(x) max(x) min(x)-(max(x)-min(x))*0.1 max(x)+(max(x)-min(x))*0.1]);