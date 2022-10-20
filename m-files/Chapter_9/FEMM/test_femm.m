% m-file test_femm.m
%
% Beispiel zur Nutzung von femm42 mit matlab. 
% freeware download: http://www.femm.info 
% 
% Das Beispiel aus dem FEMM-Tutorial.pdf wurde in diesem m-file umgesetzt.
% Titel: DLR_School_Lab-Versuch Haftmagnet
% ----------------------------------------
%
% Auch wenn die sinnige Bearbeitungs-Reihenfolg des Beispiels mit matlab  
% anders aussehen würde haben ich mich an die Abfolge in dem Dokument
% gehalten.
%
%   1. Installation und Start der Software 
%   2. Modellierung der Geometrie 
%   3. Zuordung der Materialien bzw. Materialeigenschaften 
%   4. Berandung der Simulation zeichnen 
%   5. Werkstoff-Zuweisung 
%   6. Randbedingungen setzen 
%   7. Vernetzung und Berechung 
%   8. Ergebnisse anzeigen – Postprozessor 
%   9. Verschieben von Objekten 
%
% femm Dokumentation
%-------------------
% manual.pdf
% octavefemm.pdf
% Diese Dokument ist in dem Download enthalten.
%
% Dokumente mit Beispielen
%-------------------------
%
% Folgende hilfreiche Dokumente habe ich zugefügt
% 3_Software__FEM_-_Tutorial_-_Elektrostatik.pdf
% 4_Software__FEM_-_Tutorial_-_Elektrofluss.pdf
% 5_Software__FEM_-_Tutorial_-_Magnetfeld.pdf
% FEMM-Tutorial.pdf
% Das Beispiel aus dem FEMM-Tutorial habe ich hier umgesetzt
%
% Mit femm können folgende Aufgabe bearbeitet werden
%   - niederfrequente magnetische Felder
%   - elektrostatische Felder
%   - elektrische Flussprobleme
%   - Wärmeleitungsprobleme.
%
% Jede Aufgabenstellung hat seine eigenen Befehle.
% Sie unterscheiden sich durch die zwei Anfangbuchstaben 
%       mi_ für magnetisch
%       eo_ für elektrostatisch
%       ci_ für Stromfluss
%       hi_ für Wärmefluss
%        
%	
% Autor:	Horst Rumpf
%
%
% Datum:    2021-12-15
%
% Änderung: 
%
% siehe auch: 
%
%------------------------------------------------------------------------------------

clearvars
close all

%% 1. Installation und Start der Software
%========================================

% femm 4.2 öffnen
%-----------------
%
% Nach dem Befehl öffnet sich die Oberfläche von femm 
openfemm;% 

% File-Name
%-----------
%
% Es muss ein file gespeichert sein, damit man weiter abrbeiten kann.
% Die Endung des Files mus .fem lauten. Und es muss angegeben werden
% um welche Aufgabenstellung es sich handelt:
% Magnet Simulation, Elektrostatik oder Wärmefluss.
% Kann kann auch einen bestehenden file laden
%
Pfad='C:\Users\Horst\Documents\03_MATLAB\femm42\examples\EigeneFiles\';
name_fem='Test_Bsp_femm.fem';

NewFile=1;  % 0: bestehender File öffnen
            % 1: neuer File speichern
            
if NewFile==1
     newdocument(0);    % 0: Magnet simulation
                        % 1: Elektrostatik
                        % 2: Wärmefluss
                        % 3: Stromfluss                     
   
     mi_saveas([Pfad, name_fem]); % Hier wird ein Magnet-simulation gespeichert
      
else
    opendocument([Pfad, name_fem]); % Bestehender file öffnen
end

% Simulations Definition
%------------------------
% mi probdef(freq,units,type,precision,depth,minangle,(acsolver))
mi_probdef(0,'millimeters','planar',1e-8,20,30,0)

%% Grid size
% Das hat nichts mit dem FEM-Grid zu tun, sondern nur etwas mit
% der Zeichenfläche. Wird für die Bearbeitung von matlab aus nicht
% benötigt 

% mi_setgrid(density,'type')
mi_setgrid(1,'cart')

%%   2. Modellierung der Geometrie
%==================================

% Magnet-Kontur
%--------------
% Im Gegensatz zu der Beschreibung im FEMM-Tutorial nutze ich
% hier die Funktion mi_drawrectangle anstatt mi_drawline.
% Es gibt noch weiter gute Befehle zum Erzeugen von Konturen:
%   mi_drawarc        : Zeichnet einen Radius
%   mi_drawpolyline   : Beliebige Linie - keine geschlossene Kontur
%   mi_drawpolygon    : Geschlossene Kontur
%   mi_drawrectangle  : Rechteck    

