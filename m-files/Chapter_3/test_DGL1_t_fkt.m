% test_DGL_t_fkt.m 
%
% DGLs erster Ordnung (RC-Glied) mit verschieden Eingangsspannungen.
% Lösungen mit ode45
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

Fall=3;     % 1: RC mit PWM Spannungsquelle
            % 2: RC mit Sinus-Spannung
            % 3: RC mit Dreieck-Spannung
            % 4: RC mit Sweep-Spannung

%% System Paramenter
R=10;       % Widerstand    [Ohm]
C=0.01;     % Kapazität     [F]
Tau=R*C;    % Zeitkonstante [s]

%% Amplitude Versorgungsspannung
Ua=10;      % Amplitude     [V]

%% Anfangswert
Uc0=0;

%% Zeitbereich 
t_start=0; t_end=8*Tau;
dt_grob=Tau/100;
N=floor((t_end-t_start)/dt_grob);
t=linspace(t_start,t_end,N);

%% optionen für ode45
tol = 1.e-10;	% Tolerance
options= odeset('RelTol', tol);

if Fall==1
%% 1: RC mit PWM-Quelle
%----------------------
Ueberschrift='PWM';

% Störfunktion Versorgungsspannung als PWM
f_pwm=5/Tau;          % PWM Frequenz  [Hz]
DutyCycle=0.5;        % Duty Cycle    [1/100]

% Parameter Zusammenfassung
para=[R C Ua f_pwm DutyCycle];

Upower=Ua*pwm_t(t,f_pwm,DutyCycle);

% Lösung mit ode45
%-----------------

[~,Uc] = ode45(@dgl_RC_PWM,t,Uc0,options,para);  % ode45 ohne options

i_RC=zeros(1,N);
for i=1:N
    i_RC(i)=C*dgl_RC_PWM(t(i),Uc(i),para); %C*diff(Uc)/(t(2)-t(1))
end    
 
elseif Fall==2
%% 2: RC mit Sinus-Spannung
Ueberschrift='Sinus';
% Sinus
 f_sin=1/(2*pi*Tau);
 w_sin=2*pi*f_sin;  % Winkelgeschwindigkeit [1/s]
 Phi=0*pi/180;     % Phasenverschiebung    [rad] 20
 
% Parameter Zusammenfassung
para=[R C Ua w_sin Phi];

Upower=Ua*sin(w_sin*t-Phi);

% Lösung mit ode45
%-----------------
[~,Uc] = ode45(@dgl_RC_sin,t,Uc0,options,para);  % ode45 ohne options

% Berechnung des Stromes aus i=C*duc/dt
i_RC=zeros(1,N);
for i=1:N
    i_RC(i)=C*dgl_RC_sin(t(i),Uc(i),para);
end    

elseif Fall==3 
%% 3: RC mit Dreieck-Spannung
Ueberschrift='Dreieck';
% Dreieck
 f_tri=0.5/Tau;
 w_tri=2*pi*f_tri;  % Winkelgeschwindigkeit [1/s]
 Phi=20*pi/180;     % Phasenverschiebung    [rad]
 
% Parameter Zusammenfassung
para=[R C Ua w_tri Phi];

Upower=Ua*asin(sin(w_tri*t-Phi));

% Lösung mit ode45
%-----------------
[~,Uc] = ode45(@dgl_RC_tri,t,Uc0,options,para);  % ode45 ohne options

% Berechnung des Stromes aus i=C*duc/dt
i_RC=zeros(1,N);
for i=1:N
    i_RC(i)=C*dgl_RC_tri(t(i),Uc(i),para);
end    

elseif Fall==4
%% 4: RC linear mit sweep
%------------------------
Ueberschrift='Sweep';
% Parameter Zusammenfassung

f0=0;       % Anfangsfrequenz Sweep
f1=2/Tau;   % Endfrequenz Sweep

para=[R C Ua f0 f1 t_start t_end];

Upower=Ua*lin_sweep(t,f0,f1,t_start,t_end);

% Lösung mit ode45
%-----------------

options= odeset('RelTol', tol);
[~,Uc] = ode45(@dgl_RC_sweep,t,Uc0,options,para);  % ode45 ohne options

% Berechnung des Stromes aus i=C*duc/dt
i_RC=zeros(1,N);
for i=1:N
    i_RC(i)=C*dgl_RC_sweep(t(i),Uc(i),para);
end    

end

%% Ausgabe

figure
    plot(t,Upower,'b',t,Uc,'r');
    grid; xlabel('t [s]'); ylabel('U_0;  U_C [V]')
    title(Ueberschrift);
figure
   subplot(2,1,1)
    plot(t,Uc,'b');
    grid; xlabel('t [s]'); ylabel('U_C [V]')
    title(Ueberschrift);
   subplot(2,1,2)
    plot(t,i_RC,'r');
    grid; xlabel('t [s]'); ylabel('i_C [V]')