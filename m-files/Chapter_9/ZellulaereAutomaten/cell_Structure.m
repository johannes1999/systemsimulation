% m-file: frame_Structure.m
% 
% 
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation Kapitel 9 SoSe 2020 erstellt.
%
% Datum:    2020-09-13
%
% Änderung:   2020-09-17 äußere Schleife und Kommentare zugefügt 
% siehe auch: frame_cell.m, Skript Kapitel 9
%--------------------------------------------------------------------------

clearvars
close all

 Grenze=3;      %    Fall=1: mit Grenzen       
                %    Fall=2: ohne obere und untere Grenze
                %    Fall=3: ohne Grenzen
%-------------------------------------------------------------

m=100;          % Anzahl Zeilen
n=100;          % Anzahl Spalten
N_iter=50;      % Anzahl Iterationen
cell=ones(m,n); % Zellen

N_ist=0;        % Schleifenzähler
NoChanges=0;    % Variable für Abfrage auf stationären Zustand
NoBlink=0;
AnzahlStrukturElemente=9;   %
pos_c=[256 128 86 64 52 43 37 32 29]; % Aus jet ausschneiden
c=colormap('jet');
c_m=c(1:pos_c(AnzahlStrukturElemente):end,:); 

% c_m=[0    0    1
%      0    0.25 0.75
%      0    0.5  0.5
%      0    1    0
%      0.25 0.75 0
%      0.5  0.5  0
%      1    0    0
%      0.5 0.5 0.5 ]; % color map: Struktur-Elemente

%cell=randi([1, AnzahlStrukturElemente],m,n);  % zufällige Verteilung
cell_neu=cell;                            % Matrix um Werte bei der Zwischenrechnung
                                      % zu speichern ohne die vorherigen Werte zu
                                      % überschreiben.
cell_alt=cell;

%% Anfangswerte
%  An dieser Stelle die Anfangswerte setzen!
%-------------------------------------------

figure
 subplot(2,2,1)
    imagesc(cell);
    colormap(c_m(1:AnzahlStrukturElemente,:)) 
    axis('equal')
    axis('off')
    title('Majority-Rule: Anfangs-Muster')
 subplot(2,2,3)
    plotBar(cell,AnzahlStrukturElemente,c_m)% Histogramm darstellen
    title('Mehrheitsverteilung am Anfang');
                     
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
%% Zelluärer Automat mit zwei Schleifen
%--------------------------------------
figure 
%for i=1:N_iter
while ((N_ist < N_iter) && (NoChanges == 0) && (NoBlink == 0))   
    N_ist=N_ist+1;  % Schleifenzäher    
    imagesc(cell);
      colormap(c_m(1:AnzahlStrukturElemente,:)) 
      axis('equal')
      axis('off')
      title([' Iterations: ' num2str(N_ist) '/ max.' num2str(N_iter)])
    pause(0.01)
    for Zeile=z
        for Spalte=s
            Alle9Zellen=reshape(cell(index_z(Zeile+[0 1 2]),index_s(Spalte+[0 1 2])),1,[]);
            % Nachbarschafts-Varianten
            %-------------------------
            % Entweder nur die benötigte Nachbarschaft stehen lassen oder einen
            % switch-case einbauen!
                
            % Moor-Nachbarn
                MoorNachbarnPlus=Alle9Zellen;                   % mit die mittlere Zelle
                % MoorNachbarn=Alle9Zellen([1 2 3 4 6 7 8 9]);    % ohne die mittlere Zelle
                
            % von Neumann-Nachbarn 
                %    NeumannNachbarnPlus=Alle9Zellen([2 4 5 6 8]);   % mit die mittlere Zelle
                %    NeumannNachbarn=Alle9Zellen([2 4 6 8]);         % ohne die mittlere Zelle
                
            %% An dieser Stelle den eigenen Algorithmus einbauen
            %================================================================================       
            [h, ~]=hist(MoorNachbarnPlus,1:AnzahlStrukturElemente);

            h_0=find(h==0);
                if (~isempty(h_0))&& (h(cell(Zeile,Spalte))~=1)
                    n_pos_0=length(h_0);
                    cell_neu(Zeile,Spalte)=h_0(randi(n_pos_0));
                else
                    cell_neu(Zeile,Spalte)=cell(Zeile,Spalte);
                end                                
            %=================================================================================
        end
    end   
        if isequal(cell,cell_neu)
            NoChanges=1;  % Hat sich das Bild verändert?
        end    
        if N_ist>3 && isequal(cell_neu,cell_alt)
            NoBlink=1;  % Hat sich das Bild verändert?
        end    
    cell_alt=cell;    
    cell=cell_neu;
end

% Endzustand
figure
 subplot(2,2,2)
    imagesc(cell);
     colormap(c_m(1:AnzahlStrukturElemente,:)) 
    axis('equal')
    axis('off')
    title(['Mehrheitsverteilung nach' num2str(N_ist) ' Iterationen']);
 subplot(2,2,4)
   plotBar(cell,AnzahlStrukturElemente,c_m)% Histogramm darstellen
   title('Mehrheitsverteilung am Ende');
   
%% Histogramm farbig darstellen
%------------------------------
function []=plotBar(Y,N_Klassen,Farbe)
    
[Hy,~]=histcounts(Y,1:N_Klassen+1); % Absolute Häufigkeit
    hy=Hy/sum(Hy)*100;              % Relative Häufigkeit
    b=bar(hy);                      % Balkendiagramm darstellen
    b.BarWidth=0.5;
    b.FaceColor = 'flat';
    for i=1:N_Klassen
        b.CData(i,:) = Farbe(i,:);
    end    
    ylabel('rel. Häufigkeit [100%]')
    set(gca,'YGrid','on');
    end