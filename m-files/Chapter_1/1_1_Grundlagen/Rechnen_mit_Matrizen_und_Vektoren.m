% m-file Rechnen_mit_Matrizen_und_Vektoren.m
%
% Das Rechnen mit Vektoren und Matrizen bereitet immer wieder
% Schwierigkeiten. Aus den festgestellten Problemen wurden diese
% Beispiele erzeugt.
%
% 
% output: 
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation WiSe 2021_22 erstellt.
%
% Datum:    22-10-2021
%
% Änderung: 
%
% Benötigte functions: keine
%
% siehe auch:  
%--------------------------------------------------------------------------
clearvars;
close all;
clc;
%% 1. Problem: Schleifenzähler

% Schleifen-Zähler
%-----------------
% Variante 1.1
for i=1:10
    disp(i)
end

% Variante 1.2
for i=1:2:10
    disp(i)
end

% Variante 1.3
for i=2:2:10
    disp(i)
end

% Variante 1.4
for i=[10 5 6 -1 8.1]
    disp(i)
end

%% 1. Problem: Das Füllen von Vektoren
%-------------------------------------
 a=zeros(1,10);
 b=zeros(1,10);

% Mit Schleife
for i=2:2:10
    a(i)=i;
    b(i-1)=i;
end

clc;            
disp(a)
disp(b)

% Ohne Schleife 
% gleicher Wert

a=zeros(1,10);
a(1:2:end)=1;

clc;            
disp(a)

% mit Werten aus einem anderen Vektor
c=zeros(1,10);
n=1:5;
c(1:2:end)=n;

clc;            
disp(c)

% Wenn es ein durchgängig Berechnung gibt, aber nur
% jeder zweite Wert benötigt wird
k=1:10;
d=1./k;
d(2:2:end)=0;

clc;            
disp(d)