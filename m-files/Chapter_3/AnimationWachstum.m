% AnimationWachstum
%
% 
% Wachstum darstellen
%
% Dieser File wurde zur Erzeugung der gif-Dateien für das Skript verwendet! 
%
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%
% Datum:    2020-05-26
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen.

Fall=3;     % 1: exponentielles Wachstum
            % 2: Logistisches Wachstum
            % 1: exponentielles Wachstum schrittweise


switch Fall
    case 1
    %% Unbegrenztes Wachstum
    %-----------------------
    
        % für gif-Datei speichern
        filename='Wachstum_1.gif';
        Pps=1/6;     % Bildrate wie bei einem Film
        
        Nd=13;      % Anzahl Durchläufe
        F=fibonacci_iter(Nd);

        fig=figure; % Füf gif Speichern
            set(gca,'xlim',0.5*(Nd)^2*[-1 1],'ylim',0.5*(Nd)^2*[-1 1]);
            axis('equal')
            axis('off')
            hold on
    
        for i=1:Nd
            R=0.5*i^2;
            dPhi=2*pi/F(i);
            PhiOff=i*pi/Nd+0.3*(rand-0.5);
                for k=1:F(i)
                    x(k)=R*cos(k*dPhi+PhiOff+0.1*(rand-0.5));
                    y(k)=R*sin(k*dPhi+PhiOff+0.1*(rand-0.5));
                end
            plot(x,y,'r .');   
            im{i} = frame2im(getframe(fig));   % Abspeichern der Bilder
        end   

    % Gif Speichern 
    %close all;                                    % figures schließen
    %saveGIF(filename,im,Pps);                     % gif-Datei speichern 
    
    case 2
    %% Unbegrenztes Wachstum
    %-----------------------
    
        % für gif-Datei speichern
        filename='Wachstum_2.gif';
        Pps=1/24;     % Bildrate wie bei einem Film
        
        S=10;
        a=1;
        k=0.1;
        N=100;
        t=linspace(0,9,N);
        B=a*S./(a+(S-a)*exp(-k*S*t));
        
        figure 
            plot(t,B); grid
            xlabel('t');
            ylabel('B(t)')
            
        fig=figure;
            set(gca,'xlim',0.5*[-1 1],'ylim',[0 1.1*S]);
            bar(0,S,'FaceColor','none','EdgeColor',[0 0 1],'BarWidth',1)
            axis('off')
            hold on
            for i=1:N
                bar(0,B(i),'b','BarWidth',1);
                im{i} = frame2im(getframe(fig));   % Abspeichern der Bilder
            
            end    
        % Gif Speichern 
        %close all;                                    % figures schließen
        %saveGIF(filename,im,Pps);                     % gif-Datei speichern 
    case 3
    %% Unbegrenztes Wachstum
    %  Schrittweise
    %-----------------------
    % Beispiel für TM3 
        % für gif-Datei speichern
        filename='Wachstum_3.gif';
        Pps=1/6;     % Bildrate wie bei einem Film
       
        k=1;
        y0=1;
        N=6;
        t=0:N;
        dt=t(2)-t(1);
        y=zeros(1,N);
        y(1)=y0;
        
        %fig=figure; % Füf gif Speichern
            %set(gca,'xlim',0.5*(Nd)^2*[-1 1],'ylim',0.5*(Nd)^2*[-1 1]);
           % axis('equal')
           % axis('off')
           % hold on
    
        for i=2:N
            y(i)=y(i-1)*(k*dt+1);
            figure
            plot(t(1:i),y(1:i),'b')
            axis('equal')
            set(gca,'xlim',[0 5],'ylim',[0 10]);
            grid
            xlabel('t [s]')
            ylabel('y [pcs]')
            
        end   
         t=0:0.01:5;
         A=[0 0.005 0.01 0.02 0.04 .08 0.2 0.4 1 2 4 7];
         NA=length(A);
         Nt=length(t);
         y=zeros(NA,Nt);
         for i=1:NA
         y(i,:)=A(i)*exp(k*t);
         end
         figure
         plot(t,y,'b');
         grid
          axis('equal')
            set(gca,'xlim',[0 5],'ylim',[0 10]);

            xlabel('t [s]')
            ylabel('y [pcs]')
         
    % Gif Speichern 
    %close all;                                    % figures schließen
    %saveGIF(filename,im,Pps);                     % gif-Datei speichern 
            
end

    