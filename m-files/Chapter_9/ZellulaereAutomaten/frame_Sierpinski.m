% m-file: frame_Sierpinski.m	
% 
% Übungs-file für Kapitel 9.1 Zelluläre Automaten
% Erzeugung des Sierpinski-Dreiecks mit einem Zellulären Automaten
% Hier sind nur die Werte und die Ausgabe definiert. Der Algorithmus 
% ist noch zu schreiben
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation Kapitel 9 SoSe 2020 erstellt.
%
% Datum:    2020-09-11
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars
close all

% Sierpinski-Dreieck 
%===================
    
n_z=400;     % Anzahl Zeilen
m_s=401;     % Anzahl Spalten
  
SP=zeros(n_z,m_s);        % alle Werte Null
SP(1,floor(m_s/2))=1;    % Oberer mittlerer Wert gleich 1

% Hier können Sie Ihren Algorithmus hinschreiben.
%------------------------------------------------




%------------------------------------------------

% Ausgabe
%--------

% Colormap
%---------
     %  R    G   B
map = [1.0  1.0 1.0     % Hintergrund Weiß
       0.0  0.0 1.0];   % Punkte      Blau    
figure 
  colormap(map);	
  image(SP,'CDataMapping','scaled') 
  axis('equal')
  axis('off')
  title('Sierpinsky mit image-Befehl') 