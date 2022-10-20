% m-file test_fminsearch
%
% Erkl�rung 
% Man hat �fter den Fall dass die Struktur eine Funktion bekannt ist und
% einigeDatenpunkte zur Verf�gung stehen. Die Parameter der Funktion sollen
% ermittelt werden.

% Beispiel:
%  Die Ladefunktion u(t)=Uo*(1-exp(-t/Tau) hat zwei Parameter Uo und Tau. 
%  Selbst mit zwei Messpunkten P1(t1|u1) und P2(t2|u2) lassen sich die
%  Parameter nicht exakt berechnen. 
%
%  Mit der function fminsearch k�nnen die Parameter bestimmt werden.
%  Es werden allerdings Startwerte ben�tigt.
%
%  
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    4-04-2019
%
% �nderung: 13-12-2021 in test_fminsearch_1_0 ge�ndert
%
% siehe auch: 
%
%--------------------------------------------------------------------------
clearvars;
close all;

 %% Ladekurve
 %----------
    
 % Wir haben eine Ladekurve in 3 Punkten (t_m|uc_m) gemessen.
 % Wir erwarten einen Verlauf nach folgender Gleichung: 
 % Uc=Uo*(1-exp(-t/Tau))
 % Wie sind Uo und Tau zu w�hlen, damit wir den besten Fit bekommen?
 % Mit der fminsearch function suchen wir diesen best Fit mit dem Ansatz
 % der minimalen Fehlerquadrate: Also die Summe �ber dieDifferenz zwischen einer 
 % berechneten Kurve und den Messwerten Me�werten und das Ganze zum Quadrat.
 % sum((Uc(t_m)-ucm).^2).
 % die fminsearch function sucht ein minimum durch variation von den
 % Parametern Uo und Tau. F�r Uo und Tau m�ssen wir Anfangswerte festlegen-

 % Messwerte 
 t_m =[ 1 3   5 ];
 uc_m=[6 9.5 9.9];    
   
    % Parameter-Ermittlung mit fminsearch
    %------------------------------------

    % Start-Wert f�r fminsearch
    po=[1 1];    % p=[Uo Tau]

    p=fminsearch(@LadeFkt_f_min_fun,po,[],t_m,uc_m);

    Uo_est=p(1);                            % Ermittelte Parameter
    Tau_est=p(2);                           % 
    t=linspace(0,5*Tau_est,400); 
    u_c_est=Uo_est*(1-exp(-t/Tau_est));     % Funktion mit den ermittelten
                                        % Parametern
    figure;
    plot(t_m,uc_m,'* r',t,u_c_est,'b')
    xlabel('t [s]')
    ylabel('Messwerte, fit-Funktion')
    title('Ausgleichsfunktion mit fminsearch')
    grid
    
 
%% function LadeFkt_f_min_fun
%----------------------------
% Ermittlung der Parameter Uo und Tau
% mit dem Minimum der minimalen Fehlerquadrate.

function y=LadeFkt_f_min_fun(p,t_mess,Uc_mess)
Uo=p(1);
Tau=p(2);

Uc_est=Uo*(1-exp(-t_mess/Tau)); % Vorgabe der Funktionsstruktur

y=sum((Uc_est-Uc_mess).^2);     % Summe der Fehlerquadrate
end

