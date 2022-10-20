% PlotBatmanData.m
%
%
% Plottet die x,y Daten der Batman-Funktion. Die Daten sind in dem file 
% BatManData.mat abgelegt.
%
% In einer Endlosschleife wird die Darstellung in x-Richtung gestaucht 
% Dadurch entsteht der Effekt des Drehens.
%
%              
% 		
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen. Neue matlab-Version nutzt clearvars!

% x, y Daten laden

Pfad='C:\Users\de19478\source\repos\Systemsymulation\m-files\Allgemeine Beispiele\Batman\';%'C:\Users\HRumpf\Documents\02_Horst\Studium Plus\07_Sytem_Simulation\05_Matlab_work\Aufgaben\';
Datei='BatManData.mat';
load([Pfad Datei], 'x_bat','y_bat');

% Daten in Matrix-Form bringen

BatMan(1,:)=x_bat;
BatMan(2,:)=y_bat;
BatMan(3,:)=ones(size(x_bat));

sy=1; % Skalierung in y-Richtung auf 1        
figure
a=0;    % Eine Art Drehwinkel

while 1 % Endlosschleife

a=a+0.02;
    sx=sin(a);
    T_skal=[sy 0  0
            0 sx  0
            0  0  1];
        
B=T_skal*BatMan; % Skalierung   

fill(B(1,:),B(2,:),'b');
set(gca,'xlim',[-8 8],'ylim',[-3 3]);  
axis off
pause(0.01)
end
