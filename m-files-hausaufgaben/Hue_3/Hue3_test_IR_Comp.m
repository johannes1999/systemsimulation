% m-file Hue_test_IR_Comp.m
%
% Vorgabe-file f�r die 3te Haus�bung
% DC-Motor mit IR-Kompenastion
%
%
% Datum:    18-12-2021
%
% �nderung: 
%
% siehe auch: 
%
%--------------------------------------------------------------------------
clearvars;
close all;


% Systemparameter
%================

% Motorparameter
%---------------
 Psi=15e-3;          % Verketteter Fluss                 [Vs]
 Ra=10;              % Ankerwiderstand                   [Ohm]
 La=10e-3;           % Ankerinduktivit�t                 [H]
 J=5e-7;             % Massentr�gheitsmoment             [kgm�]

% Beschreibende System Parameter
%-------------------------------
% Anhand dieser Wert kann man schon sehen wie sich das System verh�lt.

Ta=La/Ra;           % Ankerkreiskonstante                [s]
Tm=(Ra*J)/Psi^2;    % Elektromechanische Zeitkonstante   [s]
delta=1/(2*Ta);     % Abklingkonstante                   [1/s]

w=sqrt(Psi^2/(La*J));   % Eigenfrequenz                  [1/s]
D=delta/w;              % D�mpfungsfaktor                [-]
Ra_ap=La*w;             % Widerstand f�r Aperiodische 
                        % Grenzfall                      [Ohm]
% St�rgr��en
%-----------
M_last=4e-3;            % Mechanische Last               [Nm]
dM_last_dt=0;           % Last�nderung                   [Nm/s]

% Eingangsgr��en
%---------------
Ua=10;              % max. Ankerspannung                [V]
Ua_c=5;             % Spannung f�r Solldrehzahl         [V] 

% Simulationszeit
%----------------
t_start = ;         % Zeit[s]
t_end   = ;	        % xxx
Nt=400;
t=linspace(t_start,t_end,Nt);

% Anfangsbedingung t=0
%---------------------

Al_0= ;  % Anfangswinkelbeschleunigung    [1/s�]
w_0=  ;  % Winkelgeschwindigkeit          [1/s]

y0 = [Al_0 w_0]';	

 % Einstellungen f�r ode
 %----------------------
    tol    = 1.e-12;               % Toleranzen
    options= odeset('RelTol', tol);

% Variation 3 Kompensationswerte
k_var=[0 0.5 1/sqrt(2) 0.8 0.9 0.97 1.0];

%% Hier die Variation einbauen
%   ....
%   ....
    [t,Y] = ode45(@dgl_Motor_c,t,y0,options,...);
    ...        % Winkelbeschleuigung [rad/s�]
    ...        % Drehzahl n=w/(2*pi) [rpm]
%   ....
%   ....


figure
    plot(t*1e3,n)
    xlabel('t [ms]')
    ylabel('n [rpm]')
    legend('0', '0.5', '0.707', '0.8', '0.9', '0.97', '1.0')
    title('Drehzahl-Verlauf mit 7 Kompensationswerten')
    grid   



%% function dgl_Motor_c
%-----------------------
function du_dt = dgl_Motor_c(~,y0,...)

%% Hier die DGL einbauen

end

