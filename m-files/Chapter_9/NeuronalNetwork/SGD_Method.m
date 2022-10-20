% function: SGD_Method.m	
% 
% Diese function optimiert die Wichtungen eines Neuronalen Netzes mit 
% SGD-Methode (Stochastic Gradient Descent)
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
% siehe auch: Sigmoid.m, train_N_network.m
%--------------------------------------------------------------------------

function [Weight, sum_error_2]=SGD_Method(Weight,input, correctOutput)

alpha=0.9;                        % Faktor 0 < alpha < 1
N_data=length(correctOutput);     % Anzahl Datensätze
sum_error_2=0;                    % Quadratischer Summenfehler

for k=1:N_data
    Input=input(:,k);             % k-tes Eingabe-Musters
    d=correctOutput(k);           % Zugehöriges richtiges Ergebnis
    
    % Neuronales Netz
    %----------------
    weightedSum=Weight*Input; % Gewichtete Summe 
    output=Sigmoid(weightedSum);        % Ergebnis mit der Sigmoid-Aktivierungsfunktion
    
    % Generalisierte Delta-Regel
    %---------------------------
    error=d-output;                     % Fehler
    sum_error_2=sum_error_2+error^2;    % Quadratischer Summenfehler
    delta=output*(1-output)*error;      % Generalisierte Delta-Regel
    dWeight=alpha*delta*Input;          % -"-
    
    % Wichtungs-Faktoren ändern
    %--------------------------
    Weight=Weight+dWeight';             % Wichtungs-Faktoren anpassen
end
