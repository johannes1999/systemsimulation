% function Newton_1
%
% Diese Funktion berechnet die Nullstelle der Funktion f mit dem 
% Newton-Verfahren. Die Ableitung wird mit einem Differenzenquotient
% berechnet. Die Vorgabe der Schrittweite für diesen Quotienten ist fest
% vorgegeben. Es ist zu überlegen ob eine dynamische Anpassung sinnvoll 
% ist. Eine Fehlerausgabe sollte zugefügt werden.
% 
%
% Eingabe:           f : Funktion, von der die Nullstelle gesucht wird 
%                   x_n: Schätzwert der Nullstelle    
%                eps_so: Genauigkeit (relative Abweichung)	
% 
% Beispiel:
%          f1=@(x) x.^2-4;
%          Newton_1(f1,1000,0.001)
%          ans = 2.000000600887957e+00
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%           Kapitel  2.1 Iteration 
%
% Datum:    2017-05-01
%
% Änderung: 2020-05-24 feval entfernt - nicht mehr nötig
%           2021-10-21 Kommentar für interne function korrigiert
%
% siehe auch: Nullstellen für Polynome matlab-function roots
%--------------------------------------------------------------------------

function x_n1=Newton_1(f,x_n,eps_soll)

N=0;                    % 2. Zähler Anzahl Iterationsschritte
Nmax=10000;             %    max. Anzahl Iterationsschritte

if nargin<3             % Wird keine max. rel. Änderung vorgegben
    eps_soll=1e-12;     % dann ist eps_soll=1e-12
end

eps_ist=2*eps_soll;     % Istwert der rel. Abweichung

while ((eps_ist > eps_soll) &&(N <Nmax))
    N=N+1;
    x_n1=x_n-f(x_n)/Diff(f,x_n);  % Newton-Verfahren
    eps_ist=abs((x_n-x_n1)/x_n1); % rel. Änderung 
    x_n=x_n1;
end
end

% Interne function
% für die numerische Ableitung dy/dx der Funktion f
%--------------------------------------------------
function dy_dx=Diff(f,x1)
   dx=0.001;
   dy_dx=(f(x1+dx)-f(x1))/dx;
end
