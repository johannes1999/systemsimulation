% If then else example
clear all;
close all;

for i = -2:6
    fprintf('%d ', i);
    if (i == 0)
        fprintf('Zero\n');
    elseif ((i > 1) & (i < 5))
        fprintf('Between zero and five\n');
    elseif (i < 0)
        fprintf('Negative\n');
    else
        fprintf('Five or larger\n');
    end
end