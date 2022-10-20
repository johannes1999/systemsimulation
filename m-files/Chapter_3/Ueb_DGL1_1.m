% Ueb_DGL1_1.m 
%
% Vorlesungsbegleitende �bung
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
% �nderung: 
%
% siehe auch: 
%----------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace l�schen.

% Systemparameter 
Ra=10;         	% Ankerwiderstand     	    [Ohm]
Psi=15e-3;		% Verketteter Fluss 		[Vs]
J=5e-7;         % Massentr�gheitsmoment 	[kgm�]
Tm=Ra*J/Psi^2;	% Elektromech. Zeitkonst.   [s]

% St�rgr��en
Ua=5;         	% Konstante Motorspannung	[V] 
M_0=5e-3; 		% Lastmoment 			    [Nm]

% Maximale Winkelgeschwindigkeit
w_max=Ua/Psi-Ra/Psi^2*M_0;  %               [rad/s]


% Zeitbereich
%-------------
dt=?;           % Schrittweite  [s]
t_end=?; 	    % Zeitdauer     [s] 
t=0:dt:t_end;   % Zeitvektor    [s]
Nt=length(t);   % Anzahl Werte 



    %% Streckenzug-Verfahren nach Euler M_L=const

        % DGL DC-Motor-Modell ohne Ankerinduktivit�t
        dw_dt=@( ) ???;
       
        % Anfangsbedingung
        w_0=0;	  		% Winkelgeschwindigkeit	 [rad/s]

        % Streckenzug-Verfahren nach Euler 
        % f�r die Winkelgeschwindigkeit w
        %---------------------------------
    
        ???


figure
subplot(2,1,1)
    plot(1e3*t,w,'b')
    xlabel(' t[ms]')
    ylabel('w [1/s]')
    grid
    title('DC-Motor')
