% funcrion sin_cardinalis.m
%
% Berechnet zu den cardinalsinus als Beispiel 
% in matlab steht der normierte cardinalsinus als Function zur Verfügung
% siehe sinc(x)=sin(pi*x)/(pi*x)
%
%
% Eingabe:          x       :    Vektor
%                   
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-03-17
%
% Änderung: 
%
% siehe auch: Test_fkt_handle
%--------------------------------------------------------------------------

function y=sin_cardinalis(x)
y=sin(x)./x;