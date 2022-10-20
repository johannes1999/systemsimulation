
% Tol_Kinematik_Modell.m

% Toleranz-Simulation der HUD Kinematik mit vereinfachtem Modell 
% 


%Löschen aller Variablen im Workspace
clear all;

%Schließen aller Plots
close all;

clc;

home;

% Allgemeine Konstanten
% =====================

g=9.81; %

n_s=100000;             % Anzahl Simulationen
AnzKl = n_bins(n_s);    % Anzahl von Klassen

T=[-20 20 70];          % Tepmperaturbereich
 N_tmp=length(T);
 
 tol_1=1;               % tol_1=1 Original Toleranz 
 PTol=0.1;              %      =0 tol_2 entspricht PTol-% des Nominalwertes
 tol_2=PTol*not(tol_1); % Toleranz ist ein Prozentwert des Nominalwertes
 
 % Initialisierung
  Phi_an_c=zeros(N_tmp,n_s);    % Drehwinkel bei angetriebenem Motor
  Phi_end_c=zeros(N_tmp,n_s);   % Drehwinkel bei kurzgeschlossenem Motor
  Phi_c=zeros(N_tmp,n_s);       % Kompletter Drehwinkel    
 
for T_N=1:3
%= System Parameter =
%====================

% Motor-Parameter
%================
 Kr=3.9e-3;              % Temperature coeff. anchor resistor    [1/K]
 Kemf=-1.5e-3;           % Temperature coeff. EMF                [1/K] 

    % 1 Ankerwiderstand                   [Ohm]
    Ra_20_nom=6.7;          Ra_20_tol=Ra_20_nom*(0.1*tol_1+tol_2);    Ra_20=rnd_vect(n_s,'normal',[Ra_20_nom Ra_20_tol/3]); 
    Ra=Ra_20*(1+Kr*(T(T_N)-20));
 
    % 2 Ankerinduktivität                 [H]
    La_nom=1.792e-3;        La_tol=La_nom*(0.1*tol_1+tol_2);    La=rnd_vect(n_s,'normal',[La_nom La_tol/3]); 
      
    % 3 Verketteter Fluss                 [Vs]
    Psi_20_nom=0.0159;      Psi_20_tol=Psi_20_nom*(0.1*tol_1+tol_2);    Psi_20=rnd_vect(n_s,'normal',[Psi_20_nom Psi_20_tol/3]); 
    Psi=Psi_20*(1+Kemf*(T(T_N)-20));

    % 4 Leerlaufstrom                     [A] 
    Io_20_nom=0.0351;       Io_20_tol=Io_20_nom*(0.1*tol_1+tol_2);    Io_20=rnd_vect(n_s,'normal',[Io_20_nom Io_20_tol/3]); 
    Io=Io_20*Mech_Temp(T(T_N));

    % 5 Anker-Massenträgheitsmoment       [Kgm^2] 
    Jm_nom=1.069e-6;           Jm_tol=Jm_nom*(0.001*tol_1+tol_2);    Jm=rnd_vect(n_s,'normal',[Jm_nom Jm_tol/3]); 
    
    % Berechnete Werte
    Mo=Io.*Psi;             % Leerlaufmoment                    [Nm]
    Tau=La./Ra;             % Ankerkreiskonstante               [s]

% Getriebe-Daten
%================
    i_getr = 198;           % Getriebeübersetzung

    % 6 Wirkungsgrad Getriebe
    eta_getr_nom=0.38;      eta_getr_tol=eta_getr_nom*(0.01*tol_1+tol_2);    eta_getr=rnd_vect(n_s,'normal',[eta_getr_nom eta_getr_tol/3]); 
       
% Last-Daten
%===========

    % 7 Massenträgheitsmoment des Combiners in    [kgm^2]
    Jc_nom=5.4e-5;           Jc_tol=0.02*Jc_nom;    Jc=rnd_vect(n_s,'normal',[Jc_nom Jc_tol/3]); 
    
    % 8 Drehmoment am Combiner                    [Nm]   
    M_last_20_nom=77.5e-3;  
    M_last_20_tol=0.1*M_last_20_nom*tol_1+M_last_20_nom*tol_2;    M_last_20=rnd_vect(n_s,'normal',[M_last_20_nom M_last_20_tol/3]); 
    M_last=M_last_20*Mech_Temp(T(T_N));

