% ueb_simulink_Pendel.m
%
% Dieser file stellt alle Parameter für ein Simulink-Modell bereit,
% ruft das simulink modell ueb_sim_Pendel auf und stellt das Ergebnis dar.
%
% Ziel der Übung ist das Erstellen des Simulink Modells 
% ueb_sim_Pendel.
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SW 21/22 erstellt.
%
% Datum:    2022-01-13
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars  
close all
        %% 2: Mathematisches Pendel
        %--------------------------
            g=9.81;             % Erdbeschleunigung                 [m/s²]
            L=10;               % Länge Pendel                      [m]
            Phi_0=60*pi/180;    % Auslenkung bei t=0                [rad]
            Omega_0=0;          % Winkelgeschwindigkeit bei t=0     [1/s]
            sim_time=10;        %
            dt=1e-4;            % Schrittweite                      [s]
            t=1:dt:10;
            
            % Zustandsraumdarstellung
             
            % System-Matrix
            A1=[0   -g/L
                1   0  ];
    
            % Eingangs-Matrix
            B1=[0 0]';
    
            % Ausgangsmatrix
            C1=[1 0 
                0 1];
    
            % Durchgangs-Matrix 
            D1=[0 0]';
    
            % Anfangsbedingungen
            x1_0=[Omega_0 Phi_0]';
  
            
            sim('ueb_sim_Pendel',t);
            
            
            figure;
            subplot(2,2,1)
                plot(t,Alpha,'b');grid
                xlabel('t [s]'); ylabel('\alpha [1/s²]')
                title('Mathematisches Pendel')
            subplot(2,2,2)
                plot(t,Omega,'b');grid
                xlabel('t [s]'); ylabel('\omega [1/s]')
            
            subplot(2,2,3)
                plot(t,Phi*180/pi,'b');grid
                xlabel('t [s]'); ylabel('Phi [°]')     

        