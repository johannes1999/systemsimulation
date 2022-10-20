% m-File: MembranSchwingung
%
% Darstellung einer Membranschwingung
% für Motivation Kap.7 Partielle DGLs
%
%  siehe http://www.home.hs-karlsruhe.de/~weth0002/maplegrp/Wellengleichung/Wellenquad.html
% 
% autor:	Horst Rumpf
%
% date:		2020-06-29
%
%
% siehe auch:'-'

clearvars; % Variablen löschen
close all;
Pfad='C:\Users\Horst\Documents\01_Vorlesungen\01_Studium Plus\07_System_Simulation\05_Matlab_work\Allgemeine Beispiele\';
filename=[Pfad 'Membran_1.gif'];

Pps=1/6;     % Bildrate wie bei einem Film
N=40;                       % Membran-Unterteilung x und y
xv=linspace(0,1,N);         % x-Werte
yv=linspace(0,1,N);         % y-Werte
[x, y]=meshgrid(xv,yv);     % Gitter
Omega=1/2*sqrt(5)*pi;       % Eigenfrequenz

tmax=2*pi/Omega;        % Simulations-Zeit      [s]
Nt=30;                  % Anzahl Zeitwerte
im=cell(1,Nt);          % Bilder
t=linspace(0,tmax,30);  % Zeitvektor            [s]

fig=figure; % für gif-Abspeichern     
    for i=1:Nt
        z=cos(Omega*t(i))*sin(2*pi*x).*sin(pi*y); 
            surf(x,y,z,'FaceAlpha',0.5);
            colormap(jet(255));
            set(gca,'zlim',[-1. 1.1])
            xlabel('x [cm]'); ylabel('y [cm]'); zlabel('z [mm]'); 
            title('Membranschwingung')
            axis('off')
        im{i} = frame2im(getframe(fig));   % Abspeichern der Bilder
        pause(0.001)
    end    
 % Gif speichern 
 % close all;                                    % figures schließen
 % saveGIF(filename,im,Pps);                     % gif-Datei speichern 
    