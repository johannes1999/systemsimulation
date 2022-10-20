% m-file: cell_Sierpinski.m	
% 
% Beispiel-files für Kapitel 9.1 Zelluläre Automaten
% Erzeugung des Sierpinski-Dreiecks mit einem Zellulären Automaten
% 
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation Kapitel 9 SS 2020 erstellt.
%
% Datum:    2020-07-15
%
% Änderung: 2020-09-10 verschiedene Plot-Befehle zugefügt
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
     
    for z=2:n_z          % Zeilen
        for s=2:m_s-1    % Spalten
            if (SP(z-1,s-1)) ~= (SP(z-1,s+1)) % Sind die oben diagonal anliegenden Zellen ungleich?
                SP(z,s)=1;
            end      
        end
    end
    
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
      
figure
  colormap(map);	 
  s=pcolor(flipud(SP));
  s.LineStyle='none';
  axis('equal')
  axis('off')
  title('Sierpinsky mit pcolor-Befehl')
   
figure
  [j,k] = find(SP==1);
  plot(k,m_s-j,'. b', 'MarkerSize',0.1)   
  axis('equal')
  axis('off')
  title('Sierpinsky mit plot-Befehl')