% Koordinaten des Magneten
x_mag_l=-5; % linke untere Ecke
y_mag_l= 6;
x_mag_r= 5; % rechte untere Ecke
y_mag_r= 1;
 
% mi drawrectangle(x1,y1,x2,y2)
mi_drawrectangle(x_mag_l,y_mag_l,x_mag_r,y_mag_r)

% Gruppierung der Magnet-Kontur
%------------------------------
% Um einer Elementen gewisse Eigenschaften zuzuweisen oder sie gemeinsam
% zu verschieben müssen sie gruppiert werden. Von Hand ist das einfach
% (siehe FEMM-Tutorial). Um Elemente direk vom Programm aus zu gruppieren 
% muss man darauf achten, dass man auch nur die gewünschten Elemente
% erfasst.

Mag_Gruppe=10;  % Gruppen-Nr für den Magnente

%Elemente auswählen
 mi_clearselected;      % damit nicht vorher ausgewählte Element ausversehen mit selektiert werden
 delta=0.1;             % um den Rahmen etwas größer als den Magneten zu machen
 % mi_selectrectangle(x1,y1,x2,y2,editmode)
 mi_selectrectangle(x_mag_l-delta,y_mag_l+delta,x_mag_r+delta,y_mag_r-delta,4); % 4: alle Elemente auswählen
 mi_setgroup(Mag_Gruppe); % Gruppen-Nr. zugeordnet

% Eisenplatte-Kontur
%-------------------
% Erstellen der Konture mit mi_drawrectangle    

% Koordinaten der Eisenplatte
x_platte_l=-39; % linke untere Ecke
y_platte_l= -6;
x_platte_r= 39; % rechte obere Ecke
y_platte_r= 0;
 
% mi drawrectangle(x1,y1,x2,y2)
mi_drawrectangle(x_platte_l,y_platte_l,x_platte_r,y_platte_r)

% Gruppierung der Eisenplatte
%----------------------------
Platten_Gruppe=20;  % Gruppen-Nr für den Magnente

%Elemente auswählen
 mi_clearselected;      % damit nicht vorher ausgewählte Element ausversehen mit selektiert werden
 delta=0.1;             % um den Rahmen etwas größer als den Magneten zu machen
 % mi_selectrectangle(x1,y1,x2,y2,editmode)
 mi_selectrectangle(x_platte_l-delta,y_platte_l+delta,x_platte_r+delta,y_platte_r-delta,4); % 4: alle Elemente auswählen
 mi_setgroup(Platten_Gruppe); % Gruppen-Nr. zugeordnet

%% 3. Zuordung der Materialien bzw. Materialeigenschaften 
%========================================================

% Das selbst Erstellen einer B-K-Kurve habe ich übersrungen.
% siehe mein file my_femm_material.m.
% Ich zeige hier wie man Materialwerte aus der bestehenden Datenbank
% auswählen kann.
%-------------------------------------------------------------------
Magnet_Material='Y25';
EisenPlatte_Material='Pure Iron'; %zum Testen '1006 Steel'
Umgebung='Air';
% Mit mi_getmaterial wird das Material für die Berechnung aus der
% Datenbank zur Verfügung gestellt. Aber eine Zuordnung ist damit noch
% nicht erfolgt!
mi_getmaterial(Magnet_Material)
mi_getmaterial(EisenPlatte_Material)
mi_getmaterial(Umgebung)

%%   4. Berandung der Simulation zeichnen 
%========================================
% Kreisförmige Berandung. Man kann keinen kompellte
% Kreis auf einmal zeichen. Man muss zwei Kreisbögen
% zusammensetzten.

Berandungs_Gruppe=1000; % Gruppen-Nr für den Rand
r_boundary=80;          % Radius für die Berandung

% mi_drawarc(x1,y1,x2,y2,angle,maxseg)
  mi_drawarc(r_boundary,0,-r_boundary,0,180,1); % Halbkreis oben zeichnen
  mi_selectarcsegment(r_boundary,0);            % Halbkreis auswählen
  mi_setgroup(Platten_Gruppe);                  % Der Berandungsgruppe zuordnen
  mi_drawarc(-r_boundary,0,r_boundary,0,180,1); % Halbkreis unten zeichnen
  mi_selectarcsegment(-r_boundary,0);           % Halbkreis auswählen
  mi_setgroup(Platten_Gruppe);                  % Der Berandungsgruppe zuordnen

%%   5. Werkstoff-Zuweisung 
%==========================

% 1. Magnet
%----------

% Punkt innerhalb der Magnet-Kontur auswählen
x_mag_mitte=0;
y_mag_mitte=3.5;
Mag_ref=[x_mag_mitte y_mag_mitte]; % Magnet Referenz-Punkt

