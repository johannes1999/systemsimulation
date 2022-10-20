% m-file TaylorAnimation
%
% Animation zum Taylor-Reihe
% Mit einer beliebigen Taste wird weitergeschaltet!
% Die Sinus-Funktion wird durch eine Polynom-Reihe angenähert.
% 
%
% Eingabe:          
% 
% Beispiel:
%         
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%           Kapitel  2.4 Differentiation 
%
% Datum:    2020-05-23
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars
close all
 % für gif-Datei speichern
 filename='TaylorReihe.gif';
 Pps=1/1;     % Bildrate wie bei einem Film
        
N=400;                          % Anzahl Werte
n_grad=20;                      % Grad des Polynoms
a=zeros(1,n_grad);              % Koeffizienten des Polynoms
k=0;                            % Schleifenzähler für Vorzeichenwechsel
for i=1:2:n_grad                % Koeffizienten der sin-Talyor-Reihe
    k=k+1;
    a(i)=(-1)^k/factorial(n_grad-i);
end    

x_min=0;                        % x-Werte
x_max=2*pi;
x=linspace(x_min,x_max,N);
y=sin(x);                       % Funktionswerte

y_max=max(y);                   % Grenzen für die Darstellung
x_lim=[x_min x_max+0.2];
y_lim=[-1.1 1.1];

fig=figure;
Ni=0;
for i=n_grad-1:-2:1
    Ni=Ni+1;
    hold off                    % Bild neu
    plot(x,y,'b','LineWidth',1.5);
    set(gca,'xlim',x_lim,'ylim',y_lim)
    axis('off')
    hold on
    plot(x_lim,[0 0],'k','LineWidth',0.5);  %x-Achse
    plot([0 0],y_lim,'k','LineWidth',0.5);  %y-Achse
    text(x_max+0.1,-0.05,'x','FontSize',14,'HorizontalAlignment','center')
    text(-0.15,1,'y','FontSize',14,'HorizontalAlignment','center')
    % Taylor-Polynom 
    y_TR=polyval(a(i:end),x);   
    plot(x,y_TR,'r','LineWidth',1.0);          
    pause; % mit beliebiger Taste weiter
    im{Ni} = frame2im(getframe(fig));   % Abspeichern der Bilder
end
     
% Gif Speichern 
% close all;                                    % figures schließen
% saveGIF(filename,im,Pps);                     % gif-Datei speichern 