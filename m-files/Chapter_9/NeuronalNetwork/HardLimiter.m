% function: HardLimiter.m	
% 
% HardLimiter-Aktivierungsfunktion für neuronale Netze
%
%       amp     : Schwellwert 
%       variante: 1: Limiter mit x < 0 -> y=0
%                                x >=0 -> y=amp
%
%                 2: Limiter mit x < 0 -> y=-amp
%                                x >=0 -> y=+amp
%
% Autor: Horst Rumpf
%        Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%        funktionale Systemsimulation Kapitel 9 SoSe 2022 erstellt.
%
% Datum:    2021-02-04
%
% Änderung: 
%
% siehe auch: Sigmoid.m
%--------------------------------------------------------------------------

function y=HardLimiter(x,variante,amp)

if nargin < 3
     amp=1;  % Schwellwert =1 
     if nargin < 2
         variante=1; % Einseitiger Limiter
     end
end

switch variante
    case 1           
        y=amp*(x>0);    % Einseitiger Limiter
    case 2
    y=amp*(2*(x>0)-1);  % Zweiseitiger Limiter
end