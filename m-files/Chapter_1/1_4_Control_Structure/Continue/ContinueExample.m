% Continue example.
clear all;
close all;

for i = 0:9
    for j = 0:9
        if (j < i)
            continue;
        end
        fprintf('%d ', j);
    end
    fprintf('\n');
end
