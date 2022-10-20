%% m-file ueb_FFT
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

    
     f_spektrum=1/T*(1:N);  % Frequenzachse für das Frequenzspektrum    [Hz]
     %F1=Ts*abs(DFT_1(y1));    % Spektrum in einem Schritt
     F1=Ts*abs(fft(y1));    % Spektrum in einem Schritt
   
     figure; 
     subplot(2,1,1)
       plot(t,y1,'r'); 
       grid; xlabel('t [s]'); ylabel('y_1')
     subplot(2,1,2)
       semilogx(f_spektrum(1:N2),F1(1:N2)); 
       grid; xlabel('f [Hz]'); ylabel('F_1');
    
  
function A=DFT_1(y)

N=length(y);        % Länge des Wertevektors
A=zeros(1,N);       % komplexe Werte der DFT

for n=1:N           % Schleife über alle Frequenzen
    for m=1:N       % Schleife über alle Mess-Werte
        A(n)=A(n)+y(m)*exp(-1i*2*pi/N*(n-1)*(m-1));
    end
end    
end