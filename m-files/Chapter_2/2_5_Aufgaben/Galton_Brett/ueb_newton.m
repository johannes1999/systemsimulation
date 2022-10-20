% m-file: ueb_newton.m
%
%  Übung ohne Kommentare!
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen

% Vorgabe
%--------
soll_dNull=0.001;
ist_dNull=0.1;

x_n=-1000;    % Startwert

while ist_dNull > soll_dNull
    x_n=x_n-(x_n^3-2*x_n^2-5*x_n+2)/(3*x_n^2-4*x_n-5);
    ist_dNull=abs(x_n^3-2*x_n^2-5*x_n+2);
end 
disp(x_n)
