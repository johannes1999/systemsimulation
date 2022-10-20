% test_DiffusionsDGL_Dirichlet enthält ein  Beispiel für die Berechnung 
% einer parabolischen partiellen Differentialgleichung mit dem Differenzen-
% Verfahren und der Dirichlet Randbedinung.
%
% Ein Kupferstab mit konstantem Querschnitt wird auf beiden Seiten auf 
% konstanten Temperaturen gehalten. 
% Der zeitliche Verlauf der Temperatur über die Stablänge wird berechnet.
%
% Die Umsetzung case 3 wurde aus dem Skript Numerische Lösung partieller
% DGLs, Klaus Betzler, Uni Osnabrück übernommen.
% 
% Beispiel: Temperaturausgleichsvorgang in einem Kupferstab
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2018-03-26
%
% Änderung: 2018-03-26 verschiedene Umsetzungen zugefügt
% 
% siehe auch: test_DiffusionsDGL_Neumann.m und PDGLs.xlsx
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen

% Umsetzung
%------------
um=3;   % 1: zwei Schleifen
        % 2: eine Schleife
        % 3: mit Matrix-Rechnung

        
% Vorgabewerte
%-------------
L=0.1;          % Länge des Kupferstabes    [m]

% Materialkonstanten
c_Cu=385;       % Wärmekapazität Kupfer     [J/(kg*K)]
rho_Cu=8930;    % Dichte Kupfer             [Kg/m³]
lambda_Cu=389;  % Wärmeleitwert Kupfer      [W/(m*K)]

a=c_Cu*rho_Cu/lambda_Cu;    % Diffusionskonstante   [s/m²]

% Randbedingungen
Teta_A=0;       % Temperatur am Stabanfang konst.   [°C]
Teta_E=100;     % Temperatur am Stabende konst.     [°C]

% Anfangsbedingung
Teta_0=20;      % Temperatur am Stab zum Zeitpunkt t=0 [°C]

% Anzahl Stützstellen über die Stablänge
Nx=150;
dx=L/(Nx-1);    % Schrittweite  [m]
x=linspace(0,L,Nx);

% Zeitwerte
dt=0.0007;   % Schrittweite der Zeit[s]
tmax=12;     % max. Zeit        [s]
Nt=floor(tmax/dt);
t=linspace(0,tmax,Nt);
k=dt/(a*dx^2);  % Konstante [-]

% Anfangswerte 
T=Teta_0*ones(Nx,Nt); % Anfangswerte Temperatur des Stabes       [°C]
T(1,:)=Teta_A;        % Konstante Temperaturen an den Stabenden  [°C]  
T(Nx,:)=Teta_E;

% Drei verschiedene Umsetzungen
%------------------------------
switch  um
    
    case 1 % Umsetzung mit zwei Schleifen
    %======    
        for j=1:Nt-1
            for i=2:Nx-1
                T(i,j+1)=k*(T(i+1,j)+T(i-1,j))+(1-2*k)*T(i,j);
            end    
        end
        
     case 2 % Umsetzung mit einer Schleifen 
     %======    
         ix=2:Nx-1;      % Indizes für die Punkte in x-Richtung
            for j=1:Nt-1    % Schleife über die Zeit
                T(ix,j+1)=k*(T(ix+1,j)+T(ix-1,j))+(1-2*k)*T(ix,j);   
            end
            
     case 3 % mit Matrix-Rechnung
     %=====    
        L=diag(ones(Nx-1,1),-1)-2*diag(ones(Nx,1))+diag(ones(Nx-1,1),1);
        
        for j=1:Nt-1                    % Schleife über die Zeit
            T(:,j+1)=T(:,j)+k*L*T(:,j);
            T(1,j+1)=Teta_A;            % Konstante Temperaturen 
            T(Nx,j+1)=Teta_E;           % an den Stabenden 
        end
end
    
%Darstellung

figure
    surf(t(1:1000:end),100*x(1:4:end),T(1:4:end,(1:1000:end)),'FaceAlpha',0.5);
    colormap(jet(255));
    xlabel('t [s]'); ylabel('x [cm]'); zlabel('T [°C]'); 
    title('Temperaturverlauf über die Stablänge x und der Zeit t ')

figure
    waterfall(100*x,t(1:1000:end),T(:,(1:1000:end))');%
    ylabel('t [s]'); xlabel('x [cm]'); zlabel('T [°C]'); 
    title('Temperaturverlauf über die Stablänge x und der Zeit t ')

