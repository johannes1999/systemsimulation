% m-file: test_fourier_vorl.m
%
% Header für Hausübungen (hier schon teilweise für HÜ 0 ausgelfüllt) 
%
% Erklärung
%
% Es werden die reellen Fourier-Koeffizienten einer bekannten Fourier-Reihe 
% berechnet und die zugehörige Zeitfunktion dargestellt. Die Berechnung
% der Zeitfunktion erfolgt mittels der externen function fourier_series.m
%
% 
% Input:    Werte werden direkt in diesem File zugewiesen
% Output:   Grafik-Ausgabe in diesem File
%
% Beispiel: xxx
%
% Autor:	xxx
%
% Datum:    xxx
%
% Änderung: xxx
%
% Benötigte eingene externe functions: fourier_series_01.m
%
% siehe auch: xxx
%
%--------------------------------------------------------------------------         

close all;
clearvars;

Beispiel = 3;   % 1: Sägezahn
                % 2: Rechteck
                % 3: e-Funktion
                % 4: full bridge rectified
                % 5: half bridge rectified



N_koeff=1000;   % Anzahl Fourier Koeffizienten 
T=2*pi;        % Periodendauer 
n=1:N_koeff;   % Vektor mit n=1,2,3,.. 

%zu bestimmen
A=0;                % Faktor für die Summe 
a0=0;               % Doppelter Mittelwert 
a=zeros(1,N_koeff); % Cosinus Fourier-Koeffizienten
b=zeros(1,N_koeff); % Sinus Fourier-Koeffizienten

% Zeitwerte für die periodische Funktion 
N_werte=4000;    % Anzahl der zu berechnenden Funktionswerte 
t_start=0;      % Startwert 
t_end=4*pi;    % Endwert 
t=linspace(t_start,t_end,N_werte); % Zeitwerte

%Koeffizienten erzeugen
switch Beispiel
    case 1 % Sägezahn
        A=-1/pi; 
        a0=1;
        a=zeros(1,N_koeff);
        %a(1)=a0;
        b=(1./n);
    case 2 % Rechteck
        A=4/pi;
        a0=0;
        b=(1./n).*ones(1, N_koeff);
        b(2:2:end)=0; %jeder zweite wert bis zum ende ist 0
        a=zeros(1,N_koeff);
    case 3 % e-Fkt
        e=exp(1); %eulersche zahl 
        A=((1-e^(-2*pi))/pi);
        a0 = A;
        a=(1./((n.*n)+1)).*ones(1, N_koeff);
        a(1)=a0;
        b=(n./((n.*n)+1)).*ones(1, N_koeff);
    case 4 % full bridge rectified
    case 5 % half bridge rectified
end







y= fourier_series_fun_01(a0,a,b,T,A,t) % Funktionswerte

amplitudenspektrum = A*sqrt(a.*a+b.*b);
amplitudenspektrum = abs(amplitudenspektrum); % ich will nur positive stems, weil das schöner "ist"


% Funktion Darstellen figure; plot .... usw.
figure;
subplot(2,1,1)
plot(t,y,'r')
subplot(2,1,2)
stems = N_koeff; %drucke nur die ersten zehn stems
stem(n(1:stems), amplitudenspektrum(1:stems), 'b')
% plot .... usw.