% Ansteurung
%===========
    % 9 Pulshöhe  [V]
    U_max_nom=5;           U_max_tol=U_max_nom*(0.02*tol_1+tol_2);    U_max=rnd_vect(n_s,'normal',[U_max_nom U_max_tol/3]);     
    % 10 Pulsdauer [s]
    T_on_nom=3e-3;           T_on_tol=T_on_nom*(0.02*tol_1+tol_2);    T_on=rnd_vect(n_s,'normal',[T_on_nom T_on_tol/3]);   


    
 % Eingabeparameter
 %==================
 
 % Ra, La, Psi, Io, Jm, eta_getr, Jc, Mlast, U_max, T_on
 figure 
    subplot(3,4,1);
        hist_txt(Ra,AnzKl,'','R_a [Ohm]',0); grid;
    subplot(3,4,2);
        hist_txt(La,AnzKl,'','L_a [H]',0); grid;    
    subplot(3,4,3);
        hist_txt(Psi,AnzKl,'',' \Psi [Vs]',0); grid;    
    subplot(3,4,4);
        hist_txt(Io,AnzKl,'','I_0 [A]',0); grid;    
    subplot(3,4,5);
        hist_txt(Jm,AnzKl,'','J_{Motor} [kgm²]',0); grid;
    subplot(3,4,6);
        hist_txt(eta_getr,AnzKl,'','\eta_{Getriebe}',0); grid;
    subplot(3,4,7);
        hist_txt(Jc,AnzKl,'','J_{Last} [kgm²]',0); grid;
    subplot(3,4,8);
        hist_txt(M_last,AnzKl,'','M_{Last}',0); grid;
    subplot(3,4,9);
        hist_txt(U_max,AnzKl,'','U_{Puls} [V]',0); grid;
    subplot(3,4,10);
        hist_txt(T_on,AnzKl,'','T_{Puls} [s]',0); grid;
%     subplot(3,4,11);
%         hist_txt(x11,AnzKl,'','small extreme3',0); grid;
%     subplot(3,4,12);
%         hist_txt(x12,AnzKl,'','weibull',0); grid;
    
 
% Parameter des vereinfachten Modells
%====================================

J_ges=Jm+Jc/i_getr^2;               % Gesamtes Massenträgheitsmoment auf den Motor reduziert
M_motor=M_last./(i_getr.*eta_getr); % Lastmoment auf die Motorseite umgerechnet
Tm=Ra.*J_ges./Psi.^2;                % Elektromechanische Zeitkonstante des reduzierten Systems  [s]

% Stark vereinfachtes Analytisches Modell 
%========================================   
    w_0=U_max./Psi-Ra./Psi.^2.*(M_motor+Mo);            % Winkelgeschwindigkeit für T_on=inf    [1/s]
    w_an=w_0.*(1-exp(-T_on./Tm));                       % Winkelgeschwindigkeit nach T_on
    Phi_an=w_0.*(T_on-Tm.*(1-exp(-T_on./Tm)));          % Drewinkel für eingeschalteten Motor   [rad]
   
    t_end=-Tm.*log(1./((w_an.*Psi.^2)./(Ra.*M_motor)+1)); % Auslaufzeit
     
    Phi_end=Tm.*(w_an+Ra./Psi.^2.*M_motor).*(1-exp(-t_end./Tm))-Ra./Psi.^2.*M_motor.*t_end; % Auslaufwinkel
   
    Phi_an_c(T_N,:)=Phi_an./i_getr*180/pi;
    Phi_end_c(T_N,:)=Phi_end./i_getr*180/pi;
        Phi_c(T_N,:)= Phi_an_c(T_N,:)+Phi_end_c(T_N,:);
        
     
 % Drehwinkel Combiner
 %====================
 figure 
 subplot(2,3,1)
 hist_txt(Phi_an_c(T_N,:),AnzKl,'',['Phi_{an} [°] bei T= ' num2str(T(T_N)) ' °C'] ,0); grid;  
 subplot(2,3,2)
 hist_txt(Phi_end_c(T_N,:),AnzKl,'',['Phi_{aus} [°] bei T= ' num2str(T(T_N)) ' °C'] ,0); grid;  
 subplot(2,3,3)
 hist_txt(Phi_c(T_N,:),AnzKl,'',['Phi_{Combiner} [°] bei T= ' num2str(T(T_N)) ' °C'] ,0); grid;  
 
  % Ra, La, Psi, Io, Jm, eta_getr, Jc, M_last, U_max, T_on
  subplot(2,1,2)
  pfpareto(Phi_c(T_N,:),' ',[],[],'Phi_{Combiner} [°] ',0,0, Ra,'R_a',Psi,'\Psi', Io,'I_0',Jm,'Jm',...
                            eta_getr,'\eta_{Getriebe}',Jc,'J_{Last}',M_last,'M_{Last}',U_max,'U_{Puls}', T_on,'T_{Puls}');
  
end                        
 Phi_an_c_2=[Phi_an_c(1,:) Phi_an_c(2,:)   Phi_an_c(3,:)]; 
 Phi_end_c_2=[Phi_end_c(1,:) Phi_end_c(2,:)   Phi_end_c(3,:)]; 
 Phi_c_2=Phi_an_c_2+Phi_end_c_2;
 
 figure 
 subplot(2,3,1)
 hist_txt(Phi_an_c_2,AnzKl,'','Phi_{an} über den Temperaturbereich',0); grid;  
 subplot(2,3,2)
 hist_txt(Phi_end_c_2,AnzKl,'','Phi_{auslaufen} über den Temperaturbereich',0); grid;  
 subplot(2,3,3)
 hist_txt(Phi_c_2,AnzKl,'','Phi_{Combiner} über den Temperaturbereich' ,0); grid;  
 
              
                        
                       
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
    