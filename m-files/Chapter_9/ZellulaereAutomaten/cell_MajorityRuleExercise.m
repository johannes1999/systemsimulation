% m-file: cell_MajorityRuleExercise.m
% 
% �bung zum Kapitel 9.1 Zellul�re Automaten
% 
% siehe MajorityRules.m
% zu diesem Zellul�ren Automaten sollen einige Varianten realisiert werden.
%
% Ausgangsbedignungen Majority Rule
% Nachbarschaft	: Moore
% Zustandsmenge	: Q={1, 2, 3, 4, 5}
% Regel 	    : Deterministisch
% 				  Die Zelle nimmt den Wert der Zellen an, 
%                 die in der Mehrheit sind. 
%                 Der Wert der Zelle wird ber�cksichtigt.				  	  
%                 Sind mehrere Gruppen mit der maximalen Mehrheit vorhanden
%                 beh�lt die Zelle ihren Wert. 			
% Berandung		: Mit Grenzen
% Anfangswerte	: Zuf�llig-gleichverteilte Werte im ganzen Feld     
%
% Basierend auf der Majority-Rule k�nnen eigene �berlegungen abgeleitet werden:
% 1. Wieso l�sst sich eine Zelle durch die umgebende Mehrheit �berreden? 
%    Mitglieder einer Partei sind st�rker von ihrem Standpunkt �berzeugt 
%    als andere. Dieses Verhalten kann durch eine Gewichtung der abgefragten 
%    Zelle ber�cksichtigt werden.
%
% 2. Es tritt ein Stillstand ein, 
%    aber dann trifft eine Partei den Nerv der Zeit.
%    Zum Beispiel die kleinste Partei. Das Treffen des Nervs kann durch 
%    einen Faktor nachempfunden werden. 
%
% 3. Es entsteht eine sehr kleine neue Partei, die den Nerv der Zeit trifft.
%    Wie �berzeugend muss sie sein, um zu �berleben oder die Mehrheit zu bekommen?  
%
% Beispielhaft wurde hier folgendes Szenario realisiert:
% Nach <N_Aenderung> Iterationsschritten �ndert sich die �berzeugungskraft der Partei
% <P_plus> um den Faktor <EigeneUeberzeugung>.
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation Kapitel 9 SoSe 2020 erstellt.
%
% Datum:    2020-08-14
%
% �nderung: 
%
% siehe auch: cell_MajorityRule.m	
%--------------------------------------------------------------------------
clearvars
close all
 
% Majority-Rule 
%==============
        
Nz=51;                  % Anzahl Zeilen
Ns=51;                  % Anzahl Spalten
Nzellen=Ns*Nz;
N_iter=100;             % Max. Anzahl Iterationen
N_ist=0;                % Schleifenz�hler
NoChanges=0;            % Variable f�r Abfrage auf station�ren Zustand

N_Aenderung=15;         % Ab diesem Wert hat die
P_plus=2;               % Partei P_plus einen
EigeneUeberzeugung=1.02; % �berzeugungsfaktor ungleich 1 

AnzahlParteien=5;   %
c_m=[0 0 1 ;0 1 0;1 0 0;0.5 0.5 0.5;1 0.82 0]; % color map: Farben f�r jede Partei

MR=randi([1, AnzahlParteien],Nz,Ns);  % zuf�llige Verteilung
MR_neu=MR;                            % Matrix um Werte bei der Zwischenrechnung
                                      % zu speichern ohne die vorherigen Werte zu
                                      % �berschreiben.
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
    N_ist=N_ist+1;  % Schleifenz�her      
    imagesc(MR);
      colormap(c_m(1:AnzahlParteien,:)) 
      axis('equal')
      axis('off')
      title(['Majority-Rule Iterations: ' num2str(N_ist) '/ max.' num2str(N_iter)])
    pause(0.01)
            
    for z=2:Nz-1        % Zeilen
        for s=2:Ns-1    % Spalten         
            Nachbarn_p=MR(z+[-1 0 1],s+[-1 0 1]);           % Alle 9 Zellen
            Nachbarn=Nachbarn_p(:)';                        % als Vektor  
            [H,x]=histcounts(Nachbarn,1:AnzahlParteien+1);  % H�ufigkeiten
            %[H,x]=hist(Nachbarn,1:AnzahlParteien); alte Berechnung mit hist
            
            % �nderung
            %=========
            if N_ist==N_Aenderung
                MR2=MR;             % Aktueller Stand speichern
            end
            
            % �berzeugungsfaktor der Partei Nummer P_plus zugef�gt
            %------------------------------------------------------
            if N_ist > N_Aenderung
                    H(P_plus)=H(P_plus)*EigeneUeberzeugung;
                    % Die absolute H�ufigkeit der Partei P_plus wird mit
                    % dem �berzeugungsfaktor multiplizieren
            end    
            %=======
            
            [AnzahlMehrheit,pos]=max(H);            % max. H�ufigkeit
                   
            [~,pos_equal]=find(H==AnzahlMehrheit);  % Gibt es eine Partei mit gleicher
            change=length(pos_equal);               % max. H�ufigkeit? d.h. change > 1                                                                            
                if change==1                        % Nein?
                    MR_neu(z,s)=x(pos);             % Dann �ndern.
                end 
        end
    end
       if  isequal(MR,MR_neu) && (N_ist > N_Aenderung)  % Hat sich das Bild
            NoChanges=1;                                % nachdem der �berzeugungsfaktor
       end                                              % sich ge�ndert hat ge�ndert
       
    MR=MR_neu;      % Neuer Werte speichern
end % End While

% Endzustand
figure(3)
 subplot(2,2,1)
    imagesc(MR2);
     colormap(c_m(1:AnzahlParteien,:)) 
    axis('equal')
    axis('off')
    title(['Verteilung nach' num2str(N_Aenderung) ' Iterationen']);
 subplot(2,2,3)
   plotBar(MR2,AnzahlParteien,c_m)% Histogramm darstellen
   title('Verteilung vor der �nderung');

 subplot(2,2,2)
    imagesc(MR);
     colormap(c_m(1:AnzahlParteien,:)) 
    axis('equal')
    axis('off')
    title(['Verteilung nach' num2str(N_ist) ' Iterationen']);
 subplot(2,2,4)
   plotBar(MR,AnzahlParteien,c_m)% Histogramm darstellen
   title(['�berzeugungsfaktor der Partei Nr.'...
           num2str(P_plus) '= ' num2str(EigeneUeberzeugung)]);
   

%% Histogramm farbig darstellen
%------------------------------
function []=plotBar(Y,N_Klassen,Farbe)
    
[Hy,~]=histcounts(Y,1:N_Klassen+1); % Absolute H�ufigkeit
    hy=Hy/sum(Hy)*100;              % Relative H�ufigkeit
    b=bar(hy);                      % Balkendiagramm darstellen
    b.BarWidth=0.5;
    b.FaceColor = 'flat';
    for i=1:N_Klassen
        b.CData(i,:) = Farbe(i,:);
    end    
    ylabel('rel. H�ufigkeit [100%]')
    set(gca,'YGrid','on');
    end
    