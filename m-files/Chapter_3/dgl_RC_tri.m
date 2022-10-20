% Die function dgl_RC_tri(t,Uc,para)
%
% beschreibt eine Reihenschaltung von Widerstand und Kondensator an
% einer Dreiecksspannung-Spannungsversorgung. 
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
% siehe auch: test_DGL1_1.m 
%--------------------------------------------------------------------------

function dUc_dt=dgl_RC_tri(t,Uc,para)

R=para(1);              % Widerstand            [Ohm]
C=para(2);              % Kapazität             [F]

% Sinus-Spannung
Ua=para(3);             % Amplitude             [V]
w_tri=para(4);          % Winkelgeschwindigkeit [Hz]
Phi=para(5);            % Phasenwinkel          [rad]

U_tri=Ua*asin(sin(w_tri*t-Phi));

dUc_dt=(-Uc+U_tri)/(R*C);
