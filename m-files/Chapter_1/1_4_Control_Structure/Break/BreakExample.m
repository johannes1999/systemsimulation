% Break example
clear all;
close all;

for i = 0:9
    for j = 0:9
        fprintf('%d ', j);
        if i == j
            fprintf('\n');
            break;
        end
    end
end
