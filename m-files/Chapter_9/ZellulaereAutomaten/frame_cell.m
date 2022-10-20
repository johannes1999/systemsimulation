% m-file: frame_cell.m
% 
% Für die Berechnung eines Zellulären Automatens sind in diesem file
% die Berandungsvarianten und verschiedene Nachbarschaften schon vorgegeben
% und es sind noch der eigene Algorithmus und die Darstellung einzugeben.
%
% Weiterführende Idee: Einen Solver für Zelluläre Automaten bauen bei dem 
%                      man über options Berandung, Nachbarschaften und
%                      verschiedene Ausgaben einstellen kann.
%                      Es könnten die Regeln in einer separaten function
%                      abgelegt sei, so wie bei ode45 die DGL.
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation Kapitel 9 SoSe 2020 erstellt.
%
% Datum:    2020-09-13
%
% Änderung:   2020-09-17 äußere Schleife und Kommentare zugefügt 
% siehe auch: Skript Kapitel 9
%--------------------------------------------------------------------------
clearvars
close all


 Grenze=1;      %    Fall=1: mit Grenzen       
                %    Fall=2: ohne obere und untere Grenze
                %    Fall=3: ohne Grenzen
%-------------------------------------------------------------

% Zellen festlegen
%------------------
m=5;                % Anzahl Zeilen
n=6;                % Anzahl Spalten
cell=zeros(m,n);    % Zellen

% max. Anzahl Interationen festlegen
%-----------------------------------
N_iter=1;           % Max. Anzahl Iterationen
N_ist=0;            % Schleifenzähler
NoChanges=0;        % Variable für Abfrage auf stationären Zustand

% Beispiel um die Zellenauswahl  zu zeigen
% Löschen Sie dieses Beispiel um einen eigenen Algorthmus einzubauen
%-------------------------------------------------------------------
% Beipiel Zellen durchnummerieren
W=0;            
for i=1:m
    for j=1:n
        W=W+1;
        cell(i,j)=W;
    end
end

%% Anfangswerte
%  An dieser Stelle die Anfangswerte setzen!
%-------------------------------------------
cell_neu=cell;          % cell_neu wird benötigt damit cell nicht überschrieben wird
                        % und zur Überprüfung ob der statische Zustand
                        % erreicht ist.
                        
disp(cell);             % Anfangswerte darstellen
                        % disp durch entsprechenden plot-Befehl ersetzen
                        % image, plot, pcolor ...
                        
%% Auswahl der Berandungsvariante
%--------------------------------
switch Grenze
    case 1 % mit Grenzen
           %------------
        z=2:m-1;            % Schleifen-Indizes
        s=2:n-1;
        index_z=0:m;        % zugehörige Zellen-Indizes
        index_s=0:n;
        Grenze_txt='mit Grenze';
                
    case 2  % ohne obere und untere Grenze
            %-----------------------------
        z=1:m;              % Schleifen-Indizes
        s=2:n-1;        
        index_z=[m 1:m 1];  % zugehörige Zellen-Indizes
        index_s=0:n;
        Grenze_txt='ohne obere und untere Grenze';
        
    case 3  % ohne Grenzen
            %-------------
        z=1:m;              % Schleifen-Indizes
        s=1:n;              
        index_z=[m 1:m 1];  % zugehörige Zellen-Indizes
        index_s=[n 1:n 1];  
        Grenze_txt='ohne Grenzen';
end
       disp(['Berandungsvariante: ' Grenze_txt])
              
%% Zelluärer Automat mit drei Schleifen
%--------------------------------------
% Iterationen
%------------
while ((N_ist < N_iter) && (NoChanges == 0))  
    N_ist=N_ist+1;  % Schleifenzäher    
    
    for Zeile=z
        for Spalte=s
            Alle9Zellen=reshape(cell(index_z(Zeile+[0 1 2]),index_s(Spalte+[0 1 2])),1,[]);
            % Nachbarschafts-Varianten
            %-------------------------
            % Entweder nur die benötigte Nachbarschaft stehen lassen oder einen
            % switch-case einbauen!
                
            % Moore-Nachbarn
                MooreNachbarnPlus=Alle9Zellen;                   % mit die mittlere Zelle
                MooreNachbarn=Alle9Zellen([1 2 3 4 6 7 8 9]);    % ohne die mittlere Zelle
                
            % von Neumann-Nachbarn 
                NeumannNachbarnPlus=Alle9Zellen([2 4 5 6 8]);   % mit die mittlere Zelle
                NeumannNachbarn=Alle9Zellen([2 4 6 8]);         % ohne die mittlere Zelle
                
            %% An dieser Stelle den eigenen Algorithmus einbauen
            %================================================================================
        
            % Die nächsten zwei Zeilen löschen und die Übergangsregel einbauen.
        
            disp(['Zelle(' num2str(Zeile) ',' num2str(Spalte) ')=' num2str(cell(Zeile,Spalte))])
                    disp(NeumannNachbarn)
                
                
                
            %=================================================================================
        end
    end
    %-- Statischer Zustand ?
    if isequal(cell,cell_neu)
            NoChanges=1;    % Hat sich das Bild verändert?
    end    
    cell=cell_neu;          % Neue Werte speichern
end
