% test_DGL1_0.m 
%
% Einfache Umsetzung des Streckenzugverfahrens nach Euler
%
% DGL: RC-Reihenschaltung an einer Wechselspannung 
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%
% Datum:    2020-05-25
%           2021-11-05 Auf Euler vorw�rts zur�ckgesetzt
%
% �nderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace l�schen.

%% System Parameter
R=1e3;      % Widerstand    [Ohm]
C=0.15e-3;  % Kapazit�t     [F]
Tau=R*C;    % Zeitkonstante [s]

%% St�rfunktion
Uo=5;      % Versorgungsspannung   [V]
w=2*pi/0.1; % Kreisfrequenz        [1/s]

%% Anfangswert
uc0=8;      % Spannung am Kondensator zum Zeitpunkt t=0

%% Zeitbereich 
dt=Tau/100;
t=0:dt:1;        % Zeitvektor    [s]
n=length(t);   % Anzahl Werte

%% Euler Vorw�rts
%----------------
uc=zeros(1,n);  % initialisieren 
uc(1)=uc0;      % Anfangswert
  for i=2:n
      uc(i)=uc(i-1)+(-uc(i-1)/Tau+Uo/Tau*sin(w*t(i-1)))*dt;  
  end
 
%% Ausgabe
%---------
figure
    plot(t,uc,'b',t,Uo*sin(w*t),'g')
    xlabel(' t[s]')
    ylabel('u_C [V]')
    grid