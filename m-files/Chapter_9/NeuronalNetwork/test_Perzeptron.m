% m-file: test_Perzeptron.m	
% 
% Das Beispiel f�r ein Perzeptron wurde von der Seite 
% "Tutorials �ber Maschinelles Lernen, 
%  K�nstliche Intelligenz und Data Science" 
%  https://neuromant.de/ 
% �bernommen. Das ganze ist noch in Arbeit! 
% 
%
% Autor:	
%        siehe https://neuromant.de/ 
%
%        Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%        funktionale Systemsimulation Kapitel 9 SoSe 2022 erstellt.
%
% Datum:    2021-02-3
%
% �nderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars;
close all;

% Test- und Trainigsdaten laden
%------------------------------
% Pfad f�r die Daten des trainierten Netzwerkes
Path='C:\Users\Horst\Documents\01_Vorlesungen\01_Studium Plus\07_System_Simulation\05_Matlab_work\Chapter_9\NeuronalNetwork\';
load([Path 'Sonar.mat']);       % Daten laden
% Sonar.mat enth�lt die Sonardatens�tze Sonar(Anz_Datens�tze, Anz_Werte f�r jeden Datensatz
% und das Ergebnis f�r jeden Datensatz MetalRock(Anz_Datens�tze). Mit
% MetalRock=0 bedeutet Stein und MetalRock=1 bedeutet Metall.

[N_data,N_values]=size(Sonar);  % N_data: Anzahl Datens�tze
                                % N_Values: Anzahl Werte pro Datensatz
                                
%Load([Path 'TrainedPerzeptron.mat']); % W: Wichtungsfaktoren laden

ErgebnisTxt={'Stein', 'Metall', '{\color{blue}richtig}', '{\color{red} falsch}'};                               

Schritt=4;      % 1: Trainings und Test-Daten anzeigen
                % 2: Netzwerk trainieren
                %    Speichern mit saveWeihgts=1
                     saveWeihgts=0;
                % 3: Netzwerk testen
                % 4: Selbst lernen
                % 5: Eigenen Lernerfolg testen
                
% Parameter
N_inputs=N_values+1;        % Anzahl Inputs (Daten plus Bias)
W=rand(1,N_inputs);         % Wichtungs-Vektor zuf�llig besetzen

Epochen=1000;               % Anzahl Test-Epochen
errors=zeros(1,Epochen);    % Fehler pro Epoche
Al=0.001;                   % Lernrate 0 < Al < 1

% Aufteilen der Daten in Training- und Testdaten
N_test=30;                  % Anzahl der Datens�tze zum Testen
N_training=N_data-N_test;   % Anzahl der Datens�tze zum Trainieren

ind_rand=randperm(N_data);  % Daten mischen 
Sonar=[ones(N_data,1) Sonar];                       % F�r die Wichtung des Bias eine Spalte mit Einzen zugef�gen

Input_test=Sonar(ind_rand(1:N_test),:);             % Input-Datensatz zum testen
Output_test=MetalRock(ind_rand(1:N_test));          % Output-Datensatz zum testen

Input_training=Sonar(ind_rand(N_test+1:end),:);     % Input-Datensatz zum trainieren
Output_training=MetalRock(ind_rand(N_test+1:end));  % Output-Datensatz zum trainieren

switch Schritt
    
    case 1  % 1: Trainings und Test-Daten darstellen
            %---------------------------------------
        figure
        subplot(2,2,1)
            plot(2:N_inputs,Input_training(:,2:N_inputs)')
        subplot(2,2,2)
            plot(Output_training,'b*')
        subplot(2,2,3)
            plot(2:61,Input_test(:,2:N_inputs))
        subplot(2,2,4)
            plot(Output_test,'b*')
                    
    case 2  % 2: Netzwerk trainieren
            %-----------------------
        for k=1:Epochen % Schleife �ber alle Epochen
            
            % f�r jede Epoche Trainingsdatens�tze neu mischen
            ind=randperm(N_training); % Index f�r Datens�tze
            inputs=Input_training(ind,:);
            target=Output_training(ind);
            
            err=0;
            for j=1:N_training  % Schleife �ber alle Trainingsdatens�tze
               output=HardLimiter(W*inputs(j,:)');  
               delta=target(j)-output;
               if delta~=0
                   W=W+Al*delta*inputs(j,:);
                   err=err+1;               % Fehler pro Epoche summieren
               end
            end
            errors(k)=err;                  % Fehler pro Epoche speichern
        end
        
        if saveWeihgts==1
          save([Path 'TrainedPerzeptron.mat'],'W'); % Daten speichern
        end
  
        figure
        plot(errors/N_training*100);    % rel. Fehler ploten
        xlabel('Epoche')
        ylabel('rel. Error [%]')
        grid
                  
    case 3  % 3: Netzwerk testen
            %-------------------
        err=0;
        inputs=Input_test;      % Nur umbenennen
        target=Output_test;
       
        for j=1:N_test  % Schleife �ber alle Trainingsdatens�tze
               output=HardLimiter(W*inputs(j,:)');  
               error=abs(target(j)-output);
               err=err+error;   
               err_rel=err*100/j;
                figure(1)
                    plot(2:N_inputs,inputs(j,2:N_inputs),'b')
                    title(['Test: ' num2str(j) ' Ist ' ErgebnisTxt{target(j)+1} '. Ergebnis: '...
                          ErgebnisTxt{error+3} '. rel. Fehler= ' num2str(err_rel) '%'])
              pause(0.5)        
        end   
        
  case 4    % 4: Selbst lernen
            %-----------------
            % Dieser Fall sollte besser in einer App geschrieben werden
            % f�r jeden Aufruf die Trainingsdatens�tze neu mischen
            ind=randperm(N_training); % Index f�r Datens�tze
            inputs=Input_training(ind,:);
            target=Output_training(ind);
            
            err=0;              % Fehler-Z�hler
            for j=1:N_training  % Schleife �ber alle Trainingsdatens�tze
               figure(1)
                plot(2:N_inputs,Input_training(j,2:N_inputs))
                grid
                title(['Test: ' num2str(j) ' rel. Fehler ' num2str(err/j*100) '%'])
                
                output=input('Stein=0, Metall=1\n');
                error=abs(target(j)-output);
                
                figure(1)
                plot(2:N_inputs,Input_training(j,2:N_inputs))
                grid
                if error==1
                    title(['Test: ' num2str(j) ' Ergebnis:' ErgebnisTxt{4} ' ist ' ErgebnisTxt{target(j)+1}])
                    err=err+1;               % Fehler pro Epoche summieren
                else
                    title(['Test: ' num2str(j) ' Ergebnis:' ErgebnisTxt{3} ' ist ' ErgebnisTxt{target(j)+1}])
                end
               input('weiter')
            end
           
       
end
