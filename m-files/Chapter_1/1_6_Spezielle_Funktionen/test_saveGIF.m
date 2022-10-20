% m-file test_saveGIF
%
%
% Dieser m-file zeigt wie eine gif Datei mit der function saveGIF 
% erzeugt und gespeichert wird.
% 
% Eingabeparameter für die function saveGIF
%
% filemname : Beinhaltet die Pfad und den Dateiname. Der Dateinamen
%             muss .gif enden.
% im        : Ist ein cell_array in dem die Bilder abgespeichert sind.
% Pps       : Bildrate picture per second z.B. 1/24.


%
% 
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%
% Datum:    19-12-2019
%
% Änderung: 
%
% siehe auch: function saveGIF.m
%
%--------------------------------------------------------------------------
% Beispiel:
Pfad='C:\Users\Horst\Documents\01_Vorlesungen\01_Studium Plus\07_System_Simulation\05_Matlab_work\Chapter_1\1_6_Spezielle_Funktionen\';
cd(Pfad);                    % Wechselt das directory
filename='test_gif.gif';

Pps=1/24;                   % Bildrate wie bei einem Film
t=linspace(0,2*pi,400);     % Zeitvektor
          
% Amplituden Variation
Nvar=50;                    % Viertel der Anzahl Bilder
A=linspace(0,10,Nvar);
A=[A A(end:-1:1) -A -A(end:-1:1)]; 
          
fig=figure;                 % wird zum abspeichern benötigt       
    for i=1:length(A)
        y=A(i)*sin(t);
        plot(t,y,'b')
        set(gca,'xlim',[0 max(t)],'ylim',[-11 11]); 
        grid
        title('Variation Amplitude')
        
        im{i} = frame2im(getframe(fig));   % Abspeichern der Bilder
    end
close all;                                  % figures schließen

saveGIF(filename,im,Pps);                   % gif-Datei speichern  
