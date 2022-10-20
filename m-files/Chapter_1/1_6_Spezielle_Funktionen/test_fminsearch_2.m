% m-file test_fminsearch_2
%
% Zweites Beispiel
%
% Erklärung 
% Man hat öfter den Fall, dass die Struktur eine Funktion bekannt ist und
% einige Datenpunkte zur Verfügung stehen. Die Parameter der Funktion sollen
% ermittelt werden.
% Beispiel:
% Die Schwingung eines Biegebalkens wurde aufgenommen. Der Zeitverlauf der
% Amplitude entspricht einer gedämpften Schwingung:
% s(t)=A*sin(wo*t-Phi_0)*exp(-t/Tau)
% Der Verlauf ist bestimmt durch die Amplitude A, die Eigenfrequenz wo,
% die Phasenverschiebung Phi_0 und der Zeitkonstanten Tau.
%
%  Mit der function fminsearch können diese Parameter bestimmt werden.
%  Es werden allerdings Startwerte benötigt.
% 
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2019 erstellt.
%
% Datum:    1-05-2019
%
% Änderung: 
%
% siehe auch: test_fminsearch
%
%--------------------------------------------------------------------------
clearvars;
close all;
 % Daten aus mat-file
     data_path='C:\Users\Horst\Documents\01_Vorlesungen\01_Studium Plus\07_System_Simulation\05_Matlab_work\Chapter_1\1_6_Spezielle_Funktionen\';
     mat_File='Daten_fuer_fminsearch_2';
    f_p_mat=[data_path mat_File]; % Pfad mit Dateiname
    load(f_p_mat,'t1', 's1');

   
 %% Erster Datensatz auswerten
 %----------------------------

 t1=t1(1:1:end);
 s1=s1(1:1:end);
 

% Start-Werte
A=1;                % Amplitude             [mm]
w_0=2*pi*3.5/0.1;   % Eigenfrequenz         [1/s]
Phi_0=0.04*w_0;     % Phasenverschiebung    [rad]
Tau=0.15;           % Zeitkonstante         [s]

po=[A w_0 Phi_0 Tau]; % Startwerte

p=fminsearch(@BiegeBalken_f_min_fun,po,[],t1,s1);

A_est=p(1);                            % Ermittelte Parameter
w_0_est=p(2);                           
Phi_0_est=p(3);
Tau_est=p(4);

s_est=A_est.*sin(w_0_est*t1+Phi_0_est).*exp(-t1/Tau);       % Funktion mit den ermittelten

figure; 

   plot(t1,s1,'b'); 
   grid; xlabel('t [s]'); ylabel('s_1 [mm]')
   title('Biegebalken ')% Parametern

figure; 
 subplot(2,1,1)
   plot(t1,s1,'b',t1,s_est,'-.r'); 
   grid; xlabel('t [s]'); ylabel('s_1 [mm]')
   title('Biegebalken ')
   legend('Messwerte', 'Näherung'); 
 subplot(2,1,2)
   plot(t1,s_est-s1,'b'); 
   grid; xlabel('t [s]'); ylabel('Deltas [mm]')
   title('Abweichung')

%% function BiegeBalken_f_min_fun
%--------------------------------
% Ermittlung der Parameter Uo und Tau
% mit dem Minimum der minimalen Fehlerquadrate.

function y=BiegeBalken_f_min_fun(p,t_mess,s_mess)
A=p(1);
wo=p(2);
So=p(3);
Tau=p(4);

s_est=A.*sin(wo*t_mess+So).*exp(-t_mess/Tau); % Vorgabe der Funktionsstruktur

y=sum((s_est-s_mess).^2);     % Summe der Fehlerquadrate
end

