% Kapitel  2.1 Iteration 
%
% Iteration mit Newtonverfahren
% Aufgabe: Leiter
%	
% Autor:	Horst Rumpf
%
% Datum:	2017-04-14	
%
% see also:	

clearvars;
close all;
format long e;

al_0=48*pi/180;         % Startwinkel         [Grad]

dAl_max=1e-10;          % Abbruchskriterien
                        % 1. max. relative Ändernung
dAl=5*dAl_max;          %    Anfangswert > Abbruchskriterium
N=0;                    % 2. Zähler Anzahl Iterationsschritte
Nmax=10000;             %    max. Anzahl Iterationsschritte

while ((dAl > dAl_max) &&(N <Nmax))
    N=N+1;
    al_1=Newton(al_0);
    dAl=abs((al_0-al_1)/al_1); % rel. Änderung 
    al_0=al_1;
end
Al=al_0*180/pi;
disp(['Winkel = ' num2str(Al) ' Grad bei N= ' num2str(N) ' Interationsschritte'])

% Interne function
% NewtonVerfahren x_n+1=x_n-y(x_n)/y'(x_n)
%-----------------------------------------
function x_n1=Newton(x_n)
    y=1./sin(x_n)+1./cos(x_n)-3;
    dy_dx=-cos(x_n)./(sin(x_n)).^2+sin(x_n)./(cos(x_n)).^2;
    x_n1=x_n-y/dy_dx;
end
