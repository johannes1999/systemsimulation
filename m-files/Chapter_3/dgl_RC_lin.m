% Die function dgl_RC_lin(t,Uc,para)
%
% beschreibt eine Reihenschaltung von Widerstand und Kondensator an
% einer Konstant-Spannungsquelle. Diese DGL wird im m-file test_DGL1_2.m
% mit verschieden Solver aufgerufen.
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
function dUc_dt=dgl_RC_lin(~,Uc,para)
                        %( t,Uc,para)
                        
R=para(1);              % Widerstand            [Ohm]
C=para(2);              % Kapazität             [F]
Ua=para(3);             % Versorgungsspannung   [V]

dUc_dt=(-Uc+Ua)/(R*C);

