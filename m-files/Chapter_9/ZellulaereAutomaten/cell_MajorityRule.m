% m-file: cell_MajorityRule.m	
% 
% Beispiel-files für Kapitel 9.1 Zelluläre Automaten
% Nachbarschaft	: Moore
% Zustandsmenge	: Q={1, 2, 3, 4, 5}
% Regel 	    : Deterministisch
% 				  Die Zelle nimmt den Wert der Zellen an, 
%                 die in der Mehrheit sind. 
%                 Der Wert der Zelle wird berücksichtigt.				  	  
%                 Sind mehrere Gruppen mit der maximalen Mehrheit vorhanden
%                 behält die Zelle ihren Wert. 			
% Berandung		: Mit Grenzen
% Anfangswerte	: Zufällig-gleichverteilte Werte im ganzen Feld     
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
 
% Majority-Rule 
%==============
        
Nz=101;             % Anzahl Zeilen
Ns=101;             % Anzahl Spalten
        
N_iter=200;         % Max. Anzahl Iterationen
N_ist=0;            % Schleifenzähler
NoChanges=0;        % Variable für Abfrage auf stationären Zustand
AnzahlParteien=5;   %
c_m=[0 0 1 ;0 1 0;1 0 0;0.5 0.5 0.5;1 0.82 0]; % color map: Farben für jede Partei

MR=randi([1, AnzahlParteien],Nz,Ns);  % zufällige Verteilung
MR_neu=MR;                            % Matrix um Werte bei der Zwischenrechnung
                                      % zu speichern ohne die vorherigen Werte zu
                                      % überschreiben.
% Anfangszustand
 figure(1)
 subplot(2,2,1)
    imagesc(MR);
    colormap(c_m(1:AnzahlParteien,:)) 
    axis('equal')
    axis('off')
    title('Majority-Rule: Anfangs-Muster')
 subplot(2,2,3)
    plotBar(MR,AnzahlParteien,c_m)% Histogramm darstellen
    title('Mehrheitsverteilung am Anfang');
    
figure(2) 
% Iterationen
%------------
while ((N_ist < N_iter) && (NoChanges == 0))  
    N_ist=N_ist+1;  % Schleifenzäher    
      imagesc(MR);
      colormap(c_m(1:AnzahlParteien,:)) 
      axis('equal')
      axis('off')
      title(['Majority-Rule Iterations: ' num2str(N_ist) '/ max.' num2str(N_iter)])
    pause(0.1)
            
    for z=2:Nz-1        % Zeilen
        for s=2:Ns-1    % Spalten         
            Nachbarn_p=MR(z+[-1 0 1],s+[-1 0 1]);   % Alle 9 Zellen
            Nachbarn=Nachbarn_p(:)';                % als Vektor (mit allen 9 Zellen
             %Nachbarn=Nachbarn([1 2 3 4 6 7 8]);   % ohne die mittlere Zelle
                                                    % D.h. ohne eigene Meinung
            %[H,x]=hist(Nachbarn,1:AnzahlParteien); % Häufigkeiten mit hist berechnet
            [H,x]=histcounts(Nachbarn,1:AnzahlParteien+1);
            [AnzahlMehrheit,pos]=max(H);            % max. Häufigkeit
                   
            [~,pos_equal]=find(H==AnzahlMehrheit);  % Gibt es eine Partei mit gleicher
            change=length(pos_equal);               % max. Häufigkeit? d.h. change > 1                                                                            
                if change==1                        % Nein?
                    MR_neu(z,s)=x(pos);             % Dann ändern.
                end 
        end
    end
        if isequal(MR,MR_neu)
            NoChanges=1;        % Hat sich das Bild verändert?
        end    
    MR=MR_neu;                  % Neue Werte speichern
end % End While

% Endzustand
figure(1)
 subplot(2,2,2)
    imagesc(MR);
     colormap(c_m(1:AnzahlParteien,:)) 
    axis('equal')
    axis('off')
    title(['Mehrheitsverteilung nach' num2str(N_ist) ' Iterationen']);
 subplot(2,2,4)
   plotBar(MR,AnzahlParteien,c_m)% Histogramm darstellen
   title('Mehrheitsverteilung am Ende');
   
%% Histogramm farbig darstellen
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
    