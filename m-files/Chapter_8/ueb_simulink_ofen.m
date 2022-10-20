%  ueb_simulink_ofen.m 
%
% Dieser file stellt alle Parameter für ein Simulink-Modell bereit,
% ruft das simulink modell ueb_sim_dgl_Ofen auf und
% stellt das Ergebnis dar.
% Ziel der Übung ist das Erstellen des Simulink Modells ueb_sim_dgl_Ofen.
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation WS 21/22 erstellt.
%
% Datum:    2022-01-13
%
% Änderung:  
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars  
close all


%% 1: Werkstück in einem Ofen
% Beispiel aus Modellbildung und Simulation
% dyamischer Systeme; Helmut Scherf
%------------------------------------------   

m=100;      % Masse Werkstück               [kg]
c=500;      % spez. Wärmekapazität          [J/(kg K)]
A=0.323;    % Werkstückoberfläche           [m²]
Al=15;      % Wärmeübergangskoeffizient     [W/(m²K)]
T_Ofen=800; % Temperatur Ofen               [°C]
T_w_0=20;   % Temperatur Werkstück          [°C]

Tau=c*m/(Al*A); % Zeitkonstante             [s]  

sim_time=round(5*Tau,1);    % Simulationszeit       [s]
N=500;                      % Anzahl Stützstellen   [-]

t=linspace(0,5*Tau,N);

%Das Simulik-Modell ueb_sim_dgl_Ofen ist zu erstellen.
sim('ueb_sim_dgl_Ofen',t); % Aufruf Simulationsmodell

figure;
    plot(t/3600,T_w,'r');grid
xlabel('t [h]'); ylabel('T_{Werkstück} [°C]')

