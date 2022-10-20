%% m-file ueb_DFT
%
% Dieser m-file beinhaltet den Rahmen f�r die �bung in der Vorlesung
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
clearvars;  % workspace l�schen


% Verschiedene Testfunktionen
%----------------------------
fs=44100;           % Abtastfrequenz                        [Hz]
                    % h�chste Frequenz im Signal ist fs/2
Ts=1/fs;            % Abtastzeit                            [s]
T=0.2;              % Signaldauer                           [s]
fmin=1/T;           % kleinste Frequenz im Signal           [Hz]
t=0:Ts:T;           % Zeitvektor                            [s]
N=length(t);        % L�nge des Zeitvektors
N2=floor(N/2);      % halbe L�nge des Zeitvektors
f=100;              % Frequenz                              [Hz]
w1=2*pi*f;          % Kreisfrequenzen                       [1/s]

y1=sin(w1*t)+2*sin(2*w1*t)+3*sin(5*w1*t);   % Addition von Sin-Schwingungen
y2= sin(10*w1*t).*sin(w1*t);                % Amplitudenmodulation
y3=sin(t.*w1+0.3*cos(5*w1*t));              % Phasenmodulation

% Hier soll die Berechnung der DFT f�r die 3 Testsignale wahlweise durchgef�hrt
% werden.

% Wie berechnet sich die Frequenz-Achse f�r das Spektrum?
f_spektrum=...;  % Frequenzachse f�r das Frequenzspektrum    [Hz]

% Hier soll der Aufruf f�r die Berechnung f�r die DFT eingef�gt werden
% 
% Was liefert die function DFT_1 zur�ck?
% Wie m�ssen diese Werte noch "bearbeitet" werden, damit man das Spektrum
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
    
% Hier soll die Berechnung der Diskreten Fourier Transformation eingef�gt
% werden
function ...=DFT_1(y)

end