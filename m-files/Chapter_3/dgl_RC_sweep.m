% dgl_RC_sweep.m 
%
% beschreibt eine Reihenschaltung von Widerstand und Kondensator an
% einer Sweep-Spannungsversorgung. 
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-14
%
% Änderung: Diese Function wurde ausgelagert weil die Version R2014 keine
% local functions in m-files zulässt!
%
% siehe auch: test_DGL1_1.m
%--------------------------------------------------------------------------

function dUc_dt=dgl_RC_sweep(t,Uc,para)
R=para(1);
C=para(2);
Ua=para(3);
f0=para(4);
f1=para(5);
t0=para(6);
t1=para(7);

U_sweep=Ua*lin_sweep(t,f0,f1,t0,t1);

dUc_dt=(-Uc+U_sweep)/(R*C);

