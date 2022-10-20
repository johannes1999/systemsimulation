% Continue - normally not needed.
clear all;
close all;

for i = 0:9
    for j = 0:9
        if (j >= i)
            fprintf('%d ', j);
        end
    end
    fprintf('\n');
end
