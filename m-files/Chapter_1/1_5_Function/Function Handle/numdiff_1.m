% function numdiff_1.m
%
% Einfaches differenzieren mit Dem differenzenquotion als Beispiel für das
% Arbeiten mit function handles
%
%
%
% Eingabe:          f       : function handle   
%                   x       : x-Werte, Vektor
%                   dx      : Schrittweite
%                              
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
% siehe auch: Test_fkt_handle.m
%--------------------------------------------------------------------------

function dy_dx=numdiff_1(f,x,dx)

dy_dx=(feval(f,x+dx)-feval(f,x))/dx;
%dy_dx=(f(x+dx)-f(x))/dx; % ab Version 7

