% m-file: DC_Motor_RI_Comp.m
%
% description:	DC Motor Model with RI compensation and PWM Powers
% 
% copyright: PLDS (c) 2012
% autor:	 HUD/HRD,	Horst Rumpf
%
% date:		15-07-2012
%       
%           
%                      
% see also: Simulink Model Motor.mdl
%           

close all;
clear all;

Fall=1; % 1: Einfaches Simulink-Modell mit Governor
        % 2: 


% Motor Parameter
%================
Ra=6.7;              % Ankerwiderstand                   [Ohm]
La=0*1.792e-3;         % Ankerinduktivität                 [H]
Tau=La/Ra;           % Ankerkreiskonstante               [s]

Jm = 1.069e-6;       % Anker-Massenträgheitsmoment       [Kgm^2]        
Ispez=62.83;         % Spez. Strom                       [A/Nm]
Psi=1/Ispez;         % Verketteter Fluss                 [Vs]
Io= 0.0351;          % Leerlaufstrom                     [A]
Mo=Io*Psi;           % Leerlaufmoment                    [Nm]



% Spannungsversorgung
%====================
Umax=8*0.8;         % Ankerspannung                  [V]
Imax=Umax/Ra;       % Blockierstrom                      [A]

    % PMW
    %-----
    f_PWM=1/16e-6;
    T_PWM=1/f_PWM;      % Period time                       [s]
    P=50;               % Duty-Cycle                        [%]

    % Spannungspuls
    %--------------
    %T_puls=0.1;         % Puls-Dauer                        [s]
    T_puls_start=0;
    T_puls_end=0.003;

% Last-Daten
%===========
J_last =5.4e-5;            % Massenträgheitsmoment des Combiners in    [kgm^2]
M_last =77.5e-3;           % Drehmoment am Combiner                    [Nm]
  
% Getriebe-Daten
%================

i_getr = 198;           % Getriebeübersetzung
eta_getr = 0.38;        % Wirkungsgrad Getriebe
c_getr = 3.36;          % Getriebesteifigkeit in [Nm/rad]  
D=0.5;
d_getr =2*D*sqrt(c_getr*J_last);% Getriebedämpfung in [Nm/s]


% Parameter des vereinfachten Modells
%====================================

J=Jm+J_last/i_getr^2;               % Gesamtes Massenträgheitsmoment auf den Motor reduziert
M_Load=M_last/(i_getr*eta_getr);    % Lastmoment auf die Motorseite umgerechnet
Tm=Ra*J/Psi^2;                      % Elektromechanische Zeitkonstante des reduzierten Systems  [s]

% Kompensation
% ============

Rc=0.0*Ra;          % Kompensation                      [Ohm]       
Tc=0.8*Tm;          % Zeitkonst. Tiefpass Kompensation  [s]

if Fall==1
% Einfaches Modell

% Simulation Parameter
sim_time=0.050;

sim('Motor_La',[0 sim_time],simset(simget('Motor_La'),'Solver','ode3','FixedStep', 1e-6));

figure
subplot(2,2,1)
    plot(t_out,w_out/(2*pi)*60)
    grid; xlabel('t  [s]');  ylabel('n  [rpm]'); 
subplot(2,2,2)
    plot(t_out,I_out,'r') 
    grid; xlabel('t  [s]');  ylabel('I_A  [A]'); 
subplot(2,2,3)
    plot(t_out*1e3,Umotor_in,'r') 
    grid; xlabel('t  [ms]');  ylabel('U_{PWM}  [V]');     
    %set(gca,'xlim',[0 2*T_PWM*1e3],'ylim',Umax*[-0.05 1.05]);
subplot(2,2,4)
    plot(t_out*1e3,Phi_out*180/pi/i_getr,'r') 
    grid; xlabel('t  [ms]');  ylabel('Phi_combiner  [°]'); 
    %set(gca,'xlim',[0 0.1*Tm*1e3]);
       
