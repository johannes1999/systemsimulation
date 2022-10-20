% Ueb_Spannungsteiler.m   	
%
% Übung zu den Verteilungsfuktionen 
%  Übungsbeispiel Spannungsverteilung
% 		
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung strukturelle und
%           funktionale Systemsimulation SS 2021 erstellt.
%
% Datum:    2021-12-03
%
% Änderung: 
%
% siehe auch: n_bins: Anzahl von Klassen in Abhängkeit der Anzahl Werte
%----------------------------------------------------------------------

clearvars;
close all;

% Benötigte Matlab Standard-functions für Toleranz-Rechnungen
% -----------------------------------------------------------
 N=1e6;                     % Anzahl Werte
 AnzKl = n_bins(N);	        % Anzahl Klassen
 nSigma=3;

% R1
%---
R1_nom=5000;                    % R1 nominal                [Ohm]
R1_tol=5/100;                   % Toleranz                  [1/100]
R1_std=R1_nom*R1_tol/nSigma;    % R1 standardabweichung     [Ohm]

% R2
%---
R2_nom=15000;                    % R2 nominal   [Ohm]
R2_tol=5/100;                    % Toleranz     [1/100]
R2_std=R2_nom*R2_tol/nSigma;     % R2 nominal   [Ohm]

% U0
%---
U0_nom=10;                       % U0 nominal  [V]
U0_tol=10/100;                   % Toleranz    [1/100]
U0_std=U0_nom*U0_tol/nSigma;     % U0 nominal  [V]

%----------------------------------------------------------
% Systemparameter
 R1=R1_nom+R1_std*randn(1,N);% Standard Normalverteilt
 R2=R2_nom+R2_std*randn(1,N);% Standard Normalverteilt
% Eingabewerte 
 U0=U0_nom+U0_std*randn(1,N);% Standard Normalverteilt

%--------------------------------------------------------- 
% Ausgabewert
U1=R1./(R1+R2).*U0; % Spannung am Widerstand R1


 figure
 subplot(2,2,1)
    hist(R1,AnzKl)
    grid;
    xlabel(['R1 mean=' num2str(mean(R1)) '  std=' num2str(std(R1))] )
    ylabel('rel H');
    title('Eingabewerte');
subplot(2,2,2)
   hist(R2,AnzKl)
    grid;
    xlabel(['R2 mean=' num2str(mean(R2)) '  std=' num2str(std(R2))] )
    ylabel('rel H');
 subplot(2,2,3)
    hist(U0,AnzKl)
    grid;
   xlabel(['U0 mean=' num2str(mean(U0)) '  std=' num2str(std(U0))] )
    ylabel('rel H');
    title('Eingabewert');   
 subplot(2,2,4)
    hist(U1,AnzKl)
    grid;
    xlabel(['U1 mean=' num2str(mean(U1)) '  std=' num2str(std(U1))] )
    ylabel('rel H');
    title('Ausgabewert');      
