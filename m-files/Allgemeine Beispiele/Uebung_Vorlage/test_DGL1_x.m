% test_DGL1_2.m 
%
% Es werden verschiedene L�sungsalgorithmen zur L�sung von DGLs erster
% Ordnung an verschiedenen Beispielen gezeigt. Dieser m-file ist zum
% testen!!!!!!!
% 
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-14
%
% �nderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace l�schen.


% 1: RC-Schaltung mit linearen Komponenten und konstanter Spannungsquelle
%------------------------------------------------------------------------
% System Paramenter
R=10;       % Widerstand    [Ohm]
C=0.01;     % Kapazit�t     [F]
Tau=R*C;    % Zeitkonstante [s]

% St�rfunktion
Uo=10;      % Versorgungsspannung   [V]

% Zeitbereich 
t_start=0; t_end=5*Tau;
dt_grob=Tau/100;
N=floor((t_end-t_start)/dt_grob);   % Anzahl Werte
t=linspace(t_start,t_end,N);        % Zeitvektor    [s]

% DGL
f=@(Uc,Ua,Tau) (-Uc+Ua)/Tau;

% Anfangswert
Uc0=0;      % Spannung am Kondensator zum Zeitpunkt t=0

% L�sungsverfahren

n=length(t);        % L�nge des Zeitvektors
dt=t(2)-t(1);       % Schrittweite
uc=zeros(size(t));  % Initialisierung des Ausgabevektors

uc(1)=Uc0;          % Anfangsbedingung

fall=3;             % 1: Euler Vorw�rts
                    % 2: Euler R�ckw�rts
                    % 3: Runge Kutta 4ter Ordnung     
if fall==1
% Euler Vorw�rts
%---------------
Ueberschrift='Euler Vorw�rts';
   



elseif fall==2    
% Euler R�ckw�rts 
%----------------
Ueberschrift='Euler R�ckw�rts';
   


elseif fall==3    
% Runge Kutta 4ter Ordnung 
%-------------------------
Ueberschrift='Runge Kutta 4ter Ordnung';
    


    
end

figure
plot(t,uc);
xlabel(' t[s]')
ylabel('u_C [V]')
title(Ueberschrift)
grid