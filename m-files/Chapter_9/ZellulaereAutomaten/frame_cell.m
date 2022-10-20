% m-file: frame_cell.m
% 
% F�r die Berechnung eines Zellul�ren Automatens sind in diesem file
% die Berandungsvarianten und verschiedene Nachbarschaften schon vorgegeben
% und es sind noch der eigene Algorithmus und die Darstellung einzugeben.
%
% Weiterf�hrende Idee: Einen Solver f�r Zellul�re Automaten bauen bei dem 
%                      man �ber options Berandung, Nachbarschaften und
%                      verschiedene Ausgaben einstellen kann.
%                      Es k�nnten die Regeln in einer separaten function
%                      abgelegt sei, so wie bei ode45 die DGL.
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation Kapitel 9 SoSe 2020 erstellt.
%
% Datum:    2020-09-13
%
% �nderung:   2020-09-17 �u�ere Schleife und Kommentare zugef�gt 
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
N_ist=0;            % Schleifenz�hler
NoChanges=0;        % Variable f�r Abfrage auf station�ren Zustand

% Beispiel um die Zellenauswahl  zu zeigen
% L�schen Sie dieses Beispiel um einen eigenen Algorthmus einzubauen
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
cell_neu=cell;          % cell_neu wird ben�tigt damit cell nicht �berschrieben wird
                        % und zur �berpr�fung ob der statische Zustand
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
        index_z=0:m;        % zugeh�rige Zellen-Indizes
        index_s=0:n;
        Grenze_txt='mit Grenze';
                
    case 2  % ohne obere und untere Grenze
            %-----------------------------
        z=1:m;              % Schleifen-Indizes
        s=2:n-1;        
        index_z=[m 1:m 1];  % zugeh�rige Zellen-Indizes
        index_s=0:n;
        Grenze_txt='ohne obere und untere Grenze';
        
    case 3  % ohne Grenzen
            %-------------
        z=1:m;              % Schleifen-Indizes
        s=1:n;              
        index_z=[m 1:m 1];  % zugeh�rige Zellen-Indizes
        index_s=[n 1:n 1];  
        Grenze_txt='ohne Grenzen';
end
       disp(['Berandungsvariante: ' Grenze_txt])
              
%% Zellu�rer Automat mit drei Schleifen
%--------------------------------------
% Iterationen
%------------
while ((N_ist < N_iter) && (NoChanges == 0))  
    N_ist=N_ist+1;  % Schleifenz�her    
    
    for Zeile=z
        for Spalte=s
            Alle9Zellen=reshape(cell(index_z(Zeile+[0 1 2]),index_s(Spalte+[0 1 2])),1,[]);
            % Nachbarschafts-Varianten
            %-------------------------
            % Entweder nur die ben�tigte Nachbarschaft stehen lassen oder einen
            % switch-case einbauen!
                
            % Moore-Nachbarn
                MooreNachbarnPlus=Alle9Zellen;                   % mit die mittlere Zelle
                MooreNachbarn=Alle9Zellen([1 2 3 4 6 7 8 9]);    % ohne die mittlere Zelle
                
            % von Neumann-Nachbarn 
                NeumannNachbarnPlus=Alle9Zellen([2 4 5 6 8]);   % mit die mittlere Zelle
                NeumannNachbarn=Alle9Zellen([2 4 6 8]);         % ohne die mittlere Zelle
                
            %% An dieser Stelle den eigenen Algorithmus einbauen
            %================================================================================
        
            % Die n�chsten zwei Zeilen l�schen und die �bergangsregel einbauen.
        
            disp(['Zelle(' num2str(Zeile) ',' num2str(Spalte) ')=' num2str(cell(Zeile,Spalte))])
                    disp(NeumannNachbarn)
                
                
                
            %=================================================================================
        end
    end
    %-- Statischer Zustand ?
    if isequal(cell,cell_neu)
            NoChanges=1;    % Hat sich das Bild ver�ndert?
    end    
    cell=cell_neu;          % Neue Werte speichern
end
