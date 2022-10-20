% SpannungsTeiler.m	
%
% Berechnet die Streuung der Ausgangsspannung eines doppleten Spannungs-
% teilers.
% 		
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-06-30
%
% Änderung:  18-07 2018 Formel für Ausgangsspannung nach Skript
%
% siehe auch: 
%--------------------------------------------------------------------------

clearvars;
close all;

% Beispiel rnd_vect doppelter Spannungsteiler
%--------------------------------------------

n_s=1e5;                        % Anzahl Werte
AnzKl = n_bins(n_s);            % Anzahl Klassen
nSigma=3;                       % Die Toleranzwerte entsprechen n*Sigama

%distribution='normal';          % Umschalten durch auskommentieren
distribution='uniform';

% R1
%---
R1nom=4700;                     % R1 nominal                [Ohm]
R1_tol=10/100;                  % Toleranz                  [1/100]
R1std=R1nom*R1_tol/nSigma;      % R1 standardabweichung     [Ohm]

% R2
%---
R2nom=4700;                     % R2 nominal   [Ohm]
R2_tol=10/100;                    % Toleranz     [1/100]
R2std=R2nom*R2_tol/nSigma;       % R2 nominal   [Ohm]

% R3
%---
R3nom=4700;                     % R3 nominal   [Ohm]
R3_tol=5/100;                    % Toleranz     [1/100]
R3std=R3nom*R3_tol/nSigma;       % R3 nominal   [Ohm]

% R4
%---
R4nom=7200;                     % R4 nominal   [Ohm]
R4_tol=5/100;                    % Toleranz     [1/100]
R4std=R4nom*R4_tol/nSigma;       % R4 nominal   [Ohm]

% Uin
%---
Uin_nom=13;                         % U0 nominal  [V]
Uin_tol=5/100;                      % Toleranz    [1/100]
Uin_std=Uin_nom*Uin_tol/nSigma;     % U0 nominal  [V]

switch distribution % Verschieden verteilungsarten
    case 'normal'
        R1=rnd_vect(n_s,'normal',[R1nom R1std],[],[]);
        R2=rnd_vect(n_s,'normal',[R2nom R2std],[],[]);
        R3=rnd_vect(n_s,'normal',[R3nom R3std],[],[]);
        R4=rnd_vect(n_s,'normal',[R4nom R4std],[],[]);
        Uin=rnd_vect(n_s,'normal',[Uin_nom Uin_std],[],[]);
    case 'uniform'
        R1=rnd_vect(n_s,'uniform',[R1nom R1nom*R1_tol],[],[]);
        R2=rnd_vect(n_s,'uniform',[R2nom R2nom*R2_tol],[],[]);
        R3=rnd_vect(n_s,'uniform',[R3nom R3nom*R3_tol],[],[]);
        R4=rnd_vect(n_s,'uniform',[R4nom R4nom*R4_tol],[],[]);
        Uin=rnd_vect(n_s,'uniform',[Uin_nom Uin_nom*Uin_tol],[],[]);
end

Uout=R2.*R4./(R1.*R2+(R1+R2).*(R3+R4)).*Uin; % Ausgangsspannung

 figure % Systemparameter: Widerstände
 subplot(2,2,1);
    xs_hist_c(R1*1e-3,AnzKl,'R_1','System Parameter R_1','[kOhm]','b',1)
 subplot(2,2,2);
    xs_hist_c(R2*1e-3,AnzKl,'R_2','System Parameter R_2','[kOhm]','b',1)
 subplot(2,2,3);
    xs_hist_c(R3*1e-3,AnzKl,'R_3','System Parameter R_3','[kOhm]','b',1)
 subplot(2,2,4);
    xs_hist_c(R4*1e-3,AnzKl,'R_4','System Parameter R_4','[kOhm]','b',1)   
 
 figure % Ein- und Ausgangsgrößen   
 subplot(2,2,1);  
    xs_hist_c(Uin,AnzKl,'U_{in}','Eingangsgröße U_{in}','[V]','r',1)
 subplot(2,2,2);
    xs_hist_c(Uout,AnzKl,'U_{out}','Ausgangsgröße U_{out}','[V]','g',1)       

 figure
   pfpareto(Uout,' ',[],[],'U_{out} ',0,0,R1,'R_1',R2,'R_2',R3,'R_3',R4,'R_4',Uin,'U_{in}');

