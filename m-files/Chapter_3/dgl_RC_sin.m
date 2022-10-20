% Die function dgl_RC_sin(t,Uc,para)
%
% beschreibt eine Reihenschaltung von Widerstand und Kondensator an
% einer Sinus-Spannungsversorgung. 
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

function dUc_dt=dgl_RC_sin(t,Uc,para)

R=para(1);              % Widerstand            [Ohm]
C=para(2);              % Kapazität             [F]

% Sinus-Spannung
Ua=para(3);             % Amplitude             [V]
w_sin=para(4);          % Winkelgeschwindigkeit [Hz]
Phi=para(5);            % Phasenwinkel          [rad]

U_sin=Ua*sin(w_sin*t-Phi);

dUc_dt=(-Uc+U_sin)/(R*C);
