% Vorübung zu partiellen DGLs
% Kanal_Pot.m
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%          
%           
% Datum:    2017-07-01
%
% Änderung:  2019-06-06 in der Übung 3D-plot Schnitt zugefügt
%            2020-06-30 Beispiel 3 zugefügt
%                       
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen. 

%% Verschiedene Lösungsmöglichkeiten

Bsp=3;          % 0: Wiederholung 3D-Plot

                % 1: mit drei Schleifen 
                %    alle Moleküle werden nacheinander berechnet
                % 2: mit einer Schleife 
                %    alle Moleküle werden auf einmal berechnet
                % 3: mit zusätzlicher Potential-Fläche
   

% Gitter für die Beispiele 1-3
%-----------------------------
Nx=50;               % Gitter: Anzahl x-Punkte
Ny=50;               %         Anzahl y-Punkte
% x,y- Gitter
x1=linspace(0,4,Nx);
y1=linspace(0,4,Ny);
[x,y]=meshgrid(x1,y1); 
            
% Randbedingungen für Beispiel 1 und 2
if (Bsp==1) || (Bsp==2)
    V=zeros(Ny,Nx);     % Matrix für die Potential-Werte 
                        % innere Werte=0 
    V(1,:)=0;           % Unterer Rand 0 V
    V(end,:)=10;        % Oberer Rand 10 V
    V(:,1)=-5;          % Seitenwände -5 V
    V(:,end)=-5;
    figure              % Anfangszustand darstellen
    mesh(x,y,V);
    colormap(jet(255));
    xlabel('x'); ylabel('y'); zlabel('V_{(x,y)}')
    title('Potentialverteilung. Iteration Anfangswerte')   
end     
   
 switch Bsp
 % Beispiele 0 bis 3
 %==================
     case 0
     %% Wiederholung 3D-Plot 
     %======================
        x_axis = -10:0.5:10;
        y_axis = -10:0.5:10;
        [x, y] = meshgrid(x_axis, y_axis);

        r = sqrt(x.^2 +y.^2);
        z = sin(r)./r;
        z(6:10,6:36)=NaN;
        figure
            mesh(x, y, z);
            xlabel('x'); ylabel('y');zlabel('z');
            title ('z(6:10,6:36)=NaN  z(y,x)!')
     case 1             
     %% Potentialverteilung auf rechteckigem Kanal 
     %  Iteration mit 3 Schleifen
     %============================================
        N_Iterations=1000;      % Anzahl Iterationen
 
        % alle Moleküle werden nacheinander berechnet
        %--------------------------------------------
            for n=1:N_Iterations
                for j=2:Ny-1
                    for k=2:Nx-1
                        V(j,k)=0.25*(V(j,k+1)+V(j,k-1)+V(j+1,k)+V(j-1,k));
                    end
                end
            end
    
     case 2
     %% Potentialverteilung auf rechteckigem Kanal 
     %  Iteration mit einer Schleife
     %===========================================
        N_Iterations=1000;  % Anzahl Iterationen
        
        J=2:Ny-1;           % Indizes für die inneren Werte
        K=2:Nx-1;
        for n=1:N_Iterations
            V(J,K)=0.25*(V(J,K+1)+V(J,K-1)+V(J+1,K)+V(J-1,K));    
        end
     case 3
     %% Potentialverteilung auf rechteckigem Kanal 
     %  mit zusätzlicher Potential-Fläche  
     %  Iteration mit einer Schleife
     %===========================================    
     
        N_Iterations=1000;      % Anzahl Iterationen
        
        % NaN-Maske
        %----------
        G=NaN(Ny,Nx);       % Matrix für die Potential-Werte 
                            % innere Werte=0 
        G(1,:)=0;           % Unterer Rand 0 V
        G(end,:)=10;        % Oberer Rand 10 V
        G(:,1)=-5;          % Seitenwände -5 V
        G(:,end)=-5;
        
        % Mittlere Elektrode
        %-------------------
        Ny_m=round(Ny/2);
        Nx_s=round(Nx/4);
        Nx_e=round(Nx*3/4);
        G(Ny_m,Nx_s:Nx_e)=5;% mittlere Elektrode 5 V
        
        % Matrix mit den Potential-Werte 
        V=G;                
        V(isnan(G))=0;  % Nur an den Stellen wo G=NaN ist
                        % Nullen in V setzen
                       
        figure          % Anfangszustand darstellen
          mesh(x,y,G);
          colormap(jet(255));
          xlabel('x'); ylabel('y'); zlabel('V_{(x,y)}')
          title('Potentialverteilung Beispiel 3. Iteration Anfangswerte')   
        
        J=2:Ny-1;       % Indizes für die inneren Werte
        K=2:Nx-1;
        for n=1:N_Iterations
            V(J,K)=0.25*(V(J,K+1)+V(J,K-1)+V(J+1,K)+V(J-1,K));  
            V(~isnan(G))=G(~isnan(G));
        end    
 end
 
 if Bsp > 0
 % Ergebnis von Bsp 1 bis 3 darstellen 
 %------------------------------------
     figure
     mesh(x,y,V);
     colormap(jet(255));
     xlabel('x'); ylabel('y'); zlabel('V_{(x,y)}')
            title(['Potentialverteilung. Lösung mit Iteration N= ' num2str(N_Iterations)])
     figure
     [Ex, Ey]=gradient(V); 
     contour(V,10); % ,'ShowText','on')
     hold
     quiver(Ex, Ey,5)
        
 end    
     