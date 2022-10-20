% m-file test_roots
%
% Beispiele zu matlab-functions für Nullstellenberechnung eines Polynoms
%
% 
% output: 
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%
% Datum:    24-05-2020
%
% Änderung: 
%
% Benötigte eingene externe functions: keine
%
% siehe auch:  fzero, fminbnd
%
%--------------------------------------------------------------------------
clearvars;
close all;

 x=-2:0.01:3.5;
 p=[1 -2 -5 2]; % Polynom Parameter x^3 -2x^2 -5x +2
 y=polyval(p,x);% Funktionswerte

 x_null=roots(p);           % Nullstellen des Polynoms 
 y_null=polyval(p,x_null);  % 
 
 figure; plot(x,y,'b',x_null,y_null,'r *'); grid
 title('Nullstellen mit roots ermittelt')
    