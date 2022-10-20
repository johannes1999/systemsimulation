% Die Function A=ARV(t,S) berechnet den arithmetischen Gleichrichtwert 
% (average rectified value) des Signals S(t) mit dem Simpsonverfahren.
% ARV=1/Signaldauer * Integral(Betrag(Signals))
% 
% Eingabe:          
%                   t :  Zeitvektor     [s]
%                   S :  Signalverlauf  [] 	
%                  
% Ausgabe:          A :	Arithmetischer Gleichricht-Wert
%                      (average rectified value) 
% 		
%	
% autor:	Horst Rumpf
%
% date:		2017-04-16
%
%
% siehe auch:test_Integration.m	

function A=ARV(t,S)
A=1/(t(end)-t(1))*simpson(t,abs(S));








