% test_DGL_t_fkt_1.m 
%
% DGLs erster Ordnung (RC-Glied) mit verschieden Eingangsspannungen
% 
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-05-11
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen.

Fall=1;     % 1: RC mit PWM Spannungsquelle
            % 2: RC mit Sinus-Spannung
            % 3: RC mit Dreieck-Spannung

if Fall==1
% 1: RC mit PWM-Quelle
%---------------------
% System Paramenter
R=10;       % Widerstand    [Ohm]
C=0.01;     % Kapazität     [F]
Tau=R*C;    % Zeitkonstante [s]

% Störfunktion Versorgungsspannung als PWM
f_pwm=5/Tau;          % PWM Frequenz  [Hz]
DutyCycle=0.5;          % Duty Cycle    [1/100]
Ua=10;                  % Amplitude     [V]

% Parameter Zusammenfassung
para=[R C Ua f_pwm DutyCycle];

% Anfangswert
Uc0=0;
% Zeitbereich 
t_start=0; t_end=8*Tau;
dt_grob=Tau/100;
N=floor((t_end-t_start)/dt_grob);
t=linspace(t_start,t_end,N);

% Lösung mit ode45
%-----------------

% optionen für ode45
tol = 1.e-10;	% Tolerance
options= odeset('RelTol', tol);
[~,y2] = ode45(@dgl_RC_PWM,t,Uc0,options,para);  % ode45 ohne options
    
% Berechnung des Stromes aus i=C*duc/dt
Uc=y2;
i_RC=zeros(1,N);
for i=1:N
    i_RC(i)=C*dgl_RC_Ua(t(i),Uc(i),para);
end    
   figure
   subplot(2,1,1)
    plot(t,Uc,'b');
    grid; xlabel('t [s]'); ylabel('U_C [V]')
   subplot(2,1,2)
    plot(t,i_RC,'r');
    grid; xlabel('t [s]'); ylabel('i_C [V]')
 
elseif Fall==2
% 2: RC mit Sinus-Spannung

elseif Fall==3 
% 3: RC mit Dreieck-Spannung

end
