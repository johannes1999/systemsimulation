% Die Function E=Eff(t,S) berechnet den Effektivwert des Signals S(t) 
% mit dem Simpsonverfahren.
% Eff=Wurzel(1/Signaldauer * Integral(Signal^2))
% 
% Eingabe:          
%                   t :  Zeitvektor     [s]
%                   S :  Signalverlauf  [Einheit] 	
%                  
% Ausgabe:          E :	Effektivwert    [Einheit]
% 		
%	
% autor:	Horst Rumpf
%
% date:		2017-04-16
%
%
% siehe auch:test_Integration.m	

function E=Eff(t,S)
E=sqrt(1/(t(end)-t(1))*simpson(t,S.^2));








