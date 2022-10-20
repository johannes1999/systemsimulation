% test_DGL1_Bsp_ode.m 
%
% Beispiel mit DGL 1ter Ordnung mit ode45 und die DGL als lokale function.
% Beispiel R-C an Konstantspannung.
% Das ist evtl. für die 2te Hausübung hilfreich.
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2021 erstellt.
%
% Datum:    2021-12-03          
%
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen


%% 1: RC-Schaltung  und konstanter Spannungsquelle
%--------------------------------------------------

% System Paramenter und Störfunktion
%------------------------------------
R=10;       % Widerstand    [Ohm]
C=0.01;     % Kapazität     [F]
Tau=R*C;    % Zeitkonstante [s]

% Störfunktion Sinus-Spannung

Uo=10;      % Versorgungsspannung   [V]
f=50;       % Frequenz              [Hz]
T=1/f;      % Periodendauer         [s]

% Parameter Zusammenfassung
% Übersichtshalber alle Parameter in einen Vektor gepackt.
para=[R C Uo f];

% Anfangswert
%------------
Uc0=0;       % Kondensatorspannung [V]

% Zeitbereich
%------------
t_end=5*Tau; % Vielfaches von Tau um das Einschwingen zu sehen
dt=T/100;    % dt muss viel kleiner sein als die Periodendauer
             % (nach dem Abtast-Theorem nur T/2 aber das ist viel zu grob) 

t=0:dt:t_end;% Zeitvektor    [s]

[~,Uc] = ode45(@dgl_RC_1,t,Uc0,[],para);  % ode45 ohne options

figure
 plot(t,Uc);
 grid; xlabel('t [s]'); ylabel('U_C [V]')
 title('R-C an einer Wechselspannung mit ode45')

%% Lokale function für die Kondensatorspannung
%---------------------------------------------
function dUc_dt=dgl_RC_1(t,Uc,para)
                                             
R=para(1);              % Widerstand            [Ohm]
C=para(2);              % Kapazität             [F]
Uo=para(3);             % Versorgungsspannung   [V]
f=para(4);              % Versorgungsspannung   [Hz]

U=Uo*sin(2*pi*f*t);     % Sinusförmige Eingangsspannung     [V]

dUc_dt=(U-Uc)/(R*C);    % Die DGL

end