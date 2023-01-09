% Ueb_LP.m
%
% Übungsbeispiel zur Laplace DGL
% Ab Zeile 54 soll die Iteration eingebaut werden
%	
% Autor:	Johannes
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2021 erstellt.
%          
%           
% Datum:    2022-12-16
%
% Änderung:  
%                       
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen. 


% Gitter festlegen
%-----------------
Nx=50;               % Gitter: Anzahl x-Punkte
Ny=60;               %         Anzahl y-Punkte
% x,y- Gitter
x1=linspace(0,4,Nx);
y1=linspace(0,4,Ny);
[x,y]=meshgrid(x1,y1); 

% Randbedingungen 
%----------------
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
       
%% Potentialverteilung auf rechteckigem Kanal 
%  Iteration mit 3 Schleifen
%============================================
N_Iterations=1000;      % Anzahl Iterationen

%HIER DIE ITERATION EINBAUEN
%--------------------------------------------

for n=1:N_Iterations
    V_=V; %matrix für neue werte
    for i=2:Nx-1
        for j=2:Ny-1
            V_(j,i)=(1/4)*(V(j,i+1)+V(j,i-1)+V(j+1,i)+V(j-1,i));
        end
    end
    V=V_;

    %for line=(Nx/2)-10:(Nx/2)+10
    %    V(Ny/2,line) = 5; 
    %end
    V((Ny/2)-2:(Ny/2)+2,(Nx/2)-10:(Nx/2)+10) = 5;
    
end


% Ergebnis darstellen 
%---------------------
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
     