%  ueb_simulink_Raeuber_Beute.m 
%
%
% Dieser file stellt alle Parameter f�r ein Simulink-Modell bereit,
% ruft das simulink modell ueb_sim_dgl_Raeuber_Beute auf und
% stellt das Ergebnis dar.
% Ziel der �bung ist das Erstellen des Simulink Modells 
% ueb_sim_dgl_Raeuber_Beute.
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation WS 21/22 erstellt.
%
% Datum:    2022-01-13
%
% �nderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars  
close all

%% R�uber Beute Modell
% Beispiel aus Wikipedia

gx=0.05;   % Geburtenrate Beute
ax=0.003;  % Sterberate Beute
gy=0.1;    % Geburtenrate R�uber
ay=0.002;  % Sterberate R�uber

N=1000;
t_start =0;
t_end   =200;
t=linspace(t_start, t_end, N);

% Anfangswerte t=0;

x_0=90; % Beute Anfangswert
y_0=15; % R�uber Anfangswert

% Das Simulik-Modell ueb_sim_dgl_Raeuber_Beute ist zu erstellen.
sim('ueb_sim_dgl_Raeuber_Beute',t);

figure
    plot(t,x,'b',t,y,'r')
    grid;
    xlabel('t [Jahre]');
    ylabel('Population [-]');
    title('R�uber - Beute Modell')
    legend('Beute', 'R�uber')
