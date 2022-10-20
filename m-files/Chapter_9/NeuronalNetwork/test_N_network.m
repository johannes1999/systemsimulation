% m-file: test_N_network.m	
% 
% testet ein neuronales Netz.
% Die Daten trainierten Wichtungsfaktoren sind unter TrainedNetwork.mat
% abgelegt.
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
% siehe auch: SGD_Method.m, train_N_network.m, Sigmoid.m,TrainedNetwork.mat
%--------------------------------------------------------------------------
clearvars;
% Pfad für die Daten des trainierten Netzwerkes
Path='C:\Users\Horst\Documents\01_Vorlesungen\01_Studium Plus\07_System_Simulation\05_Matlab_work\Chapter_9\NeuronalNetwork\';
load([Path 'TrainedNetwork.mat']);     % Trainiertes Netwerk laden

% Trainings-Daten
%----------------
% Eingabewerte

 input=[0 0 1 1
        0 1 0 1
        1 1 1 1];
% Korrekte Ausgabewerte
correctOutput=[1 1 0 0]';       % Für die Darstellung der Abweichung
N_data=length(correctOutput);   % Anzahl Datensätze

output=zeros(1,N_data);         % Ausgabedaten

for k=1:N_data
    Input=input(:,k);           % k-tes Eingabe-Musters
   
    % Neuronales Netz
    %----------------
    weightedSum=Weight*Input;       % Gewichtete Summe 
    output(k)=Sigmoid(weightedSum); % Ergebnis mit der Sigmoid-Aktivierungsfunktion
end

disp(output')