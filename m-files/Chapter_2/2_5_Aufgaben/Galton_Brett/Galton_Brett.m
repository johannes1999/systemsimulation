% m-file: Galton_Brett.m
%
% - zeigt die verschiedenen Umsetzung des Galton-Brettes mit 
%   Matlab.
%
% Galton Brett siehe Wikipedia https://de.wikipedia.org/wiki/Galtonbrett
% 
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2018 erstellt.
%
% Datum:    2018-03-23
%           2020-05-12  case 4 zugefügt und 
%                       die Wahrscheinlichkeit p variabel gestaltet
% Benötigte function für case 4: circle, rotation
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen

% Vorgabe
%--------

m=10;    % Anzahl Stufen des Galton-Brettes
n=1000000;  % Anzahl der Versuche (Bernoulli)
p=0.5;  % Wahrscheinlichkeit ob die Kugel
        % nach links oder rechts fällt
        
% Umsetzung
%------------
um=3;   % 1: zwei Schleifen
        % 2: eine Schleife
        % 3: ohne Schleife
        % 4: Animation Galton-Brett (in Arbeit!)
       
        
switch um
    case 1  % Umsetzung mit zwei Schleifen
    %=====    
        V=zeros(n,1);   % Ergebnis der n Versuche
        for k=1:n       % Anzahl Versuche
            pos=0;      % Position der Kugel in der Mitte
            for l=1:m   % Anzahl Stufen
                 L_or_R=2*(rand<=p)-1;  % die Kugel fällt um Eins nach
                                        % Links oder Rechts    
                pos=pos+L_or_R;         % Position der Kugel
            end     
            V(k)=pos;
        end

        figure
            histogram(V,-m-0.5:m+0.5)       % Der Versatz um 0.5 ist notwendig
                                            % um die Balken auf die Mitte zu setzen 
            xlabel('Position');
            ylabel('Anzahl Kugeln')
        
    case 2  % Umsetzung mit einer Schleifen
    %=====
        V=zeros(n,1);   % Ergebnis der n Versuche
        for k=1:n       % Anzahl Versuche(Kugeln)
            % der Vektor L_R enthält alle Werte für den Durchlauf einer Kugel
            L_or_R=2*(rand(m,1)<=p)-1;
            V(k)=sum(L_or_R);               % Position der Kugel
        end
        figure
            histogram(V,-m-0.5:m+0.5)       % Der Versatz um 0.5 ist notwendig
            xlabel('Position');
            ylabel('Anzahl Kugeln')
        
    case 3
    %=====
        figure
        histogram(sum(2*(rand(m,n)<=p)-1),-m-0.5:m+0.5)      
        xlabel('Position');
        ylabel('Anzahl Kugeln')
        % Es werden alle n-Versuche und alle m Stufen direkt in einer
        % Matrix dargestellt(m,n Matrix) sign(rand(m,n)-0.5).
        % Die Zeilen entsprechen dem Fallen der Kugeln nach links oder 
        % rechts(-1 oder 1)in jeder Stufe und die Spalten den n Versuchen
        % Die Endpositionen der Kugeln wird durch die Summation über die 
        % Spalten ermittelt und deren Verteilung in dem Histogramm über 
        % die möglichen Positionen (von -m bis m) dargestellt. 
        
   case 4
   %=====
   % IN ARBEIT
   % Animation Galton Brett
   %-----------------------
   % für gif-Datei speichern
    filename='Galton.gif';
    Pps=1/24;                   % Bildrate wie bei einem Film
    
    plotH=0;% 0: kein Histogramm plotten
            % 1: Histogramm plotten
            
    m=8;    % Anzahl Stufen des Galton-Brettes
    n=5;    % Anzahl der Versuche (Bernoulli)
    p=0.5;  % Wahrscheinlichkeit Fallen nach rechts     
    
    % IDEE: Die circle-Berechnung durch 
    % {rectangle('Position',[-1 -1 2 2],'Curvature',[1 1],'FaceColor',[1 0 0],'EdgeColor','none')
    % ersetzen und die Rotations und Translationsmatrix direkt oder in
    % einer internen function
    
    % Raster
    % ------
    %
    % Weiterverwendete Variablen:
    %  Npins: Anzahl Pins
    %  x_r, y_r     : Pin Positionen
    %  c_pin_0(1:x 2:y,101 Kreispunkte,Npins)
    %
    %-----------------------------------------
    x_Raster=1;
    y_Raster=sqrt(3)*x_Raster;
    dy_Raster=y_Raster-x_Raster;
    R_pin=0.2*x_Raster;
    R_ball=x_Raster-R_pin;
   
    % Nullposition Pin
    c_pin_0=circle(0,0, R_pin, 0, 2*pi);
    
    % x-y Raster-Punkte
    %------------------
    x=0; 
    y=m;
    for i=m-1:-1:1      
        x=[x -m+i:2:m-i];
        y=[y i*ones(1,m-i+1)];
    end
    
    % Raster Koordinaten
    %-------------------
    x_r=x_Raster*x;     % Rasterpositionen
    y_r=y_Raster*y;     %       -"-
    Npins=length(x_r);  % Anzahl Pins
    
    % Limits für den Plot
    x_lim=[min(x_r)-2*R_ball-R_pin max(x_r)+2*R_ball+R_pin];
    y_lim=[min(y_r)-2*R_ball-R_pin max(y_r)+2*R_ball+R_pin];
    
    % Kreise an den Rasterpunkten
    for i=1:Npins
     c_pin_0(:,:,i)=circle(x_r(i),y_r(i), R_pin, 0, 2*pi);
    end
    % -----------------------------------------------------
  
    % Kugel Nullposition und Bewegungspunkte 
    % für das Fallen nach links und rechts
    %
    % Weiterverwendete Variablen: 
    %   Nges: Anzahl der Bewegungspunkte von einem Pin zum nächsten
    %   c_ball_li(1=x, 2=y, 101 Kreispunkte, Nges Positionen)
    %   c_ball_re(:,:,:)
    
    Nrot=6;                         % Rotation
     Al=linspace(0,pi/2,Nrot);      %   -"-
    Ntr=2;                          % Translation
    dy=linspace(0,-dy_Raster,Ntr);  %   -"-
    Nges=Nrot+Ntr;                  % Anzahl Bewegungspunkte 
    
    c_ball_li=zeros(3,101,Nges);    % Positionen Kugel fällt nach links
                                    % c_ball_re: fällt nach rechts
                                    
    c_ball_0=circle(0,x_Raster, R_ball, 0, 2*pi); % Nullposition der Kugel
    
    for i=1:Nrot % Rotation
        c_ball_li(:,:,i)=rotation(Al(i))*c_ball_0;
    end
    for i=1:Ntr % Translation
      c_ball_li(:,:,Nrot+i)=trlate(0,dy(i))*c_ball_li(:,:,Nrot);
    end
    c_ball_re=c_ball_li;                    % Positionen Kugel fällt nach rechts
    c_ball_re(1,:,:)= -c_ball_re(1,:,:);    %    -"-
    %---------------------------------------------------------------------------
    Nr=0;
    for k=1:n % Durchlauf von n Kugeln
    % Darstellung
    %------------
        %fig=figure; % Füf gif Speichern
        figure(1); % Darstellung
        if plotH==1
            subplot(2,1,1)
        end
        set(gca,'xlim',x_lim,'ylim',y_lim)
        axis('equal')
        axis('off')
        hold on;
    
        % Darstellung Raster 
        for i=1:Npins    
            fill(c_pin_0(1,:,i),c_pin_0(2,:,i),'b')
        end
        
        % Kugel darstellen
        %L_or_R=sign(round(rand(m,1))-0.5); % Kugel fällt 
        L_or_R=2*(rand(m,1)<=p)-1;              
        V(k)=sum(L_or_R);                  % Position der k-ten Kugel
        x_k=x_Raster*cumsum([0 L_or_R']);
        y_k=y_Raster*(m:-1:1);
    
        for z=1:m           % Durchlauf einer Kugel       
            for i=1:Nges    % Bewegung auf den nächsten Pin
                if i>1      % Vorherige Kugeldarstellung löschen
                    fill(c_ball_xy(1,:,i-1),c_ball_xy(2,:,i-1),[0.94 0.94 0.94],'LineStyle','none')
                end 
         
                if L_or_R(z)<1 % Kugel fällt nach linkes oder rechts
                    c_ball_xy(:,:,i)=trlate(x_k(z),y_k(z))*c_ball_li(:,:,i);  
                    fill(c_ball_xy(1,:,i),c_ball_xy(2,:,i),'r','LineStyle','none')
                else  
                    c_ball_xy(:,:,i)=trlate(x_k(z),y_k(z))*c_ball_re(:,:,i);  
                    fill(c_ball_xy(1,:,i),c_ball_xy(2,:,i),'r','LineStyle','none')  
                end   
                set(gca,'xlim',x_lim,'ylim',y_lim)
                Nr=Nr+1;
                %im{Nr} = frame2im(getframe(fig));   % Abspeichern der Bilder
                if i>1 && i<Nges
                   pause(0.0);
                end 
            end
            %pause(0.2)
            fill(c_ball_xy(1,:,end),c_ball_xy(2,:,end),[0.94 0.94 0.94],'LineStyle','none')
   
        end
        if plotH==1
            subplot(2,1,2)
            histogram(V,-m:m,'FaceColor','r')                       % Verteilung darstellen
            xlabel('Position');
            ylabel('Anzahl Kugeln')
            set(gca,'xlim',x_lim,'ylim',y_lim)
            axis('equal')
            axis('off')
        end
   % Gif Speichern 
   % close all;                                    % figures schließen
   % saveGIF(filename,im,Pps);                     % gif-Datei speichern  
    end
 
end        

