%  ueb_Raeuber_Beute.m 
%
% Einfache Beispiele mit simulink
% 
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2019 erstellt.
%
% Datum:    2019-06-08
%
% Änderung: 22.06.2019 Simulink-Modelle Kommentare zugefügt
%            8.07.2020 Übungsaufgaben zugefügt
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars  
close all

Beispiel=2; % 1: Eifache DGL 2ter Ordnung (Gedämpfter Reihenschwingkreis)
            SysBesch=3; % 1: mit Integratoren
                        % 2: mit Zustandsraumdarstellung
                        % 3: als Transferfunktion
            % 2: Übungsaufgaben
                Aufgabe=3;  % 1: Werkstück in einem Ofen
                            % 2: Mathematisches Pendel
                            % 3: Räuber Beute Modell
            
switch Beispiel

    case 1
%% Einfache DGL 2ter Ordnung   
% (Gedämpfter Reihenschwingkreis)

    % System Parameter
    %=================
    R=1;                % Widerstand                    [Ohm]
    L=1;                % Induktivität                  [H]
    C=1;                % Kapazität                     [F]
    w_2=1/(L*C);        % Ungedämpfte Resonanzwinkel-
                        % geschwindigkeit zum Quadrat   [s^-2]
    Tp=2*pi/sqrt(w_2);  % Periodendauer der Schwingung  [s]
    fo=1/Tp;            % Eigenfrequenz des ungedämpften Systems [Hz]
    Tau=L/R;            % Zeitkonstante der Dämpfung    [s]
    
    % Anfangsbedingungen
    %-------------------
    Uc_0=0;
    dUc_dt_0=1/C; % i=C*dUc_dt => dUc_dt(0)=i(0)/C
    
    % Zustandsraumdarstellung
    %========================
    
    % System-Matrix
    A1=[-R/L  -1/L
        1/C   0  ];
    
    % Eingangs-Matrix
    B1=[1/L 0]';
    
    % Ausgangsmatrix
    C1=[1 0 
        0 1];
    
   % Durchgangs-Matrix 
   D1=[0 
       0];
   
   % Steuer-Vektor
   % Eingangs-Signal
   u_in=0;
    
   % Anfangsbedingungen
   x1_0=[1 
         0];
  
  % Übertragungsfunktion
  %=====================
  
  % automatisch generierte Übertragungs-Funktion
  % aus der Zustandsraum Darstellung
  
  [b,a] = ss2tf(A1,B1,C1,D1); % b: Zähler-Polynome(e)
                              % a: Nenner-Polynom

% Simulationszeit 
%(sinnvollen Bereich abschätzen)

   dt=Tp/300;           % Abtastzeit                [s]

    if Tau>Tp
        sim_time=3*Tau;
    else
        sim_time=3*Tp;
    end    
    t_in=0:dt:sim_time; % Zeitvektor                [s]
    
    switch SysBesch
        case 1
            sim('DGL2_01',t_in);
        case 2
            sim('DGL2_02',t_in);
        case 3
            % Eingangs-Signal
            u_in=1;
            sim('DGL2_03',t_in);
            figure 
             plot(t_out,U_c1,t_out,I_c1);
             grid; xlabel('t [s]'); ylabel('U_C [V]; I_C [A]')
             title('Ergebnis mit automatisch erzeugter Übertragungs-Fkt')
             legend('U_C', 'I_C')
    end        
    figure 
     plot(t_out,U_c,t_out,I_c);
     grid; xlabel('t [s]'); ylabel('U_C [V]; I_C [A]')
     title('Gedämpfter Reihenschwingkreis')
     legend('U_C', 'I_C')
       
    case 2
    %% Übungsaufgaben
    switch Aufgabe
        case 1
        %% 1: Werkstück in einem Ofen
        % Beispiel aus Modellbildung und Simulation
        % dyamischer Systeme; Helmut Scherf
        %------------------------------------------   
        
            m=100;      % Masse Werkstück               [kg]
            c=500;      % spez. Wärmekapazität          [J/(kg K)]
            A=0.323;    % Werkstückoberfläche           [m²]
            Al=15;      % Wärmeübergangskoeffizient     [W/(m²K)]
            T_Ofen=800; % Temperatur Ofen               [°C]
            T_w_0=20;   % Temperatur Werkstück          [°C]

            Tau=c*m/(Al*A); % Zeitkonstante             [s]  
    
            sim_time=round(5*Tau,1);    % Simulationszeit       [s]
            N=500;                      % Anzahl Stützstellen   [-]

            t=linspace(0,5*Tau,N);
            sim('sim_dgl_Ofen',t); % Aufruf Simulationsmodell

            figure;
                plot(t/3600,T_w,'r',t/3600,T_w1,'b');grid
            xlabel('t [h]'); ylabel('T_{Werkstück} [°C]')
            legend('Integrator','Transfere Fucntion')
            
        case 2
        %% 2: Mathematisches Pendel
        %--------------------------
            g=9.81;             % Erdbeschleunigung                 [m/s²]
            L=10;               % Länge Pendel                      [m]
            Phi_0=60*pi/180;    % Auslenkung bei t=0                [rad]
            Omega_0=0;          % Winkelgeschwindigkeit bei t=0     [1/s]
            sim_time=10;        %
            dt=1e-4;            % Schrittweite                      [s]
            t=1:dt:10;
            
            % Zustandsraumdarstellung
             
            % System-Matrix
            A1=[0   -g/L
                1   0  ];
    
            % Eingangs-Matrix
            B1=[0 0]';
    
            % Ausgangsmatrix
            C1=[1 0 
                0 1];
    
            % Durchgangs-Matrix 
            D1=[0 0]';
    
            % Anfangsbedingungen
            x1_0=[Omega_0 Phi_0]';
  
            
            sim('Pendel_01',t);
            
            
            figure;
            subplot(2,2,1)
                plot(t,Alpha,'r',t,Alpha1,'b');grid
                xlabel('t [s]'); ylabel('\alpha [1/s²]')
                legend('nicht lin.', 'lin.')
                title('Mathematisches Pendel')
            subplot(2,2,2)
                plot(t,Omega,'r',t,Omega2,'b');grid
                xlabel('t [s]'); ylabel('\omega [1/s]')
            
            subplot(2,2,3)
                plot(t,Phi*180/pi,'r',t,Phi2*180/pi,'b');grid
                xlabel('t [s]'); ylabel('Phi [°]')     

        case 3
        %% Räuber Beute Modell
        % Beispiel aus Wikipedia
        
            gx=0.05;   % Geburtenrate Beute
            ax=0.003;  % Sterberate Beute
            gy=0.1;    % Geburtenrate Räuber
            ay=0.002;  % Sterberate Räuber

            N=1000;
            t_start =0;
            t_end   =200;
            t=linspace(t_start, t_end, N);

            % Anfangswerte t=0;

            x_0=90; % Beute Anfangswert
            y_0=15; % Räuber Anfangswert
        
            sim('Raeuber_Beute',t);

            figure
                plot(t,x,'b',t,y,'r')
                grid;
                xlabel('t [Jahre]');
                ylabel('Population [-]');
                title('Räuber - Beute Modell')
                legend('Beute', 'Räuber')
   
    end
end
