% test_DGL1_4.m 
%
% Vorlesungsbegleitende Übung
% Dieser m-file beinhaltet die Lösungen für
% die Ueb_DGL1_1.m und Ueb_DGL1_2.m . 
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
dt=Tm/100;      % Schrittweite  [s]
t_end=7*Tm; 	% Zeitdauer     [s] 
t=0:dt:t_end;   % Zeitvektor    [s]
Nt=length(t);   % Anzahl Werte 



Fall=3; % 1: Streckenzug-Verfahren nach Euler mit konstantem Lastmoment
        % 2: Streckenzug-Verfahren nach Euler mit zeitabhängigem Lastmoment
        % 3: ODE45 mit konstantem Lastmoment

switch Fall
    case 1
    %% Streckenzug-Verfahren nach Euler M_L=const

        % DGL DC-Motor-Modell ohne Ankerinduktivität
        dw_dt=@(w,Ua,M_L,Ra,Psi,J) 1/J*(Psi/Ra*Ua-M_L)-Psi^2/(Ra*J)*w;
        % Lastmoment
        M=M_0*ones(1,Nt);% Konstantes Lastmoment [Nm]
        
        % Anfangsbedingung
        w_0=0;	  		% Winkelgeschwindigkeit	 [rad/s]

        % Streckenzug-Verfahren nach Euler
        %---------------------------------
        %w=zeros(1,Nt);  % Winkelgeschwindigkeit  [rad/s]
        %w(1)=w_0;       % Anfangswert            [rad/s]

        %for i=2:Nt
        %    w(i)=w(i-1)+dw_dt(w(i-1),Ua,M_0,Ra,Psi,J)*dt;
        %end
    case 2
     %% Streckenzug-Verfahren nach Euler M_L(t)

        % LastMoment 
        M_L=@(t,M_0,Ts) M_0*(1+exp(-t/(2*Ts))-exp(-t/Ts));
     
        % DGL
        % DC- Motor-Modell ohne Ankerinduktivität
        dw_dt=@(t,w,Ua,M_0,Ts,Ra,Psi,J) 1/J*(Psi/Ra*Ua-M_L(t,M_0,Ts))-Psi^2/(Ra*J)*w;

        % Anfangsbedingung
        w_0=w_max;	  		% Winkelgeschwindigkeit	    [rad/s]
        
        % Lastmoment
        T_s=0.01;           % Zeitkonstante Lastmoment  [s]
         M=M_L(t,M_0,T_s);  % Lastmoment                [Nm]

        % Streckenzug-Verfahren nach Euler
        %---------------------------------
        w=zeros(1,Nt);  % Winkelgeschwindigkeit [rad/s]
        w(1)=w_0;       % Anfangswert           [rad/s]

        for i=2:Nt
            w(i)=w(i-1)+dw_dt(t(i-1),w(i-1),Ua,M_0,T_s,Ra,Psi,J)*dt;
        end
    case 3
        % DC- Motor-Modell ohne Ankerinduktivität
        % t wird nicht in der function dw_dt verwendet,
        % aber ode45 ruft die function mit der DGL IMMER mit 
        % den Argumenten (Zeit t, Anfangswert w, und Parameter) auf!

        dw_dt=@(t,w,Ua,M_L,Ra,Psi,J) 1/J*(Psi/Ra*Ua-M_L)-Psi^2/(Ra*J)*w;
        
        % Lastmoment
        M=M_0*ones(1,Nt);% Konstantes Lastmoment [Nm]
        
        % Anfangsbedingung
        w_0=0;	  		% Winkelgeschwindigkeit	 [rad/s]

        % ode45
        [t,w] = ode45(dw_dt,t,w_0,[],Ua,M_0,Ra,Psi,J);  
     
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
