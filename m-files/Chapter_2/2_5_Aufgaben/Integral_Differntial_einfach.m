%  Integral_Differntial_einfach.m
%
% Beispiel für die einfachste Berechung des Integrals und der Ableitung.
% 
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2018-06-05
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars
close all

% Beispielfunktion Sinus
N=400;
x=linspace(0,2*pi,N);
dx=x(2)-x(1);
y=sin(x); % Funktion

%Integration mit Rechtformel mit dem Matlab-Befehl cumsum
I=cumsum(y)*dx;

% Bildung der Ableitung über die Differenz-befehl diff
% Die Länge des Ergebnis-Vektors ist um Eins verkürzt 
dy_dx=diff(y)/dx;          % Erste Ableitung

d2y_dx2=diff(dy_dx)/dx;    % Zweite Ableitung einfach

% Zweite Ableitung mit beidseitigem Differenzen-Quotienten
f_minus=y(1:end-2);
f_0=y(2:end-1);
f_plus=y(3:end);
d2y_dx2_skript=(f_plus-2*f_0+f_minus)/dx^2;

figure
plot(x,y,'b',x,I,'r',x(1:end-1),dy_dx,'g'); 
grid
legend('f(x)', 'Int(f(x))', 'df(x)/dx')

figure
subplot(2,1,1)
plot(x(1:end-2),d2y_dx2,'b',x(1:end-2),d2y_dx2_skript,'g -.'); 
legend( 'd2f(x)/dx^2', 'd2f(x)/dx^2_{skript}')
grid
subplot(2,1,2)
plot(x(1:end-2),d2y_dx2-d2y_dx2_skript,'r'); 
title('Abweichungen')
grid
