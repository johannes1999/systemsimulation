

% Sim_Kinematik_Modelle.m
%
% Simulation der HUD Kinematik
% Der Combiner eines HUDs wird über einen DC-Motor verstellt. Die
% Verstellung erfolgt durch einen kurzen Spannungs-Puls, da der
% Verstellwinkel sehr klein ist. Die Pulsdauer liegt in der Größenordnung
% der Ankerkreiskonstanten (La/Ra) deswegen muss der Einfluss der
% Ankerinduktivität auf den Drehwinkel untersucht werden.
% Hierzu wurde eine analytische Berechnung für den Fall der
% Vernachlässigung der Ankerinduktivität durchgeführt. Auch für den Fall
% mit Ankerinduktivität wurde eine analytische Herleitung durchgeführt,
% aber die Handhabung für die pulsförmige Ansteuerung ist aufwendig...
% 
% Verschiedene Modelle
%
%	input	:
%	
%	output	:
% 	exampl	:	
%
% 
% autor:        Horst Rumpf
% date:         31-01-2014
%	
% see also:



clear all;   %Löschen aller Variablen im Workspace
close all;   %Schließen aller Plots

% Allgemeine Konstanten
% =====================
g=9.81; %

% Berechnung der verschiedenen Modelle
%=====================================

Fall=5;         % 1: Ansteuerung mit Pulsspannung
                %    Vereinfachtes analytisches Modell 
                % 2: Simulink-Modell mit Ankerinduktivität 
                %    Simulinkmodell Motor_La
                % 3: Vereinfachtes analytisches Modell Variation Pulshöhe
                % 4: Test
                % 5: Simulink-Modell mit Ankerinduktivität
                % 6: Analytische Modell 2ter Ordnung
 
% Temperaturfaktor

T=-40;                      % Tepmperatur                   [°C]
T_f=2.5;%Mech_Temp(T);      % Temperaturkoeff. Mechanik     [-]
                
%= System Parameter =
%====================

% Motor-Parameter
%================
 Kr=3.9e-3;          % Temperatur Koeff. Ankerwiderstand    [1/K]
 Kemf=-1.5e-3;       % Temperatur Koeff. EMF                [1/K] 

Ra=6.7*(1+Kr*(T-20));               % Ankerwiderstand                   [Ohm]
La=6.7e-3;                          % Ankerinduktivität                 [H]
Tau=La/Ra;                          % Ankerkreiskonstante               [s]

Jm = 1.069e-6;                      % Anker-Massenträgheitsmoment       [Kgm^2]        
Psi=1/62.83*(1+Kemf*(T-20));        % Verketteter Fluss                 [Vs]
Ispez=1/Psi;                        % Spez. Strom                       [A/Nm]
Io=T_f*0.0351;                      % Leerlaufstrom                     [A]
Mo=Io*Psi;                          % Leerlaufmoment                    [Nm]
 
% Getriebe-Daten
%================
i_getr = 198;           % Getriebeübersetzung
eta_getr = 0.38;        % Wirkungsgrad Getriebe
c = 3.36;               %Getriebesteifigkeit in [Nm/rad]   
d = 0.01;               %Getriebedämpfung in [Nms]

% Last-Daten
%===========
Jc = 5.4e-5;            % Massenträgheitsmoment des Combiners in    [kgm^2]
M_last =T_f*77.5e-3;    % Drehmoment am Combiner                    [Nm] 


% Parameter des vereinfachten Modells
%====================================
J_ges=Jm+Jc/i_getr^2;                   % Gesamtes Massenträgheitsmoment auf den Motor reduziert
M_motor=M_last/(i_getr*eta_getr);       % Lastmoment auf die Motorseite umgerechnet
Tm=Ra*J_ges/Psi^2;                      % Elektromechanische Zeitkonstante des reduzierten Systems  [s]

% Kompensation
% ============
Rc=0.8*Ra;          % Kompensation                      [Ohm]       
Tc=0.8*Tm;          % Zeitkonst. Tiefpass Kompensation  [s]

% Ansteuerung
%============
  U_max=8*0.85;      % Pulshöhe  [V]
  T_on=0.003;       % Pulsdauer [s]



