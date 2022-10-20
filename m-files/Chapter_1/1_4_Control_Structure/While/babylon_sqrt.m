% m-file / function
%
% Beispiel f�r while-Schleife
% Babylonisches Wurzelziehen 
% Berechnung einer rekursiv definierten Folge
% a_n+1=1/2*(a_n+a/a_n) mit einer geforderten 
% Genauigkeit epsilon=(a_n-a_n+1)/a_n+1
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-26
%           2018-05-04 an Beschreibung angepasst
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace l�schen

a=2;                % Wert, aus der die Wurzel gezogen werden soll
eps_soll = 1e-7;    % Geforderte Genauigkeit (relative �nderung)
k_max=100;          % max. Anzahl Schleifendurchl�ufe

eps_ist=2*eps_soll; % Pr�fwert wird vor der Schleife gr��er gesetzt als
                    % der Sollwert
k=1;                % Schleifenz�hler 
a_alt=a;            % Startwert ist gleich dem Vorgabewert
 
while (eps_ist > eps_soll) && (k < k_max)
    
    a_neu=1/2*(a_alt+a/a_alt);           % Berechnung n�chster Wert
    eps_ist=abs((a_alt-a_neu)/a_neu);    % Berechnung der rel. �nderung 
    a_alt=a_neu;                         % Der neue Wert wird f�r die n�chste
                                         % Berechnung wieder eingesetzen
    k=k+1;                               % Schleifenz�hler erh�hen 
end
disp(a_neu);                             % Ergebnis ausgeben