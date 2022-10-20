% Die function dgl_RC_rnd(t,Uc,~,R,C,ta,Ua)
%
% beschreibt eine Reihenschaltung von Widerstand und Kondensator an
% einer beliebigen Versorgungsspannung, die als Vektor ta(Zeitwerte) 
% und Ua(Spannungswerte)übergeben werden.
% Durch  Interpolation werden benötigte Zwischenwerte erzeugt.
% 
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-14
%
% Änderung: 
%
% siehe auch: test_FFT_Tiefpass.m 
%--------------------------------------------------------------------------

function dUc_dt=dgl_RC_rnd(t,Uc,~,R,C,ta,Ua)

U_a_int=interp1(ta,Ua,t);% Berechnung des Zwischenwertes zur Zeit t

dUc_dt=(-Uc+U_a_int)/(R*C);
