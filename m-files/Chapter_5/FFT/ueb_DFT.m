%% m-file ueb_DFT
%
% Dieser m-file beinhaltet den Rahmen für die Übung in der Vorlesung
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2021 erstellt.
%
% Datum:    2021-11-25
%
%
% siehe auch:
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen


% Verschiedene Testfunktionen
%----------------------------
fs=44100;           % Abtastfrequenz                        [Hz]
                    % höchste Frequenz im Signal ist fs/2
Ts=1/fs;            % Abtastzeit                            [s]
T=0.2;              % Signaldauer                           [s]
fmin=1/T;           % kleinste Frequenz im Signal           [Hz]
t=0:Ts:T;           % Zeitvektor                            [s]
N=length(t);        % Länge des Zeitvektors
N2=floor(N/2);      % halbe Länge des Zeitvektors
f=100;              % Frequenz                              [Hz]
w1=2*pi*f;          % Kreisfrequenzen                       [1/s]

y1=sin(w1*t)+2*sin(2*w1*t)+3*sin(5*w1*t);   % Addition von Sin-Schwingungen
y2= sin(10*w1*t).*sin(w1*t);                % Amplitudenmodulation
y3=sin(t.*w1+0.3*cos(5*w1*t));              % Phasenmodulation

% Hier soll die Berechnung der DFT für die 3 Testsignale wahlweise durchgeführt
% werden.

% Wie berechnet sich die Frequenz-Achse für das Spektrum?
f_spektrum=...;  % Frequenzachse für das Frequenzspektrum    [Hz]

% Hier soll der Aufruf für die Berechnung für die DFT eingefügt werden
% 
% Was liefert die function DFT_1 zurück?
% Wie müssen diese Werte noch "bearbeitet" werden, damit man das Spektrum
% F1(f_spektrum) darstellen kann?

y=y1; % Auswahl der Funktion von Hand y=...

F=...;    % Spektrum der Funktion y in einem Schritt DFT_1(y)
    
   
     figure; 
     subplot(2,1,1)
       plot(t,y,'r'); 
       grid; xlabel('t [s]'); ylabel('y')
     subplot(2,1,2)
       semilogx(f_spektrum(1:N2),F(1:N2)); 
       grid; xlabel('f [Hz]'); ylabel('F');
    
% Hier soll die Berechnung der Diskreten Fourier Transformation eingefügt
% werden
function ...=DFT_1(y)

end