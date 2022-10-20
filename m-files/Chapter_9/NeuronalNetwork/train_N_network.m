% m-file: train_N_network.m	
% 
% Trainiert ein neuronales Netz mit der SGM-Methode(Stochastic Gradient Descent)
% mit einem Supervised Learning.
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
% siehe auch: SGD_Method.m, train_N_network.m, Sigmoid.m
%--------------------------------------------------------------------------
clearvars;
N_epoch=1000000; % Anzahl der Trainingsdurchläufe über alle Testbeispiele
Path='C:\Users\Horst\Documents\01_Vorlesungen\01_Studium Plus\07_System_Simulation\05_Matlab_work\Chapter_9\NeuronalNetwork\';
error=zeros(1,N_epoch);
% Trainings-Daten
%----------------
% Eingabewerte
input=[0 0 1 1
       0 1 0 1
       1 1 1 1];   
   
% Korrekte Ausgabewerte
correctOutput=[1 1 0 0]';

% Gewichtung zufällig besetzen
Weight=2*rand(1,3)-1;

for epoch=1:N_epoch
    [Weight, sum_error_2]=SGD_Method(Weight,input,correctOutput);
    error(epoch)=sum_error_2;           % Quadratischer Summenfehler 
                                        % nur für Darstellung des Fehlerverlaufs 
end
save([Path 'TrainedNetwork.mat']);     % Trainiertes Netzwerk speichern
Rel_Err=-diff(error)./error(2:end)*100;% Relative Änderung des quadratische Summenfehlers

figure
loglog(Rel_Err,'b.')
xlabel('Anzahl Epochen [-]')
ylabel('rel. Ändernung [%]');
grid