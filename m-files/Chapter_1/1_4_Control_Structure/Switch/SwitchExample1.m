% Switch example 1
clearvars;
close all;

for i = 1:10
    fprintf('%d ',i);
    switch(i)
        case 1
            fprintf('One\n');
        case 2
            fprintf('Two\n');
        case {3, 5, 7, 8}
            fprintf('Three, five, seven or eight\n');
        otherwise
            fprintf('Not one, two, three, five, seven or eight\n');
    end
end