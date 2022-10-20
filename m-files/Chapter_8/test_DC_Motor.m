% DC-Motor Simulation mit simulink
% 
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2019 erstellt.
%
% Datum:    22-06-2019
%            
%
% Änderung: 29-12-2021 Momentensumme zugefügt
%
% siehe auch: Simulink-Modelle: DC_Motor; DC_Motor_IR_Comp; DC_Motor_PI;
%                               DC_Motor_Puls                                
%--------------------------------------------------------------------------
clearvars;
close all;
 
Beispiel=1; % 1: Motor mit Konstantspannung und Lastsprung
            % 2: Motor mit IR-Kompensation
            % 3: Motor mit PI-Regler
            % 4: Motor mit Puls-Spannung

%% Motor Parameter
%================
Ra=6.7;              % Ankerwiderstand                   [Ohm]
La=10*1.792e-3;      % Ankerinduktivität                 [H]
                     % Zum testen mit Faktor 10!!!
Tau=La/Ra;           % Ankerkreiskonstante               [s]

Jm = 1.069e-6;       % Anker-Massenträgheitsmoment       [Kgm^2]        
Psi=0.0159;          % Verketteter Fluss                 [Vs]
Io= 0.0351;          % Leerlaufstrom                     [A]
Mo=Io*Psi;           % Leerlaufmoment                    [Nm]

% Getriebe-Daten
%================

i_getr = 198;           % Getriebeübersetzung
eta_getr = 0.38;        % Wirkungsgrad Getriebe

% Last-Daten
%===========
J_last =5.4e-5;           % Massenträgheitsmoment Abtrieb    [kgm^2]
M_last =400e-3;           % Lastmoment Abtrieb               [Nm]

% Motorseitig
J_ges=Jm+J_last/i_getr^2;           % Gesamtes Massenträgheitsmoment auf den Motor reduziert
M_motor=M_last/(i_getr*eta_getr);   % Lastmoment auf die Motorseite umgerechnet

Tm=Ra*J_ges/Psi^2;                  % Elektromechanische Zeitkonstante des reduzierten Systems  [s]

switch Beispiel
    
    case 1
%% 1: Motor mit Konstantspannung und Lastsprung        
        Titel='Konstantspannung und Lastsprung';
        U_motor=8;           % Ankerspannung                    [V]
        t_M_an=3*Tm;         % Zeit bei der die mech. Last 
                             % zugeschaltet wird                [s]
                             
        N=800;               % Anzahl Werte
        sim_time=linspace(0,8*Tm,N);       % Simulation Parameter [s]
        
        sim('DC_Motor',sim_time);
        
        Umotor_in=U_motor*ones(1,N);       % Nur für den allgemeinen plot
    case 2
%% 2: Motor mit Kompensation
     
        Titel='DC-Motor mit IR-Kompensation';
        U_comp=8;           % Spannung für die Soll-Drehzahl        [V]       
        Komp=0.83*Ra;        % Kompensation des Ankerwiderstandes   [Ohm]
      
        t_M_an=3*Tm;         % Zeit bei der die mech. Last 
                             % zugeschaltet wird                [s]
        sim_time=6*Tm;       % Simulation Parameter             [s]
        
        sim('DC_Motor_IR_Comp',[0 sim_time]);
        

    case 3
%% 3: Motor mit PID Regler
        
        Titel='DC-Motor mit PI-Regler';
        % PID Regler
        % ------------
        w_soll=8/Psi;        % Soll-Drehzahl        [1/s]  
        KR=10;
        TN=1.0*Tm;
        
        t_M_an=3*Tm;         % Zeit bei der die mech. Last 
                             % zugeschaltet wird                [s]
        sim_time=6*Tm;       % Simulation Parameter             [s]
        
        sim('DC_Motor_PI',[0 sim_time]);
       
        
    case 4
%% 4: Motor mit Puls-Spannung
        % Spannungspuls
        %--------------
        Titel='DC-Motor mit Pulsansteuerung';
        U_max=8;             % Ankerspannung                  [V]
        T_on=0.003;          % Puls-Dauer                     [s]
        sim_time=5*T_on;     % Simulation Parameter           [s]
        sim('DC_Motor_Puls',[0 sim_time]);        
end

%% Ergebnisse
figure
subplot(2,2,1)
    plot(t_out,w_out/(2*pi)*60,'b')
    grid; xlabel('t  [s]');  ylabel('n  [rpm]'); 
    title(Titel);
subplot(2,2,2)
    plot(t_out,I_out,'r') 
    grid; xlabel('t  [s]');  ylabel('I_A  [A]'); 
subplot(2,2,3)
    plot(t_out*1e3,Umotor_in,'b') 
    grid; xlabel('t  [ms]');  ylabel('U_A  [V]');     
subplot(2,2,4)
    plot(t_out*1e3,Phi_out*180/pi/i_getr,'b') 
    grid; xlabel('t  [ms]');  ylabel('Phi_{ab}  [°]'); 

   % Drehmomente zurückgerechnet 
   M_motor=I_out*Psi;
   M_T=J_ges*diff(w_out)./diff(t_out);
   M_T=[M_T; M_T(end)];
   M_last=M_motor-M_T;
   figure
   plot(t_out*1e3,M_motor*1e3,'r',t_out*1e3,M_T*1e3,'b',t_out*1e3,M_last*1e3,'g')
   grid
   xlabel('t  [ms]');  ylabel('M  [mNm]'); 
   legend('M_{Motor}','M_{Trägheit}','M_{Last}')