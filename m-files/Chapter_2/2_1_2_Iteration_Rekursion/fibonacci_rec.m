
% Kapitel  2.1 Iteration und Rekursion 
%
% rekursive function: fibonacci_rec.m 
%
% Berechnung der Fibonacci n-ten Zahl 		 	
% Lösungsvariante mit rekursivem Funktionsaufruf
% 
% Eingabe:	 n  : Stelle der Fibonacci-Zahl
%
% Ausgabe:   F(n): n-te Fibonnacci-Zahl
% 	
% Beispiel:	fibonacci_rec(6)
%		    ans = 8 
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-05-28
%           2020-05-24 Kommentare aufgeräumt
%
% see also: test_fib.m, fibonacci.m
%------------------------------------------------------------------------
function F=fibonacci_rec(n)

if n<=2
    F=1;
else
    F=fibonacci_rec(n-1)+fibonacci_rec(n-2);
end