if Fall==1
% Stark vereinfachtes analytisches Modell 
%========================================

    % Ansteuerung mit einem Spannungspuls
    %------------------------------------
    M_motor=(M_motor+Mo);
    
    plot_yn=0;
    
    Phi_test=[0.05 0.1 0.2];
    Umin=Ra*(Io+M_motor/Psi);
  
  
        % T_on
        %-----
        w_0=U_max/Psi-Ra/Psi^2*(M_motor+Mo);        % Winkelgeschwindigkeit für T_on=inf    [1/s]
        w_an_end=w_0*(1-exp(-T_on/Tm));             % Winkelgeschwindigkeit nach T_on
        t_an=linspace(0,T_on,400);
        w_an=w_0*(1-exp(-t_an/Tm));                 % Winkelgeschwindigkeit Fkt(t)
        Phi_an=w_0*(t_an-Tm*(1-exp(-t_an/Tm)));     % Drewinkel für eingeschalteten Motor   [rad]  
        i_an=U_max/Ra*exp(-t_an/Tm)+M_motor/Psi*(1-exp(-t_an/Tm));
        
        % Auslaufen mit Ua=0 Brake-Mode
        t_end=-Tm*log(1./((w_an_end*Psi^2)/(Ra*M_motor)+1)); % Auslaufzeit mit Ua=0
        t_stop=linspace(0,t_end,400);
        w_end=w_an_end*exp(-t_stop/Tm)-Ra/Psi^2*M_motor*(1-exp(-t_stop/Tm));
        Phi_end=Tm*(w_an_end+Ra/Psi^2*M_motor).*(1-exp(-t_stop/Tm))-Ra/Psi^2*M_motor*t_stop; % Auslaufwinkel
        i_end=-w_an_end*Psi/Ra*exp(-t_stop/Tm)+M_motor/Psi*(1-exp(-t_stop/Tm));
        t=[t_an T_on+t_stop];
        w=[w_an w_end];
        i_a=[i_an i_end];
        
        Phi_an_c=Phi_an/i_getr*180/pi;
        Phi_end_c=Phi_end/i_getr*180/pi;
        Phi=[Phi_an_c max(Phi_an_c)+Phi_end_c];
       
        % Auslaufen offene Klemmen
        %-------------------------
        t_end_1=J_ges*w_an_end/M_motor;
        t_stop1=linspace(0,t_end_1,400);
        t1=[t_an T_on+t_stop1]; 
       
        w_end1=w_an_end-M_motor/J_ges*t_stop1;
        Phi_end1=w_an_end*t_stop1-1/2*M_motor/J_ges*t_stop1.^2; % Auslaufwinkel
        Phi_end1_c=Phi_end1/i_getr*180/pi;
        
        w1=[w_an w_end1];
        Phi1=[Phi_an_c max(Phi_an_c)+Phi_end1_c];
        i_a1=[i_an zeros(size(t_stop1))];
        
        % Ansteuerung (nur für plot)
        U=[U_max*ones(size(t_an)) zeros(size(t_stop))];
        
    figure
    subplot(2,2,1)
        plot(1e3*t,w*60/(2*pi),'b',1e3*t1,w1*60/(2*pi),'-.r')
        grid
        xlabel('t [ms]')
        ylabel('n  [rpm]')
        title(['Ua= ' num2str(U_max) ' V  T_{on}= ' num2str(1e3*T_on) 'ms M_{Motor}= ' num2str((M_motor-Mo)*1e3) ' mNm']);
        legend('Brake Mode', 'Floating')
    subplot(2,2,2)
        plot(1e3*t,Phi,'b',1e3*t1,Phi1,'-. r')
        grid
        xlabel('t [ms]')
        ylabel('Phi_{Combiner}  [°]')
    subplot(2,2,3)
        plot(1e3*t,U,'b')
        grid
        xlabel('t [ms]')
        ylabel('U_a  [V]')        
     
     subplot(2,2,4)
        plot(1e3*t,i_a,'b',1e3*t1,i_a1,'-. r')
        grid
        xlabel('t [ms]')
        ylabel('i_a  [A]')        

elseif Fall==2
% Simulink-Modell mit Ankerinduktivität
% =====================================

% Simulation Parameter

sim_time=0.050;

sim('Motor_La',[0 sim_time],simset(simget('Motor_La'),'Solver','ode3','FixedStep', 1e-6));

figure
    subplot(2,2,1)
        plot(t_out*1e3,w_out*60/(2*pi),'b')
        grid
        xlabel('t [ms]')
        ylabel('n  [rpm]')
        title(['Ua= ' num2str(U_max) ' V  T_{on}= ' num2str(1e3*T_on) 'ms M_{Motor}= ' num2str(M_motor*1e3) ' mNm']);
    subplot(2,2,2)
        plot(t_out*1e3,Phi_out*180/pi/i_getr,'b')
        grid
        xlabel('t [ms]')
        ylabel('Phi_{Combiner}  [°]')
    subplot(2,2,3)
        plot(t_out*1e3,Umotor_in,'b')
        grid
        xlabel('t [ms]')
        ylabel('U_a  [V]')        
     
     subplot(2,2,4)
        plot(t_out*1e3,I_out,'b')
        grid
        xlabel('t [ms]')
        ylabel('i_a  [A]')        

