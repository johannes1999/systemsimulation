% m-file: cell_GameOfLife.m	
% 
% Beispiel-files für Kapitel 9.1 Zelluläre Automaten
% 
% Nachbarschaft	: Moore
% Zustandsmenge	: Q={0,1}
% Regel 			: Deterministisch
%				      1. Eine tote Zelle (nicht ausgefüllt) mit genau drei
%                        lebenden Nachbarn (ausgefüllten Zellen) wird in 
%                        der Folgegeneration neu geboren (ausgefüllt).
%                     2. Lebende Zellen mit weniger als zwei lebenden 
%                        Nachbarn sterben in der Folgegeneration an 
%                        Einsamkeit.
%                     3. Eine lebende Zelle mit zwei oder drei lebenden 
%                        Nachbarn bleibt in der Folgegeneration am Leben.
%                     4. Lebende Zellen mit mehr als drei lebenden Nachbarn 
%                        sterben in der Folgegeneration an Überbevölkerung.
%
%                   if (Zelle & (SummeNachbarn = 2)) OR (SummeNachbarn = 3)
%                       Zelle=1;
%                   else
%                       Zelle=0;
%                   end
% 
% Die Umsetzung Version=2 wurde aus dem m-file life.m entnommen.
%
% Anfangsbedingung : Es wurden verschiedene Anfangsmuster umgesetzt.
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation Kapitel 9 SoSe 2020 erstellt.
%
% Datum:    2020-07-15
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars
close all

% Game of Life 
%=============

Version=2;      % 1: Umsetzung Punkt für Punkt
                % 2: Komplette Matrix
                
% Anfangswerte für beide Versionen  
m=101;          % Anzahl Zeilen = Spalten
m2=round(m/2);  % Mitte des Feldes
N_iter=200;     % Anzahl Iterationen

GL=zeros(m);    % alle Werte Null
     
% Verschiedene Anfangsbedingungen
%--------------------------------
Anfangsbed=1;   % 1: 15x (3x3) Zufallswerte
                % 2: Blinker
                % 3: Toad
                % 4: Glider
                        
    switch Anfangsbed
    %----------------    
        case 1 % 15x[3 3] Zufallswerte
             p = -1:1;
                for count = 1:15
                    kx = floor(rand*(m-4))+2;
                    ky = floor(rand*(m-4))+2;
                    GL(kx+p,ky+p) = (rand(3)>0.5);
                end
                
        case 2 % Blinker  
             GL(m2,m2:m2+2)=1; 
             
        case 3 % Toad    
             GL(m2-1:m2+1,m2)=1;
             GL(m2:m2+2,m2+1)=1;

         case 4 % Glider
              GL(m2,m2:m2+1)=1;
              GL(m2+1,m2+1:m2+2)=1;
              GL(m2+2,m2)=1;
    end   
        
    switch Version
        case 1 
        %% Eine Zelle nach der anderen
        %-----------------------------    
            index=[m 1:m 1];% Indirekte Adressierung - keine Grenzen
            GL_neu=GL;      % Matrix um Werte bei der Zwischenrechnung
                            % zu speichern ohne die vorherigen Werte zu
                            % überschreiben.
            
            for i=1:N_iter 
                figure 
                [j,k] = find(GL==1);
                plot(j,k,'. b', 'MarkerSize',12) 
                axis([0 m+1 0 m+1]);
                axis('off')
                title(['Game of Life Iterations: ' num2str(i)])
                pause(0.01)
            
                for z=1:m        % Zeilen
                    for s=1:m    % Spalten
                    
                        % Summe der Nachbarzellen
                        Cell=GL(z,s);
                        SummeNachbarn=sum(sum(GL(index(z+[0 1 2]),index(s+[0 1 2]))))-Cell;
                        
                        %Bedingung
                        if (Cell && (SummeNachbarn == 2)) || (SummeNachbarn == 3)
                            GL_neu(z,s)=1;
                        else
                            GL_neu(z,s)=0;
                        end    
                    end
                end
                GL=GL_neu;   
            end
        case 2 
        %% Kompette Matrix auf einmal
        %  Berechnung aus matlab-File life.m übernommen
        %----------------------------------------------
        
            n = [m 1:m-1];
            e = [2:m 1];
            s = [2:m 1];
            w = [m 1:m-1];
            figure
            for i=1:N_iter  
                [j,k] = find(GL==1);
                plot(j,k,'. b', 'MarkerSize',12) 
                axis([0 m+1 0 m+1]);
                axis('off')
                title(['Game of Life Iterations: ' num2str(i)])
                pause(0.01)  
                    
                SummeNachbarn = GL(n,:) + GL(s,:) + GL(:,e) + GL(:,w) + ...
                                GL(n,e) + GL(n,w) + GL(s,e) + GL(s,w);
                GL = (GL & (SummeNachbarn == 2)) | (SummeNachbarn == 3);
            end
    end