% Block Porperties für den Magnet setzen
mi_clearselected;           % evtl. alte Auswahl löschen
mi_addblocklabel(Mag_ref);  % Markierung setzen
mi_selectlabel(Mag_ref);    % Markierung auswählen

%mi setblockprop(’blockname’, automesh, meshsize, ’incircuit’, magdir, group,turns)
% blockname ist verwirrend! Hier MUSS das Materialstehen!
mi_setblockprop(Magnet_Material,1,0,'None',90,Mag_Gruppe,1)

% 2. Eisenplatte
%---------------

% Punkt innerhalb der Eisenplatten-Kontur auswählen
x_platte_mitte=0;
y_platte_mitte=-3;
Platte_ref=[x_platte_mitte y_platte_mitte]; % Magnet Referenz-Punkt

% Block Porperties für die Platte setzen
mi_clearselected;               % evtl. alte Auswahl löschen
mi_addblocklabel(Platte_ref);   % Markierung setzen
mi_selectlabel(Platte_ref);     % Markierung auswählen

%mi setblockprop(’blockname’, automesh, meshsize, ’incircuit’, magdir,group,turns)
mi_setblockprop(EisenPlatte_Material,1,0,'None',0,Platten_Gruppe,1)

% 3. Umgebung
%------------
% Punkt ausserhalb der Magnent- und Eisenplatten-Kontur auswählen
x_Rand_ref=x_mag_l-2;
y_Rand_ref=y_mag_l+2;               % Ausserhalb des Magneten und der Platte
Rand_ref=[x_Rand_ref, y_Rand_ref];  % Rand Referenz-Punkt

% Block Porperties für die Platte setzen
mi_clearselected;            % evtl. alte Auswahl löschen
mi_addblocklabel(Rand_ref);  % Markierung setzen
mi_selectlabel(Rand_ref);    % Markierung auswählen

%mi setblockprop(’blockname’, automesh, meshsize, ’incircuit’, magdir,group,turns)
mi_setblockprop(Umgebung,1,0,'None',0,Berandungs_Gruppe,1)

%%   6. Randbedingungen setzen 
%=============================

% Dieser Schritt ist in der Ausführung nicht kompliziert, aber der
% physialisch und simulationstechnische Hintergrund ist sehr komplex!
% Siehe 5_Software__FEM_-_Tutorial_-_Magnetfeld.pdf und manual.pdf usw.

% Parameter für die Randbedingug 
 uo=4*pi*1e-7;       % Induktionskonstante [T/(A/m)]
 c0=1/(uo*r_boundary*1e-3);   % [A/(Vs])
 c1=0;

% Randbedingungen zuordnen
% mi addboundprop(’propname’, A0, A1, A2, Phi, Mu, Sig, c0, c1, BdryFormat, ia, oa)
% propname: Hier einen Name festlegen. Mit diesem erfolgt die Zuweisung zu
%           den Randelementen.

mi_addboundprop('RobinBC', 0, 0, 0, 0, 0, 0, c0, c1, 2);
mi_clearselected;
mi_selectgroup(Berandungs_Gruppe)
mi_setarcsegmentprop( 3 ,'RobinBC' , 0 , Berandungs_Gruppe ); 
% Oberer Kreis 
%             mi_drawarc(r_boundary,y_0_boundary,-r_boundary,y_0_boundary,180,3); 
%             mi_selectarcsegment(r_boundary,y_0_boundary);
%             mi_setarcsegmentprop( 3 ,'RobinBC' , 0 , Boundary_Gruppe ); 

%%   7. Vernetzung und Berechung 
%===============================
% mit smartmesh wird ein FEM-Netz generiert. Das ist aber nicht explizit zu
% machen, denn mit den nächsten Schritt mi_analyze(1) wird das sowieso
% gemacht.
% Wird eine Verfeinerung benötigt kann das bei den Blockproperties angegeben werden. 
% mi_setblockprop(’blockname’, automesh, meshsize, ’incircuit’, magdir, group, turns)
% mit automesh=0, meshsize=0.5 z.B. Was diese Zahl besagt habe ich noch nicht rausgefunden.
% In der femm-Oberfläche kann durch Drücken der F3 Taste das Gitter verfeinert werden.
% Vorsicht! Bei jedem mal F3-Taste wird das Gitter weiter verfeinert.
% Wenn man vor mi_analayze einen Brakepoint setzt hat man die Möglichkeit das zu tun.

smartmesh(1); % 0: smartmesh ausgeschaltet 1: eingeschaltet
mi_analyze(1);% 0: solver window wird gezeigt 1: window minimiert

