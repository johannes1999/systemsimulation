% Break - normally not needed.
clear all;
close all;

for i = 0:9
    j = 0;
    while (j <= i)
        fprintf('%d ', j);
        j = j + 1;
    end
    fprintf('\n');
end
