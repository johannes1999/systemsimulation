 % test_Wellengleichung enthält das gleiche Beispiel für die Wellengleichung
%
%
% 
% Beispiel: Eingespannte Saite
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2018 erstellt.
%
% Datum:    31.03.2018
%
% Änderung: 07.07.2019 Wasserfall-Diagramm zugefügt
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen

% Vorgabewerte
%-------------
L=100;                  % Saitenlänge           [cm]
A=1;                    % Saitenquerschnitt     [mm²]
F=8000;                 % Vorspannung           [N]
Rho=8000;               % Dichte der Saite      [kg/m³]

b=sqrt(Rho*A*1e-6/F);   % Wellenkonstante       [s/m]    
dx=0.5;                 % Quantisierung x       [cm]
dt=b*dx/100;            % Zeitquantisierung     [s]
                        % aus s=1=(dt/(b*dx))²

x=0:dx:L;               % Punkte auf der Saite  [cm]
Nx=length(x);           % 

tmax=4e-3;              % Simulations-Zeit      [s]
t=0:dt:tmax;            % Zeitvektor            [s]
Nt=length(t);           % Länge des Zeitvektors

z=zeros(Nx,Nt); % Matrix für die Saitenbewegung

% Randbedingung und Anfangswerte 

z0=5;% Auslenkung der Saite zum Zeitpunkt t=0 [mm]

% Verschiedene Auslenkungsarten
Auslenkung=3;   % 1: Asymmetrische Lineare Auslenkung 
                % 2: Symmetrische sinusförmige Auslekung
                % 3: Symmetrische parabelförmige Auslenkung
                
switch Auslenkung
    
    case 1 % lineare Auslenkung 
        x0=50;          % Position der Auslenkung     [cm] 
        m_l=z0/x0;      % Steigung der Geradengleichung links von der Anregung
        m_r=z0/(L-x0);  % Steigung der Geradengleichung links von der Anregung
        z(:,1)=(x<=x0).*(m_l*x)+(x>x0).*(m_r*(100-x));
        
    case 2 % sinusförime Auslenkung        
        z(:,1)=5*sin(pi/L*x);
        
    case 3 % parabelförmige Auslenkung       
        a=-z0*(2/L)^2; % Parabelstreckung
        z(:,1)=a*(x-L/2).^2+5;
end 

% Geschwindigkeit der Saite gleich Null bei t=0. D.h. z(:,2)=z(:,1)
z(:,2)=z(:,1);

figure  % Darstellung der Auslenkung zum Zeitpunkt t=0   
plot(x,z(:,1));
xlabel('Position Saite [cm]')
ylabel('Auslenkung der Saite [mm]')
title('Auslenkung der Saite zum Zeitpunkt t=0')
grid;

% Umsetzung mit zwei Schleifen    
    for j=2:Nt-1        % Schleife über die Zeit
        for i=2:Nx-1    % Schleife über die Saitenposition
            z(i,j+1)=z(i+1,j)+z(i-1,j)-z(i,j-1);
        end  
    end
    
% Darstellung
% Auslenkung über die Saitenlänge und die Zeit z(x,t)

    N_lines_t=100;
    if N_lines_t>Nt
       Npt=1;
    else
       Npt=floor(Nt/N_lines_t); 
    end    
    N_lines_x=100;
    if N_lines_x>Nx
       Npx=1;
    else
       Npx=floor(Nt/N_lines_x); 
    end
    figure 
    surf(1e3*t(1:Npt:end),x(1:Npx:end),z(1:Npt:end,1:Npx:end),'FaceAlpha',0.5);%(1:10:end)
    colormap(jet(255));
    xlabel('t [ms]'); ylabel('x [cm]'); zlabel('z [mm]'); 
    title('Schwingung der Saite über der Länge x und der Zeit t')
    
    figure
    waterfall(x,t(1:20:end),z(:,(1:20:end))');%
    ylabel('t [s]'); xlabel('x [cm]'); zlabel('z [mm]'); 
    title('Schwingung der Saite über der Länge x und der Zeit t')
    
    % Schwingung des Saiten-Mittelpunktes
    figure
    plot(1e3*t,z(floor(Nx/2),:));
    grid;
    xlabel('t [ms]'); ylabel('z [mm]'); 
    title('Schwingung des Saiten-Mittelpunktes')
    
    
    figure(4)
   for i=1:Nt
      
       plot(x,z(:,i),'b')
       axis('off')
       set(gca,'ylim',[-5 5])
       pause(0.001)
   end    
