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

Beispiel = 5;   % 1: Sägezahn
                % 2: Rechteck
                % 3: e-Funktion
                % 4: full bridge rectified
                % 5: half bridge rectified

Opt = 3;        % Optionen für interne Plots der Funktion
                % 0: kein plot
                % 1: plot funktion
                % 2: plot neue Anteile
                % 3: plot funktion nach jeden cyclus 



N_koeff=100;   % Anzahl Fourier Koeffizienten 
T=2*pi;        % Periodendauer 
n=1:N_koeff;   % Vektor mit n=1,2,3,.. 

%zu bestimmen
A=0;                % Faktor für die Summe 
a0=0;               % Doppelter Mittelwert 
a=zeros(1,N_koeff); % Cosinus Fourier-Koeffizienten
b=zeros(1,N_koeff); % Sinus Fourier-Koeffizienten

% Zeitwerte für die periodische Funktion 
N_werte=400;    % Anzahl der zu berechnenden Funktionswerte 
t_start=0;      % Startwert 
t_end=4*pi;    % Endwert 
t=linspace(t_start,t_end,N_werte); % Zeitwerte

%Koeffizienten erzeugen
switch Beispiel
    case 1 % Sägezahn
        A=-1/pi; 
        a0=1;
        a=zeros(1,N_koeff);
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
        b=(n./((n.*n)+1)).*ones(1, N_koeff);
    case 4 % full bridge rectified
        A = 4/pi;
        a0 = 4/pi;
        a=-1./((n.*n)-1);
        a(1:2:end)=0;
        b = zeros(1, N_koeff);
    case 5 % half bridge rectified
        A = 2/pi;
        a0 = 2/pi;
        a1 = pi/4;
        a = (-sin((pi/2)*(1+n)))./((n.*n)-1);
        a(3:2:end)=0;
        a(1) = a1;
        disp(a)
        b = zeros(1, N_koeff);
end







y= fourier_series_fun_02(a0,a,b,T,A,t,Opt); % Funktionswerte

amplitudenspektrum = A*sqrt(a.*a+b.*b);
amplitudenspektrum = abs(amplitudenspektrum); % ich will nur positive stems, weil das schöner "ist"


% Funktion Darstellen figure; plot .... usw.
if(y~=0)
    figure;
    subplot(2,1,1)
    plot(t,y,'r')
    subplot(2,1,2)
    stems = N_koeff; %drucke nur die ersten zehn stems
    stem(n(1:stems), amplitudenspektrum(1:stems), 'b')
end
% plot .... usw.