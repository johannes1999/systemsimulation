% function saveGIF(filename,im,Pps) 
%
%
% Diese function speichert ein Folge von Figures als GIF -Datei
% 
% Eingabeparameter
% filemname : Beinhaltet die Pfad und den Dateiname. Der Dateinamen
%             muss .gif enden.
% im        : Ist ein cell_array in dem die Bilder abgespeichert sind.
% Pps       : Bildrate picture per second z.B. 1/24.

% Beispiel:
%           filename='test.gif';
%           Pps=1/24;                   % Bildrate wie bei einem Film
%           t=linspace(0,2*pi,400);     % Zeitvektor
%
%           fig=figure;                 % wird zum abspeichern benötigt       
%             for i=1:10
%                 y=i*sin(t);
%                 plot(t,y,'b')
%                 set(gca,'xlim',[0 max(t)],'ylim',[-11 11]); 
%                 grid
%                 title('Variation Amplitude')
%                 im{i} = frame2im(getframe(figure));   % Abspeichern der Bilder
%             end       
%         close all;                                    % figures schließen
%         saveGIF(filename,im,Pps);                     % gif-Datei speichern  
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
% siehe auch: test_saveGIF.m
%
%--------------------------------------------------------------------------
function saveGIF(filename,im,Pps) 

N_picture=length(im);

for idx = 1:N_picture
    [A,map] = rgb2ind(im{idx},256);
    if idx == 1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',Pps);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',Pps);
    end
end
