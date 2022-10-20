% function: Sigmoid.m	
% 
% Sigmoid-Aktivierungsfunktion für neuronale Netze
%
% Autor:	
%        siehe youtube Nuruzzaman Faruqui,Neuronal Network using Matlab 
%
%        Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%        funktionale Systemsimulation Kapitel 9 SoSe 2022 erstellt.
%
% Datum:    2021-01-8
%
% Änderung: 
%
% siehe auch: SGD_Method.m, train_N_network.m, test_N_network.m
%--------------------------------------------------------------------------

function y=Sigmoid(x,a)

if nargin < 2
    a=0;
end

y=1./(1+exp(-(x+a)));
