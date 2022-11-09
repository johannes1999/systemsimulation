% Ueb_DGL1_1.m 
%
% Vorlesungsbegleitende Übung
%
% Einfaches DC-Motor- Modell
%
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2021 erstellt.
%
% Datum:    2021-11-12
%
% Änderung: 
%
% siehe auch: 
%----------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen.

% Systemparameter 
Ra=10;         	% Ankerwiderstand     	    [Ohm]
Psi=15e-3;		% Verketteter Fluss 		[Vs]
J=5e-7;         % Massenträgheitsmoment 	[kgm²]
Tm=Ra*J/Psi^2;	% Elektromech. Zeitkonst.   [s]

% Störgrößen
Ua=5;         	% Konstante Motorspannung	[V] 
M_0=5e-3; 		% Lastmoment 			    [Nm]

% Maximale Winkelgeschwindigkeit
w_max=Ua/Psi-Ra/Psi^2*M_0;  %               [rad/s]


% Zeitbereich
%-------------
dt=0.001;           % Schrittweite  [s]
t_end=0.2; 	    % Zeitdauer     [s] 
t=0:dt:t_end;   % Zeitvektor    [s]
Nt=length(t);   % Anzahl Werte 



    %% Streckenzug-Verfahren nach Euler M_L=const

        % DGL DC-Motor-Modell ohne Ankerinduktivität
        dw_dt=@(J, Psi, Ra, Ua, M_0, w) (1/J)*((Psi/Ra)*Ua - M_0)-((Psi^2)/(Ra*J))*w;
       
        % Anfangsbedingung
        w_0=0;	  		% Winkelgeschwindigkeit	 [rad/s]

        % Streckenzug-Verfahren nach Euler 
        % für die Winkelgeschwindigkeit w
        %---------------------------------
    
        w = zeros(1, Nt);
        w(1) = w_0;
        for zaehler = 2:Nt
            w(zaehler) = w(zaehler-1) + dw_dt(J, Psi, Ra, Ua, M_0, w(zaehler-1))*dt;
        end


figure
subplot(2,1,1)
    plot(1e3*t,w,'b')
    xlabel(' t[ms]')
    ylabel('w [1/s]')
    grid
    title('DC-Motor')
