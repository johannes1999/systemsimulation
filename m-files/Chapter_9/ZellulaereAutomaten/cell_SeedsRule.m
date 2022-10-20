% m-file: cell_SeedsRule.m	
% 
% Beispiel-files für Kapitel 9.1 Zelluläre Automaten
% 
% Zellulärer Automat mit Seeds-Rule
% 
% Nachbarschaft	: Moore
% Zustandsmenge	: Q={0,1}
% Regel         : Deterministisch
% 				  Eine lebende Zelle stirbt immer. 
%                 Eine tote Zelle wird lebendig, wenn sie genau zwei Nachbarn hat.
% Berandung		: ohne Grenzen
% Anfangswerte	: Zufällig gesetzte Werte in der Mitte des Feldes       
%                 oder unterschiedliche Anfangsmuster
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation Kapitel 9 SoSe 2020 erstellt.
%
% Datum:    2020-08-01
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars
close all

% Seeds-Rule 
%===========
Nz=51;                  % Anzahl Zeilen
Ns=51;                  % Anzahl Spalten
z_m=round(Nz/2);        % Mitte des Feldes
s_m=round(Ns/2);        % -"-
index_z=[Nz 1:Nz 1];    % Indirekte Adressierung - keine Grenzen
index_s=[Ns 1:Ns 1];
      
SR=zeros(Nz,Ns);        % alle Werte Null
SR_neu=zeros(Nz,Ns);    % Matrix um Werte bei der Zwischenrechnung
                        % zu speichern ohne die vorherigen Werte zu
                        % überschreiben.
N_iter=50;              % Anzahl Iterationen
        
% Anfangswerte
% Verschiedene Anfangsbedingungen
%--------------------------------
Anfangsbed=4;   % 1: Minimalbedingung 1: 2 Samen diagonal mit einer Abstandszelle (2)
                % 2: Minimalbedingung 2: 2 Samen diagonal (5)
                % 3: Minimalbedingung 3: 2 Samen mit einer Abstandszelle(6)
                % 4: Minimalbedingung 4: 2 nebeneinanderliegende Samen (34)
                % 5: Zufallswerte nur in der Mitte
                                       
    switch Anfangsbed
    %----------------  
        case 1 
        % Minimalbedingung 1
             SR(z_m+1,s_m+1)=1;      
             SR(z_m-1,s_m-1)=1;    
        case 2 
        % Minimalbedingung 2
             SR(z_m,s_m)=1;      
             SR(z_m-1,s_m+1)=1; 
        case 3 
        % Minimalbedingung 3
             SR(z_m+(1:2:3),s_m)=1;     
        case 4 
        % Minimalbedingung 4
             SR(z_m+(0:1),s_m)=1;
        case 5 
        % In der Mitte des Feldes zufällig Werte setzten
            N_start=1;                                          % Seitenlänge=2*N_start+1 der Random-Anfangswerte
            AnfangsWerte=randi([0 1],2*N_start+1,2*N_start+1);  % Anfangswerte
            SR(z_m+(-N_start:N_start),s_m+(-N_start:N_start))=AnfangsWerte; 
                       
    end    
        figure 
        for i=1:N_iter  
            %figure 
            imagesc(SR);
            %s=pcolor(flipud(SR));
            %s.LineStyle='none';
            colormap([1 1 1 ;0 0 1]) 
            axis('equal')
            axis('off')
            title(['Seed-Rule Iterations: ' num2str(i)])
            pause(0.01)
            for z=1:Nz        % Zeilen
                for s=1:Ns    % Spalten
                    % Summe der Nachbarzellen 
                    SummeNachbarn=sum(SR(index_z(z+[0 1 2]),index_s(s+[0 1 2])),'all')-SR(z,s);
                    if SR(z,s)==1
                        SR_neu(z,s)=0;
                    else
                        if SummeNachbarn==2
                        SR_neu(z,s)=1;
                        end
                    end    
                end
            end
           SR=SR_neu;   
        end  
 