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
% �nderung: 22.06.2019 Simulink-Modelle Kommentare zugef�gt
%            8.07.2020 �bungsaufgaben zugef�gt
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars  
close all

Beispiel=2; % 1: Eifache DGL 2ter Ordnung (Ged�mpfter Reihenschwingkreis)
            SysBesch=3; % 1: mit Integratoren
                        % 2: mit Zustandsraumdarstellung
                        % 3: als Transferfunktion
            % 2: �bungsaufgaben
                Aufgabe=3;  % 1: Werkst�ck in einem Ofen
                            % 2: Mathematisches Pendel
                            % 3: R�uber Beute Modell
            
switch Beispiel

    case 1
%% Einfache DGL 2ter Ordnung   
% (Ged�mpfter Reihenschwingkreis)

    % System Parameter
    %=================
    R=1;                % Widerstand                    [Ohm]
    L=1;                % Induktivit�t                  [H]
    C=1;                % Kapazit�t                     [F]
    w_2=1/(L*C);        % Unged�mpfte Resonanzwinkel-
                        % geschwindigkeit zum Quadrat   [s^-2]
    Tp=2*pi/sqrt(w_2);  % Periodendauer der Schwingung  [s]
    fo=1/Tp;            % Eigenfrequenz des unged�mpften Systems [Hz]
    Tau=L/R;            % Zeitkonstante der D�mpfung    [s]
    
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
  
  % �bertragungsfunktion
  %=====================
  
  % automatisch generierte �bertragungs-Funktion
  % aus der Zustandsraum Darstellung
  
  [b,a] = ss2tf(A1,B1,C1,D1); % b: Z�hler-Polynome(e)
                              % a: Nenner-Polynom

% Simulationszeit 
%(sinnvollen Bereich absch�tzen)

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
             title('Ergebnis mit automatisch erzeugter �bertragungs-Fkt')
             legend('U_C', 'I_C')
    end        
    figure 
     plot(t_out,U_c,t_out,I_c);
     grid; xlabel('t [s]'); ylabel('U_C [V]; I_C [A]')
     title('Ged�mpfter Reihenschwingkreis')
     legend('U_C', 'I_C')
       
    case 2
    %% �bungsaufgaben
    switch Aufgabe
        case 1
        %% 1: Werkst�ck in einem Ofen
        % Beispiel aus Modellbildung und Simulation
        % dyamischer Systeme; Helmut Scherf
        %------------------------------------------   
        
            m=100;      % Masse Werkst�ck               [kg]
            c=500;      % spez. W�rmekapazit�t          [J/(kg K)]
            A=0.323;    % Werkst�ckoberfl�che           [m�]
            Al=15;      % W�rme�bergangskoeffizient     [W/(m�K)]
            T_Ofen=800; % Temperatur Ofen               [�C]
            T_w_0=20;   % Temperatur Werkst�ck          [�C]

            Tau=c*m/(Al*A); % Zeitkonstante             [s]  
    
            sim_time=round(5*Tau,1);    % Simulationszeit       [s]
            N=500;                      % Anzahl St�tzstellen   [-]

            t=linspace(0,5*Tau,N);
            sim('sim_dgl_Ofen',t); % Aufruf Simulationsmodell

            figure;
                plot(t/3600,T_w,'r',t/3600,T_w1,'b');grid
            xlabel('t [h]'); ylabel('T_{Werkst�ck} [�C]')
            legend('Integrator','Transfere Fucntion')
            
        case 2
        %% 2: Mathematisches Pendel
        %--------------------------
            g=9.81;             % Erdbeschleunigung                 [m/s�]
            L=10;               % L�nge Pendel                      [m]
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
                xlabel('t [s]'); ylabel('\alpha [1/s�]')
                legend('nicht lin.', 'lin.')
                title('Mathematisches Pendel')
            subplot(2,2,2)
                plot(t,Omega,'r',t,Omega2,'b');grid
                xlabel('t [s]'); ylabel('\omega [1/s]')
            
            subplot(2,2,3)
                plot(t,Phi*180/pi,'r',t,Phi2*180/pi,'b');grid
                xlabel('t [s]'); ylabel('Phi [�]')     

        case 3
        %% R�uber Beute Modell
        % Beispiel aus Wikipedia
        
            gx=0.05;   % Geburtenrate Beute
            ax=0.003;  % Sterberate Beute
            gy=0.1;    % Geburtenrate R�uber
            ay=0.002;  % Sterberate R�uber

            N=1000;
            t_start =0;
            t_end   =200;
            t=linspace(t_start, t_end, N);

            % Anfangswerte t=0;

            x_0=90; % Beute Anfangswert
            y_0=15; % R�uber Anfangswert
        
            sim('Raeuber_Beute',t);

            figure
                plot(t,x,'b',t,y,'r')
                grid;
                xlabel('t [Jahre]');
                ylabel('Population [-]');
                title('R�uber - Beute Modell')
                legend('Beute', 'R�uber')
   
    end
end
