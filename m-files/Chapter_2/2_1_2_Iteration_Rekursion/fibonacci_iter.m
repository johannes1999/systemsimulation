% Kapitel  2.1 Iteration und Rekursion 
%
% function: fibonacci_iter.m 
%
% Berechnung der Fibonacci n-ten Zahl 		 	
% Lösungsvariante mit iterativem Funktionsaufruf
% 
% Eingabe:	 n  : Stelle der Fibonacci-Zahl
%
% Ausgabe:   z  : 1-te bis n-te Fibonnacci-Zahl
% 	
% Beispiel:	fibonacci_iter(5)
%		    ans = 1     1     2     3     5
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

function z=fibonacci_iter(N)

z=[1 1];

for i=3:N
    z(i)=z(i-2)+z(i-1);
end