elseif Fall==3
% Vereinfachtes analytisches Modell Variation Pulshöhe
%=====================================================

    % Ansteuerung mit einem Spannungspuls
    %------------------------------------
    M_motor=(M_motor+Mo);
    
    plot_yn=0;
    
    Phi_test=[0.05 0.1 0.2];
    Umin=Ra*(Io+M_motor/Psi);
    U_max_w=linspace(1.5,8,100);                % Pulshöhe  [V]
    N_u=length(U_max_w);
    T_on=linspace(0,0.05,800);                  % Pulsdauer [s]
    T_on_phi=zeros(N_u,length(Phi_test));
    for i_U=1:N_u
        U_max=U_max_w(i_U);                     % Vorgabewert max Spannung
        w_0=U_max/Psi-Ra/Psi^2*(M_motor+Mo);    % Winkelgeschwindigkeit für T_on=inf    [1/s]
        w_an=w_0*(1-exp(-T_on/Tm));             % Winkelgeschwindigkeit nach T_on
        Phi_an=w_0*(T_on-Tm*(1-exp(-T_on/Tm))); % Drewinkel für eingeschalteten Motor   [rad]
   
        t_end=-Tm*log(1./((w_an*Psi^2)/(Ra*M_motor)+1)); % Auslaufzeit
       
        Phi_end=Tm*(w_an+Ra/Psi^2*M_motor).*(1-exp(-t_end/Tm))-Ra/Psi^2*M_motor*t_end; % Auslaufwinkel
   
        Phi_an_c=Phi_an/i_getr*180/pi;
        Phi_end_c=Phi_end/i_getr*180/pi;
        Phi_c= Phi_an_c+Phi_end_c;
    
        [wert1 N(1)]=min(abs(Phi_c-Phi_test(1))); % Werte für Phi_test (1)= 0.05°
        [wert2 N(2)]=min(abs(Phi_c-Phi_test(2)));
        [wert3 N(3)]=min(abs(Phi_c-Phi_test(3)));
        T_on_phi(i_U,:)=1e3*T_on(N); % zugehörige T_on Werte
        
        if plot_yn==1
            figure
            plot(1e3*T_on,Phi_an_c,'r',1e3*T_on,Phi_end_c,'b',1e3*T_on,Phi_c,'k')
            grid
            xlabel('T_{on} [ms]')
            ylabel('\phi_{Combiner} [°]')
            title(['U_{max}= ' num2str(U_max) 'V'])
        end    
    end
    
%     figure
%         plot(U_max_w,T_on_phi(:,1)-T_on_phi_1(:,1),U_max_w,T_on_phi(:,2)-T_on_phi_1(:,2),U_max_w,T_on_phi(:,3)-T_on_phi_1(:,3))
%         grid
%         xlabel('U_{max} [V]')
%         ylabel('dT_{on}  [ms]')
%         legend(['Phi_c ' num2str(Phi_test(1)) ' °'], ['Phi_c ' num2str(Phi_test(2)) ' °'],['Phi_c ' num2str(Phi_test(3)) ' °'])
%         title(['dM_{Motor}= ' num2str(M_motor*1e3) ' mNm']);


    figure
        plot(U_max_w,T_on_phi(:,1),U_max_w,T_on_phi(:,2),U_max_w,T_on_phi(:,3))
        grid
        xlabel('U_{max} [V]')
        ylabel('T_{on}  [ms]')
        legend(['Phi_c ' num2str(Phi_test(1)) ' °'], ['Phi_c ' num2str(Phi_test(2)) ' °'],['Phi_c ' num2str(Phi_test(3)) ' °'])
        title(['M_{Motor}= ' num2str(M_motor*1e3) ' mNm']);

 elseif Fall==4
% Simulink-Modell mit negativer Last
% ==================================

% Simulation Parameter
Rc=0;
Tc=0.1*Tm; 
M_motor=-M_motor;
sim_time=0.10;

sim('Motor_La',[0 sim_time],simset(simget('Motor_neg_Load'),'Solver','ode3','FixedStep', 1e-6));