elseif Fall==2
% Simulation Gearbox
%===================

    Omega_in=1;%20000*pi;
    
    % Simulation Parameter
    sim_time=0.1;
    sim('Gearbox_01',[0 sim_time],simset(simget('Gearbox_01'),'Solver','ode3','FixedStep', 1e-4));
    w=sqrt(c_getr/J_last);
    Phi_ab2=Omega_in/i_getr*(t_out-1/w*sin(w*t_out))-M_last/(J_last*w^2)*(1-cos(w*t_out));
    figure
    subplot(2,2,1)
        plot(t_out,Phi_an)
        grid; xlabel('t  [s]');  ylabel('Phi_{an}  [rad]'); 
        title(['D= ' num2str(D)])
    subplot(2,2,2)
        plot(t_out,Phi_ab) 
        grid; xlabel('t  [s]');  ylabel('Phi_{ab}  [rad]'); 
    subplot(2,2,3)
        plot(t_out,M_motor*1e3) 
        grid; xlabel('t  [ms]');  ylabel('M_{Motor}  [mNm]');     
        
elseif Fall==3
% Stark vereinfachtes Analytisches Modell 
%========================================

    % Ansteuerung mit einem Spannungspuls
    %------------------------------------
    M_motor=0.8*M_Load;
   
    plot_yn=0;
    
    Phi_test=[0.05 0.1 0.2];
    Umin=Ra*(Io+M_motor/Psi);
    U_max_w=linspace(1.5,8,100);                % Pulshöhe  [V]
    N_u=length(U_max_w);
    T_on=linspace(0,0.05,800);               % Pulsdauer [s]
    T_on_phi=zeros(N_u,length(Phi_test));
    
    for i_U=1:N_u
        U_max=U_max_w(i_U);                     % Vorgabewert max Spannung
        w_0=U_max/Psi-Ra/Psi^2*(M_motor+Mo);    % Winkelgeschwindigkeit für T_on=inf    [1/s]
        w_an=w_0*(1-exp(-T_on/Tm));             % Winkelgeschwindigkeit nach T_on
        Phi_an=w_0*(T_on-Tm*(1-exp(-T_on/Tm))); % Drewinkel für eingeschalteten Motor   [rad]
   
        t_end=-Tm*log(1./((w_an*Psi^2)/(Ra*M_motor+1)+1)); % Auslaufzeit
    
        Phi_end=Tm*(w_an+Ra/Psi^2*M_motor).*(1-exp(-t_end/Tm))-Ra/Psi^2*M_motor*t_end; % Auslaufwinkel
   
        Phi_an_c=Phi_an/i_getr*180/pi;
        Phi_end_c=Phi_end/i_getr*180/pi;
        Phi_c= Phi_an_c+Phi_end_c;
    
        [wert N(1)]=min(abs(Phi_c-Phi_test(1))); % Werte für Phi_test (1)= 0.05°
        [wert N(2)]=min(abs(Phi_c-Phi_test(2)));
        [wert N(3)]=min(abs(Phi_c-Phi_test(3)));
        T_on_phi(i_U,:)=1e3*T_on(N); % zugehörige T_on Werte
        
        if plot_yn==1
            figure
            plot(1e3*T_on,Phi_an_c,'r',1e3*T_on,Phi_end_c,'b',1e3*T_on,Phi_c,'k')
            grid
            xlabel('T_{on} [ms]')
            ylabel('\phi_{Combiner} [°]')
        end      
    end    
    
    figure
        plot(U_max_w,T_on_phi(:,1),U_max_w,T_on_phi(:,2),U_max_w,T_on_phi(:,3))
        grid
        xlabel('U_{max} [V]')
        ylabel('T_{on}  [ms]')
        legend(['Phi_c ' num2str(Phi_test(1)) ' °'], ['Phi_c ' num2str(Phi_test(2)) ' °'],['Phi_c ' num2str(Phi_test(3)) ' °'])
        title(['M_{Motor}= ' num2str(M_motor*1e3) ' mNm']);

end    
    
