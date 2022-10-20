% Kapitel  2.1 Iteration und Rekursion 
%
% function: bab_wurzel_func.m 
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
%           funktionale Systemsimulation WiSe 2021 erstellt.
%
% Datum:    2017-05-28
%           2020-05-24 Kommentare aufgeräumt
%
% see also: 
%------------------------------------------------------------------------

function y=bab_wurzel_func(x)

eps_soll=0.0001;
eps_ist=2*eps_soll;
a=x;
an=x;

while eps_ist>eps_soll
 an_neu=1/2*(an+a/an);
 eps_ist=abs((an-an_neu)/an_neu);
 an=an_neu; 
end
y=an;