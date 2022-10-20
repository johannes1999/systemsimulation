% m-file / function
%
% Beispiel für while-Schleife
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
clearvars;  % workspace löschen

a=2;                % Wert, aus der die Wurzel gezogen werden soll
eps_soll = 1e-7;    % Geforderte Genauigkeit (relative Änderung)
k_max=100;          % max. Anzahl Schleifendurchläufe

eps_ist=2*eps_soll; % Prüfwert wird vor der Schleife größer gesetzt als
                    % der Sollwert
k=1;                % Schleifenzähler 
a_alt=a;            % Startwert ist gleich dem Vorgabewert
 
while (eps_ist > eps_soll) && (k < k_max)
    
    a_neu=1/2*(a_alt+a/a_alt);           % Berechnung nächster Wert
    eps_ist=abs((a_alt-a_neu)/a_neu);    % Berechnung der rel. Änderung 
    a_alt=a_neu;                         % Der neue Wert wird für die nächste
                                         % Berechnung wieder eingesetzen
    k=k+1;                               % Schleifenzähler erhöhen 
end
disp(a_neu);                             % Ergebnis ausgeben