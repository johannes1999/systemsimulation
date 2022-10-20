% m-file cell_ForestFire.m
%
% Zellularer Automat 
%
% Beispiel-file f�r Kapitel 9.1 Zellul�re Automaten
%                  
% Autor:	
%           (Siehe auch http://bit.ly/2wu1dUL)

%           Dieser m-File wurde im Rahmen einer Haus�bung f�r die Vorlesung
%           Strukturelle und funktionale Systemsimulation SoSe 2017 erstellt.
%           
%
% Datum:    2017-08-19
%
% �nderung: Dieser m-file wurde �berarbeitet und auskommentiert
%           2020-08-03 Kommentare �berarbeitet
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace l�schen. 

N_iter=2000;     % Anzahl der Simulationen

% Gr��e des Feldes
m= 100;
n= 100;
Ncell = m*n; % Anzahl der Zellen 
% Initialisieren der Werte
% 0: kein Baum          (Schwarz)
% 1: Baum               (Gr�n)
% 2: Brennender Baum    (Rot)

f=0.00001;              % Wahrscheinlichkeit f�r ein Feuer
p=0.001;                % Wahrscheinlichkeit f�r das nachwachsen eines Baumes
FF=randi([0 1],m,n);    % Gleichverteilung von B�umen als Startwert
                        % 0: Erde 
                        % 1: Baum
                        % 2: Brennender Baum
FF_neu=zeros(m,n);      % Matrix um Werte bei der Zwischenrechnung
                        % zu speichern ohne die vorherigen Werte zu
                        % �berschreiben.

% Colormap
%---------
map = [0.  0.0 0.0      % Hintergrund     Schwarz
       0.2 0.8 0.2      % B�ume           Gr�n 
       1.0 0.2 0.0];    % Brennende B�ume Rot

figure 
colormap(map);

for i=0:N_iter  % Anzahl Simulationen
    
  cnt_alive=0;  % Z�hler f�r neue B�ume
  cnt_dead=0;   % Z�hler f�r sterbene B�ume

  dead_rnd=1+round(rand(Ncell,1)*(0.5+f));  % mit der Wahrscheinlichkeit f schl�gt ein Blitz ein
                                            % d.h. dead_rnd=2
  alive_rnd=round(rand(Ncell,1)*(0.5+p));   % mit der Wahrscheinlichkeit p entsteht ein neuer Baum
                                            % d.h. alive_rnd=1
  pause(0.01);
  
  for z=2:m-2
    for s=2:n-2
      if FF(z,s)==0                         % Hier steht noch kein Baum
        cnt_alive=cnt_alive+1;
        FF_neu(z,s)=alive_rnd(cnt_alive);   % Random einen neuen Baum entsteht
      elseif FF(z,s)==1                     % Hier steht ein nichtbrennender Baum
                                            % Brennt ein (Neumann) benachbarter Baum?
        if FF(z-1,s)==2 || FF(z+1,s)==2 || FF(z,s-1)==2 || FF(z,s+1)==2
          FF_neu(z,s)=2;                           % Wenn ja, dann den aktuellen Baum auch brennen lassen
        else
          cnt_dead=cnt_dead+1;              % Zuf�llig einen Blitz einschlagen lassen
          FF_neu(z,s)=dead_rnd(cnt_dead);
        end
      else                                  % Baum hat in der letzten Runde gebrannt!
        FF_neu(z,s)=0;                      % Brennender Baum ist gestorben
      end
    end
  end
  
  FF = FF_neu;                              % neuer Stand als aktuellen Stand speichern
  image(FF+1)                               % Bild darstellen
 
 
end