%  function y3.m 
%
% Sehr einfaches Beispiel für eine function
%
% Berechnet wird das Polynom: y=a*x^3+b*x^2+c*x+d
%
%
% Eingabe:          x       : Argument als Vektor
%                   p       : p=[a b c d] Faktoren 
%
% Ausgabe:          y       : Funktionswert als Vektor        
% 		           
%	
% Autor:	Horst Rumpf
%
%           Diese funktion wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2018 erstellt.
%
% Datum:    2018-05-18
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
function y=y3(p,x)

y=p(1)*x.^3+p(2)*x.^2+p(3)*x+p(4);  % der Punkt vor dem Operator ist für
                                    % eine Elementweise Multiplikation 
                                    % notwendig