% test_DiffusionsDGL_Neumann enthält das gleiche Beispiel für die Diffusions-
% Gleichung wie test_DiffusionsDGL_Dirichlet.m 
%
% Ein Kupferstab mit konstantem Querschnitt wird auf einer Seite auf 
% konstanter Temperatur gehalten. Auf anderen Seite wird eine Steigung von
% m=0 °C/m der Temperaturänderung in Stabrichtung gefordert. 
% Der zeitliche Verlauf der Temperatur über die Stablänge wird berechnet.
%
% Die Umsetzung case 2 wurde von dem Skript Numerische Lösung partieller
% DGLs, Klaus Betzler, Uni Osnabrück übernommen.
% 
% Beispiel: Temperaturausgleichsvorgang in einem Kupferstab
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2018 erstellt.
%
% Datum:    26.03.2018
%
% Änderung:
%
% siehe auch: DiffusionsDGL_Neumann_Aufg_02.m und PDGLs.xlsx
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen 
clearvars;  % workspace löschen

% Umsetzung
%------------
um=2;   % 1: zwei Schleifen
        % 2: mit Matrix-Rechnung

        
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
% Die Bedingung der Steigung  m=0 der Temperaturänderung an der Seite x=L
% wird bei der Berechung des Temperaturwertes T(x=L) berücksichtigt.

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
Nt2=floor(Nt/2);
t=linspace(0,tmax,Nt);
k=dt/(a*dx^2);  % Konstante [-]

% Anfangswerte 
T=Teta_0*ones(Nx,Nt); % Anfangswerte Temperatur des Stabes       [°C]
T(1,:)=Teta_A;        % Konstante Temperaturen an den Stabenden  [°C]  

% Drei verschiedne Umsetzungen
%-----------------------------
switch  um
    
    case 1 % Umsetzung mit zwei Schleifen
    %======    
        for j=1:Nt-1
            
            for i=2:Nx-1
                T(i,j+1)=k*(T(i+1,j)+T(i-1,j))+(1-2*k)*T(i,j);
            end  
            T(Nx,j+1)=k*(2*T(i-1,j))+(1-2*k)*T(i,j);
        end
            
     case 2 % mit Matrix-Rechnung
     %=====    
        L=diag(ones(Nx-1,1),-1)-2*diag(ones(Nx,1))+diag(ones(Nx-1,1),1);
        L(end,end-1)=2; % Wärmefluss gleich Null
        for j=1:Nt-1                    % Schleife über die Zeit
            T(:,j+1)=T(:,j)+k*L*T(:,j);
            T(1,j+1)=Teta_A;            % Konstante Temperaturen 
        end
end
    
%Darstellung
figure
    surf(t(1:1000:end),100*x(1:4:Nx),T(1:4:Nx,(1:1000:end)),'FaceAlpha',0.5);
    colormap(jet(255));
    xlabel('t [s]'); ylabel('x [cm]'); zlabel('T [°C]'); 
    title('Temperaturverlauf über die Stablänge mit Neumannbedingung bei x=L')
figure
    waterfall(100*x(1:Nx),t(1:1000:end),T(1:Nx,(1:1000:end))');%
    ylabel('t [s]'); xlabel('x [cm]'); zlabel('T [°C]'); 
    title('Temperaturverlauf über die Stablänge mit Neumannbedingung bei x=L')
figure
    t_plot=6.1;                 % Plot zum Zeitpunkt t_plot [s]
    N_plot=floor(t_plot/dt);    % Position
    plot(100*x(1:Nx),T(1:Nx,N_plot));%
    grid
    ylabel('t [s]'); ylabel('T [°C]'); 
    title([' Temperaturverlauf zum Zeitunkt t=' num2str(t_plot) 's'])

