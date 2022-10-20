% test_Sinkgleichung 
% 
% Beispiel: Berechnung der Stromdichteverteilung S(R,t)in einem runden
%           Kupferleiter bei der Einspeisung einer nichtsinusförmigen
%           periodischen Wechselspannung an der Manteloberfläche. 
%           Die ringförmigen Spannungszuführungen befinden sich im Abstand
%           L voneinander.
%           Anwendung des Differenzenverfahrens zur Lösung der parabolischen 
%           partiellen Differentialgleichung.
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2018 erstellt.
%
% Datum:    1.04.2018
%
% Änderung: 7.06.2019 Kommentare korrigiert
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen

% Vorgabewerte
%-------------
L=0.1;                  % Leiterlänge           [m]
R=0.01;                 % Leiterradius          [m]
kappa=56e6;             % Leitwert              [1/Ohm*m]
my_cu=1.2564e-06;       % Permeabilitätskonst   [V*s/A*m]
a=kappa*my_cu;          % Skin-Konstante        [s/m²]
Us=0.008;               % Spannungsamplitute    [V]
fo=10;                  % Spannungsfrequenz     [Hz]
To=1/fo;
tmax=3*To;              % Simulations-Zeit      [s]
Nr=20;                  % Anzahl Stützstellen Radius
dr=L/Nr;                % Schrittweite Radius   [m]
dt= 1/6*a*dr^2;         % Schrittweite Zeit     [s] 
Nt=floor(tmax/dt);      % Anzahl Stützstellen Zeit

r=linspace(0,R,Nr);     % Punkte über den Radius[m]
t=linspace(0,tmax,Nt);  % Zeitvektor            [s]

E=zeros(Nr,Nt);         % Matrix für die Saitenbewegung
                        % Damit sind auch die Anfangswerte E(i,0)=0 gesetzt

% Randbedingung und Anfangswerte 
E(Nr,:)=Us/L*sign(sin(2*pi/To*t));  % Elektrisches Feld auf dem Rand [V/m]

figure  % Darstellung der Stromdichte am Rand   
plot(1e3*t,1e-6*kappa*E(Nr,:));
xlabel('Zeit [ms]')
ylabel('Stromdichte am Rand [A/mm²]')
grid;

% Umsetzung mit zwei Schleifen    
    for j=1:Nt-1                        % Schleife über die Zeit
        E(1,j+1)=1/3*E(2,j)+2/3*E(1,j); % Wert beim Radius=0
        for i=2:Nr-1                    % Schleife über den Radius
            E(i,j+1)=(2*i+1)/(12*i)*E(i+1,j)+2/3*E(i,j)+(2*i-1)/(12*i)*E(i-1,j);
        end  
    end
    
% Darstellung
% -----------

figure % Stromdichte  S(x,t)=kappa*E
    % Skalierung der Darstellung
    N_lines_t=100;
    if N_lines_t>Nt
       Npt=1;
    else
       Npt=floor(Nt/N_lines_t); 
    end    
    N_lines_x=100;
    if N_lines_x>Nr
       Npx=1;
    else
       Npx=floor(Nr/N_lines_x); 
    end  
    
    surf(1e3*t(1:Npt:end),1e3*r(1:Npx:end),1e-6*kappa*E(1:Npx:end,1:Npt:end),'FaceAlpha',0.5);
    
    colormap(jet(255));
    xlabel('t [ms]'); ylabel('r [mm]'); zlabel('s [A/mm²]'); 
    title('Skingleichung')
    
    figure % Stromdichte bei 3/4*R
    plot(1e3*t,1e-6*kappa*E(floor(Nr*3/4),:));
    grid;
    xlabel('t [ms]'); ylabel('s [A/mm²]'); 
    title('Stromdichte an der Stelle 3/4R')