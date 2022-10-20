% m-file: train_Hebb_rule.m	
% 
% "Trainiert" ein neuronales Netz mit der Hebb'schen Lernregel.
% Die Beispielwerte aus dem Skript werden verwendet
%
% Autor:	
%       Horst Rumpf 
%
%        Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%        funktionale Systemsimulation Kapitel 9 SoSe 2022 erstellt.
%
% Datum:    2021-01-23
%
% Änderung: 2021-10-05 Kommentar erweitert
%
% siehe auch: SGD_Method.m, train_N_network.m, Sigmoid.m
%--------------------------------------------------------------------------
clearvars;
% Netzwerk
% Anzahl Eingabewerte
 Nx=3;
% Anzahl Ausgabewerte
Ny=1;

% Trainings-Daten
%----------------
% Anzahl Test-Daten
N_train=4;

% Eingabewerte

% Testdaten 1     2     3     4         
x    =    [ 0     0     1     1   % x1
            0     1     0     1   % x2
            1     1     1     1]; % x3  
   
% Korrekte Ausgabewerte
y_train=[1 1 0 0]';

% Wichtungsfaktoren
W=zeros(Nx,1);
S=zeros(N_train,1); % Propagierungsfkt
y=zeros(N_train,1); % Ausgabe-Daten des trainierten Neurons

for i=1:N_train
    k=x(:,i)'*x(:,i);            % x^T*x
    W=W+(x(:,i)*y_train(i)'/k);  % Hebb'sche Lernregel
                                 % Berechung der Gewichtung
end
b=-0.4; % Bias durch Variation ermittelt :-)
W=W+b;  % Gewichtung mit Bias

% Test des trainierten Neurons
for i=1:N_train 
    S(i)=(W'*x(:,i));
    y(i)=S(i)>1;  % Hard-Limiter 1
end
disp(['y_soll:' num2str(y_train')])
disp(['y_ist :' num2str(y_train')])
