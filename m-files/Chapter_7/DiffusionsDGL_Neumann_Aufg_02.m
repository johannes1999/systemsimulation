% DiffusionsDGL_Neumann_Aufg_02 enthält die Berechnung des zweiten  
% Beispiels für die DiffusionsGleichung mit Neumann Randbedingung.
%
% Das Beispiel wurde aus dem Skript Numerische Lösung partieller
% DGLs, Klaus Betzler, Uni Osnabrück genommen.
% 
% Beispiel: Die Temperatur an einer Wand wird von -20°C nach der Hälfte
%           der Rechenzeit auf +20°C geändert. Zum Zeitpunkt t=0 hat die 
%           Wand eine durchgängige Temperatur von 0°C.
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2018 erstellt.
%
% Datum:    2018-03-26
%
%
% siehe auch: test_DiffusionsDGL_Neumann.m und PDGLs.xlsx
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen

% Umsetzung
%------------
um=1;   % 1: zwei Schleifen
        % 2: mit Matrix-Rechnung

        
% Vorgabewerte
%-------------
L=0.2;          % Dicke der Wand        [m]
a=10e+03;       % Diffusionskonstante  [s/m²]

% Anfangsbedingung
Teta_0=0;      % Temperatur der Wand zum Zeitpunkt t=0 [°C]

% Randbedingungen
% Temperatur der Wand bei x=0 m. 
Teta_1=-40;    % für die erste Hälfte der Berechnungszeit  [°C]
Teta_2=40;     % für die zweite Hälfte der Berechnungszeit  [°C]

% Die Bedingung der Steigung  m=0 der Temperaturänderung an der Seite x=L
% wird bei der Berechung des Temperaturwertes T(x=L) berücksichtigt.

% Anzahl Stützstellen über die Wanddicke
Nx=150;
dx=L/(Nx-1);    % Schrittweite  [m]
x=linspace(0,L,Nx);

% Zeitwerte
dt=0.007;   % Schrittweite der Zeit[s]
tmax=120;     % max. Zeit        [s]
Nt=floor(tmax/dt);
Nt2=floor(Nt/2);        % Hälfte der Zeitschritte
                        % wird für das Umschalten der Temperatur benötigt
t=linspace(0,tmax,Nt);  % Zeitvektor

k=dt/(a*dx^2);  % Konstante [-]

% Anfangswerte 
T=Teta_0*ones(Nx,Nt); % Anfangswerte Temperatur der Wand  [°C]


% Zwei verschiedene Umsetzungen
%-------------------------------
switch  um
    
    case 1 % Umsetzung mit zwei Schleifen
    %======    
        for j=1:Nt-1
             if j<Nt2               % Temperaturumschaltung
                 T(1,j)=Teta_1;     % nach der Hälfte der 
             else                   % Rechenzeit
                 T(1,j)=Teta_2;
             end    
            for i=2:Nx-1
                T(i,j+1)=k*(T(i+1,j)+T(i-1,j))+(1-2*k)*T(i,j);
            end  
             % Berechnung für den letzten Punkt der Wand unter der
             % Bedingung dass die Steigung der Temperaturänderung m=0 ist
             T(Nx,j+1)=k*(2*T(i-1,j))+(1-2*k)*T(i,j);      
        end
    
     case 2 % mit Matrix-Rechnung
     %=====    
        L=diag(ones(Nx-1,1),-1)-2*diag(ones(Nx,1))+diag(ones(Nx-1,1),1);
        L(end,end-1)=2;
        for j=1:Nt-1                    % Schleife über die Zeit
            if j<Nt2                    % Temperaturumschaltung
                 T(1,j)=Teta_1;         % nach der Hälfte der 
            else                        % Rechenzeit
                 T(1,j)=Teta_2;
             end    
            T(:,j+1)=T(:,j)+k*L*T(:,j); % Berechnung mit der Matrix L
        end
end
    
% Darstellungen

figure
    surf(t(1:1000:end),100*x(1:4:Nx),T(1:4:Nx,(1:1000:end)),'FaceAlpha',0.5);
    colormap(jet(255));
    xlabel('t [min]'); ylabel('x [cm]'); zlabel('T [°C]'); 
    title('Temperaturverlauf in der Wand mit Neumannbedingung')
figure
    waterfall(100*x(1:Nx),t(1:1000:end),T(1:Nx,(1:1000:end))');%
    ylabel('t [min]'); xlabel('x [cm]'); zlabel('T [°C]'); 
    title('Temperaturverlauf in der Wand mit Neumannbedingung')
    
figure
    t_plot=6.1;                 % Plot zum Zeitpunkt t_plot [s]
    N_plot=floor(t_plot/dt);    % Position
    plot(100*x(1:Nx),T(1:Nx,N_plot));%
    xlabel('x [cm]'); ylabel('T [°C]'); 
    grid;
    title([' Temperaturverlauf zum Zeitunkt t=' num2str(t_plot) 'min'])