figure
    subplot(2,2,1)
        plot(t_out*1e3,w_out*60/(2*pi),'b')
        grid
        xlabel('t [ms]')
        ylabel('n  [rpm]')
        title(['Ua= ' num2str(U_max) ' V  T_{on}= ' num2str(1e3*T_on) 'ms M_{Motor}= ' num2str(M_motor*1e3) ' mNm']);
    subplot(2,2,2)
        plot(t_out*1e3,Phi_out*180/pi/i_getr,'b')
        grid
        xlabel('t [ms]')
        ylabel('Phi_{Combiner}  [°]')
    subplot(2,2,3)
        plot(t_out*1e3,Umotor_in,'b')
        grid
        xlabel('t [ms]')
        ylabel('U_a  [V]')        
     
     subplot(2,2,4)
        plot(t_out*1e3,I_out,'b')
        grid
        xlabel('t [ms]')
        ylabel('i_a  [A]')        

elseif Fall==5
% Simulink-Modell mit Ankerinduktivität
% =====================================

% Simulation Parameter

sim_time=5;

sim('DCMotor',[0 sim_time],simset(simget('Motor_La'),'Solver','ode3','FixedStep', 1e-4));%'Motor_La'

figure
    subplot(2,2,1)
        plot(t_out*1e3,M_motor,'b')
        grid
        xlabel('t [ms]')
        ylabel('M  [Nm]')
    subplot(2,2,2)
        plot(t_out*1e3,n_motor,'b')
        grid
        xlabel('t [ms]')
        ylabel('n  [rpm]')        

elseif Fall==6
  N=500;  
  f_PWM=200;          % Frequenz PWM  [Hz]
  T_PWM=1/f_PWM;
  DC_PWM=0.8;           % Duty Cycle    [-]
  T_on_PWM=T_PWM*DC_PWM;
  T_off_PWM=T_PWM-T_on_PWM;
  N_cycle=floor(5e-3/T_PWM);
  t_on=linspace(0,T_on_PWM,N);  
  t_off=linspace(0,T_off_PWM,N);  
  wo=0;
  t=0;
  w=0;
  Phi=0;
  ia=0;
  w_off=0;
  U=1;
  t_1=linspace(0,0.1,400);
  
  [w_1, Phi_1, ia_1] = Motor_1(Ra, La, Psi, Io, J_ges, M_motor, U_max,0,t_1);
  figure
    subplot(2,2,1)
        plot(t_1*1e3,w_1*60/(2*pi),'b')
        grid
        xlabel('t [ms]')
        ylabel('n  [rpm]')
       
    subplot(2,2,2)
        plot(t_1*1e3,Phi_1*180/pi/i_getr,'b')
        grid
        xlabel('t [ms]')
        ylabel('Phi_{Combiner}  [°]')
  subplot(2,2,3)
        plot(t_1*1e3,1e3*ia_1,'b')
        grid
        xlabel('t [ms]')
        ylabel('i_A  [mA]')

 for cycle=1:N_cycle
    [w_on, Phi_on, ia_on] = Motor_1(Ra, La, Psi, Io, J_ges, M_motor, U_max,min(w_off),t_on);
    [w_off, Phi_off, ia_off] = Motor_1(Ra, La, Psi, Io, J_ges, M_motor, 0,max(w_on),t_off);
    w_off=w_off.*(w_off>0);
    Phi_off=Phi_off.*(w_off>0)+max(Phi_off).*(~(w_off>0));
    w=[w w_on w_off];
    t=[t  t_on+max(t)   max(t)+max(t_on)+t_off];
    Phi=[Phi max(Phi)+Phi_on max(Phi)+max(Phi_on)+Phi_off];
    U=[U ones(size(t_on)) zeros(size(t_off))] ;
    
    ia=[ia max(ia)+ia_on max(ia)+ia_off];
 end
figure
    subplot(2,2,1)
        plot(t*1e3,w*60/(2*pi),'b',t*1e3,U*max(w*60/(4*pi)),'r')
        grid
        xlabel('t [ms]')
        ylabel('n  [rpm]')
        title(['Ua= ' num2str(U_max) ' V  T_{on}= ' num2str(1e3*T_on) 'ms M_{Motor}= ' num2str(M_motor*1e3) ' mNm']);
    subplot(2,2,2)
        plot(t*1e3,Phi*180/pi/i_getr,'b')
        grid
        xlabel('t [ms]')
        ylabel('Phi_{Combiner}  [°]')
  subplot(2,2,3)
        plot(t*1e3,1e3*ia,'b')
        grid
        xlabel('t [ms]')
        ylabel('i_A  [mA]')
        
end