%%   8. Ergebnisse anzeigen – Postprozessor 
%==========================================
% mit mi_loadsolution stehen die Ergebnisse zur Verfügung und man kann sich
% das Ergebnis in dem femm-Fenster ansehen und verschiedene Werte sich
% anzeigen lassen.
% Mit P=mo_getpointvalues(x,y) kann man Werte des Punktes (x|y) übernehmen.
% P ist ein Vektor mit verschieden Werten (siehe octavefemm Seite 16) 
% Z.B. Bx und By stehen in P(2), P(3).

 mi_loadsolution;

% Das Ergebnis ist im femm-Fenster zu sehen

% Berechnung der Magnetkraft 
%---------------------------
mo_selectblock(Mag_ref);
Fx=mo_blockintegral(18);    % x part of steady-state weighted stress tensor force
Fy=mo_blockintegral(19);    % y part of steady-state weighted stress tensor force

disp(['F_x= ' num2str(Fx) 'N'])
disp(['F_y= ' num2str(Fy) 'N'])
% Darstellung des Betrages der magnetischen Flussdichte |B|im Luftspalt
%----------------------------------------------------------------------

% 1. Die Darstellung erfolgt im femm Fenster
%-------------------------------------------
x_fluss_l=-5;
y_fluss_l=0.5;
x_fluss_r=5;
y_fluss_r=0.5;

% % Linie entlang der |B| dargestellt werden soll
% mi_drawline(x_fluss_l,y_fluss_l,x_fluss_r,y_fluss_r);
% mi_drawline wird nur die Linie einzeichen um zu sehen wo die Werte
% ermittelt werden.

mo_addcontour(x_fluss_l,y_fluss_l)
mo_addcontour(x_fluss_r,y_fluss_r);
PlotType=1; % 0 Potential
            % 1 |B|
            % 2 B*n
            % 3 B*t
            % 4 |H|
            % 5 H*n
            % 6 H*t
            % 7 Jeddy
            % 8 Jsource+Jeddy
 NumPoints=400;           
 % mo_makeplot(PlotType,NumPoints,Filename,FileFormat)
 mo_makeplot(PlotType,NumPoints)
 
% 2. Die Darstellung in Matlab
%------------------------------ 
% Hierzu müssen entlang der Linie alle Werte eingelesen werden.
% mit mo_getpointvalues 14 verschiedene Werte gelesen. 
% (siehe octavefemm Seite 16) Z.B. Bx und By stehen in P(2), P(3).

x_Pos=linspace(x_fluss_l,x_fluss_r,NumPoints);
y_Pos=linspace(y_fluss_l,y_fluss_r,NumPoints);
B_abs=zeros(size(x_Pos));
for i=1:NumPoints
    P=mo_getpointvalues(x_Pos(i),y_Pos(i));
    B_abs(i)=sqrt(P(2)^2+P(3)^2);
end
 figure
  plot(x_Pos,B_abs,'b')
  grid
  xlabel('x-Position [mm]')
  ylabel('|B| [T]')
%%   9. Verschieben von Objekten 
%===============================

% Als Beispiel wird der Magnet in y-Richtung verschoben und in jeder Position die Magnetkraft bestimmt.
% Hier gibt den ein- oder anderen Fallstrick. Deswegen hab ich dieses Beispiel gegenüber dem Beispiel
% in FEMM-Tutorial.pdf erweitert.

 y_hub=10;  % Verschiebung in y-Richtung
 N_sim=20;  % Anzahl der Simulationsschritte 
 Fx=zeros(1,N_sim);
 Fy=zeros(1,N_sim);
 dy=y_hub/N_sim;    % Schrittweite      
 y=0:dy:N_sim*dy;   % y-Positionen
 
    for i=1:N_sim+1
        mi_analyze(1);              % Analyse starten
        mi_loadsolution;            % Ergebnis lade,
        mo_selectblock(Mag_ref);    % Magnet auswählen. Hier wir ein Punkt im Magnet ausgewählt!
        Fx(i)=mo_blockintegral(18); % x part of steady-state weighted stress tensor force
        Fy(i)=mo_blockintegral(19); % y part of steady-state weighted stress tensor force
        
        mi_selectgroup(Mag_Gruppe); % Magnet-Kontur auswählen. Hier wird die Gruppe ausgewählt!
        mi_movetranslate(0,dy)      % Magnet relativ in y-Richtung schieben
        Mag_ref(2)=Mag_ref(2)+dy;   % Der Punkt innerhalb des Magenten muss mit verschoben werden
                                    % weil für mo_selectblock nicht der Blockname genutzt werden 
                                    % kann, sondern ein Punkt innerhalb des Blockes benötigt wird.
    end   
    
  figure
  plot(y,Fx,'b',y,Fy,'r')
  grid
  xlabel('y-Position [mm]')
  ylabel('F [N]')  
  legend('F_x', 'Fy')
  title('Magnetkraft')