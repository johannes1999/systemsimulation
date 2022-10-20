% Switch example 2
clearvars;
close all;


vehicle = 'bicycle';

fprintf('%s: ', vehicle);
switch(vehicle)
    case 'car'
        fprintf('has four wheels\n');
    case {'bike', 'bicycle', 'moped'}
        fprintf('has two wheels\n');
    otherwise
        fprintf('unknown vehicle');
end
