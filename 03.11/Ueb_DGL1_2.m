% Ueb_DGL1_2.m 
%
% Vorlesungsbegleitende Übung
%
% Einfaches DC-Motor- Modell mit Drehmoment-Puls
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
% siehe auch: test_DGL1_1 und test_DGL1_2
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
dt=0.01;           % Schrittweite  [s]
t_end=1; 	    % Zeitdauer     [s] 
t=0:dt:t_end;   % Zeitvektor    [s]
Nt=length(t);   % Anzahl Werte 



     %% Streckenzug-Verfahren nach Euler M_L(t)

        % LastMoment 
        M_L=@(t,M_0,Tau) ?;
     
        % DGL
        % DC- Motor-Modell ohne Ankerinduktivität
        dw_dt=@() ?;

        % Anfangsbedingung
        w_0=w_max;	  		% Winkelgeschwindigkeit	    [rad/s]
        
        % Lastmoment
        T_s=0.01;           % Zeitkonstante Lastmoment  [s]
         M=M_L(t,M_0,T_s);  % Lastmoment                [Nm]

         % Anmerkung
         % Diese M wird für die Darstellung. 
         % Für die DGL muss die function M_L benutzt werden.

        % Streckenzug-Verfahren nach Euler
        %---------------------------------
        w=zeros(1,Nt);  % Winkelgeschwindigkeit [rad/s]
        w(1)=?;       % Anfangswert           [rad/s]

        for i=2:Nt
            ???
        end


figure
subplot(2,1,1)
    plot(1e3*t,w,'b')
    xlabel(' t[ms]')
    ylabel('w [1/s]')
    grid
    title('DC-Motor')
subplot(2,1,2)
    plot(1e3*t,M*1e3,'r')
    xlabel(' t[ms]')
    ylabel('M_{Last} [mNm]')
    grid
   


