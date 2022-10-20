% function rev_inv
%
% Berechnet die inverser Involut-Funktion mit dem Newton-Verfahren.

%
% Eingabe:           Phi : Winkel Startpunkt bis zum Punkt auf 
%                          der Kreis-Evolvente.
%                    
% Ausgabe:           Al : Teil des erzeugenden Winkels Al+Phi 
% 
% Beispiel:
%          rev_inv(pi/2)
%          ans = 2.000000600887957e+00
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%           Kapitel  2.1 Iteration 
%
% Datum:    2020-05-24
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------

function Al=rev_inv(Phi)

N=0;                    % Zähler Anzahl Iterationsschritte
Nmax=10000;             % max. Anzahl Iterationsschritte
eps_soll=1e-12;         % Sollwert der rel. Abweichung
eps_ist=2*eps_soll;     % Istwert der rel. Abweichung

x_n=pi/2-0.001; % Startwert 
if Phi<0        % Auf dem richtigen Ast anfangen.
   x_n=-x_n;
end  

while ((eps_ist > eps_soll) &&(N <Nmax))
    N=N+1;
    
    x_n1=x_n-(tan(x_n)-x_n-Phi)/tan(x_n)^2; % Newton-Verfahren
    
    if abs(x_n1)>=pi/2  % Ist der Wert ausserhalb des Definitionsbereichs?
        x_n1=sign(x_n1)*(pi/2-0.005);
    end
    
    eps_ist=abs((x_n-x_n1)/x_n1); % rel. Änderung
    x_n=x_n1;
   
end

Al=x_n;