% test_FFT_Tiefpass.m
%
% Ein passiver Tiefpass (RC-Glied) wird an einer Konstantspannung 
% betrieben. Diese Konstantspannung wird mit einer Zufallsspannung
% überlagert(Power Density Funktion).
% Die Eingangsspannung wird als Vektor an die dgl function übergeben und in
% dieser function werden die benötigte Zwischenwerte durch Interpolation
% erzeugt (siehe matlab function interp1)

% Die Spektren der Ausgangsspannungen mit und ohne überlagerter Eingangs-
% spannung werden berechnet. Durch Veränderung der Ladespannung am
% Kondensator zum Zeitpunkt t=0 können verschiedene Fälle untersucht
% werden.
% 
% Lösungen mit ode45
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-05-25
%
% Änderung: 2018-07-18 U_ein_yn eingefügt
%
% siehe auch: dlg_RC_rnd
%--------------------------------------------------------------------------

close all;  % Alle plots schliessen
clearvars;  % workspace löschen.

% Signal mit und ohne Eingangsspannung
U_ein_yn=0; % 0: mit Eingangsspannung (Einschalt-Sprung)
            % 1: ohne Einschalt-Sprung (konstanter Endwert)

%% System Paramenter
R=1;            % Widerstand            [Ohm]
C=0.001/(2*pi); % Kapazität             [F]
Tau=R*C;        % Zeitkonstante         [s]
w_g=1/Tau;      % Grenz-Kreisfrequenz   [1/s]
f_g=w_g/(2*pi); % Grenzfrequenz         [Hz]

%% Amplituden der Versorgungsspannung und Zeitbereich
Uconst=1;                % Spannungssprung                           [V]
U_rnd_max=0.05*Uconst;   % max Spannung der Random Spannungsquelle   [V]

Nt=20000;                 % Anzahl Zeitwerte
tend=0.1;                 % Zeitbereich                              [s]

% Random Spannung
f_rnd_max=10*f_g;
Dfr	    = [1, f_rnd_max];   % Spektraldichte vorgeben  
DPSD	= [1, 1];
nofp    = 400;              % Anzahl Interpolationspunkte

[t,A_psd] = Psd_rnd(Dfr,DPSD,nofp,Nt,tend);

U_rnd=U_rnd_max/max(abs(A_psd))*A_psd;  % Die Amplitude der Random-Spannung
                                        % auf U_rnd_max skalieren
% Zusammengesetzte Spannung
ta=t;
Ua=Uconst*ones(size(t'));   % ohne Rnd-Spannung
Ua_rnd=U_rnd+Ua;        % mit Rnd-Spannung

 figure
  subplot(2,2,1)
    semilogx(Dfr,DPSD,'b','linewidth',2);
    title('Leistungsdichtespektrum der RND-Spannung');
    ylabel('A [V²/Hz]')  
    xlabel('f [Hz]')
    grid;
  subplot(2,2,2)
    plot(t,A_psd,'r');
    title('Zugehöriges Zeitsignal ');
    ylabel('A [V]') 
    xlabel('t [s]')
    grid;
subplot(2,1,2)
    plot(t,Ua_rnd,'r',[0 t],[0 Ua'],'b');
    title('Gesamtspannung ');
    ylabel('U_a [V]') 
    xlabel('t [s]')
    grid;
    set(gca,'ylim',[0 1.05*max(Ua_rnd)]);  
    
%% Anfangswert
if U_ein_yn==0
    Ua0=0;        % hiermit bekommt man auch ein Ergebnis ohne rnd-Spannung!
else
    Ua0=Uconst;   % hiermit bekommt man kein Ergebnis ohne rnd-Spannung!
end
%% Ausgangsspannung mit ode 45
% optionen für ode45
tol = 1.e-10;	% Tolerance
options= odeset('RelTol', tol);

% Lösung mit ode45
%-----------------

% Die Übergabe der DGL muss in einem String erfolgen, wenn die Parameter
% einzeln angehängt werden!!! Matlab bug???

[~,Uc]      = ode45('dgl_RC_rnd',t,Ua0,options,R,C,ta,Ua);    % ohne Random-Spannung
[te,Uc_rnd] = ode45('dgl_RC_rnd',t,Ua0,options,R,C,ta,Ua_rnd);% mit  Random-Spannung 
    
%% FFT von Uc und Uc_rnd

                        % höchste Frequenz im Signal ist fs/2
Ts=t(2)-t(1);           % Abtastzeit                            [s]
fs=1/Ts;                % Abtastfrequenz                        [Hz]
T=max(t);               % Signaldauer                           [s]
fmin=1/T;               % kleinste Frequenz im Signal           [Hz]

N=length(t);            % Länge des Zeitvektors
N2=floor(N/2);          % halbe Länge des Zeitvektors

f_spektrum=1/T*(1:N);   % Frequenzachse für das Frequenzspektrum    [Hz]

 F1=Ts*abs(fft(Uc-mean(Uc)));               % Spektren der mittelwertfreien 
 F1_rnd=Ts*abs(fft(Uc_rnd-mean(Uc_rnd)));   % Signalen in einem Schritt 
 F1_norm=20*log10(F1/max(F1));              % Normierte Spektren [dB]
 F1_rnd_norm=20*log10(F1_rnd/max(F1_rnd)); 
 
 [~, N_rnd]=min(abs(f_spektrum-f_rnd_max)); % Rnd-Spektrum nur bis zur
                                            % eingespeisten Frequenz
                                            % anzeigen.
  figure 
  subplot(2,2,1)
    plot(t,Ua);
    grid; xlabel('t [s]'); ylabel('U_a')
     title('ohne Rnd-Spannung')
  subplot(2,2,2)
    semilogx(f_spektrum(2:N2), F1_norm(2:N2));
    grid; xlabel('f [Hz]'); ylabel('F_{Uc}');
  subplot(2,2,3)
    plot(t,Ua_rnd,'r',[0 t],[0 Ua'],'b');
    grid; xlabel('t [s]'); ylabel('U_{a rnd}')
     title('mit Rnd-Spannung')
  subplot(2,2,4)
    semilogx(f_spektrum(2:N_rnd), F1_rnd_norm(2:N_rnd));
    grid; xlabel('f [Hz]'); ylabel('F_{Uc Rnd}');  
    
   