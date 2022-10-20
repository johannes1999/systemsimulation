%   BLDC_motor
%  
%   Simulation eines BLDC-Motors 
%   Siehe BLDC Motor Modelling and Control A MAtlab / Simulink
%   Implementation (Master Thesis work ba Stefan Baldursson)
%   
% 	
%  Autor:	    Dirk Horst / Horst Rumpf  
%  Datum:	    14.02.2017
%               17.10.2017 Inverter in Matlab-Fcn ge�ndert und 
%                          Fallunterscheidung f�r Leeraufdiode zugef�gt
%                8.11.2017 Simscape Modell zugef�gt Schaltung=1
%               22.06.2019 Nur noch Sternschaltung ohne Simscape
%
%  Siehe :   Simulik-Modell BLDC_stern_state


clearvars;
close all;



% Motor
%======

% Hinweis Motorparameter
%
% Rs, Ls, Psi_s sind Strang-Gr��en. 
% Aus einer Stern-Schaltung lassen sich f�r ein �usseres Modell
% (einfaches Motormodell) die Gr��en wiefolgt umrechnen:
%  R=2*Rs, L=2*LS und Psi=2*Psi_s


% 3 phase BLDC, 4 pole pairs 12 stator teeth 
%-------------------------------------------
% Motor-Parameter
U_B=13;             % Klemmenspannung                   [V]

% Parmameter �usseres Modell
Psi=0.0265;         % Verketteter Fluss                 [Vs]
R=0.150;            % Ankerwiderstand                   [Ohm]
L=84e-6/2;          % Ankerinduktivit�t                 [H]

%Parameter Stranggr��en
Psi_s=Psi/2;        % Verketteter Fluss                 [Vs]
Rs=R/2;             % Ankerwiderstand                   [Ohm]
Ls=L/2;             % Ankerinduktivit�t                 [H]
p = 4;              % Polpaare

% Mechanische Gr��en
J_ges=54e-6;        % Massentr�gheitsmoment             [kgm�]
kf=0;               % Reibungskonst.                    [Nms] 
M_Last=0;           % Mech. Load                        [Nm]


Ta=L/R;
Tm=(R*J_ges)/Psi^2;     % Elektromechanische Zeitkonstante  [s]
n0=60*U_B/(2*pi*Psi);   % Leerlaufdrehzahl (ohne Verluste)  [rpm]

fprintf('Tm= %d ms\n',1e3*Tm);
fprintf('Ta= %d �s\n',1e6*Ta);
fprintf('no= %d rpm\n',n0);



% STERN-Schaltung
%----------------

%Parameter Stranggr��en
%Psi_s=Psi/2;        % Verketteter Fluss                 [Vs]
%Rs=R/2;             % Ankerwiderstand                   [Ohm]
%Ls=3*L;             % Ankerinduktivit�t                 [H]

  % State Space Modell f�r STERN-Schaltung der Motorphasen
  %-------------------------------------------------------
    A = [-Rs/Ls,    0,      0,        0; 
           0,    -Rs/Ls,    0,        0; 
           0,       0,   -kf/J_ges,   0; 
           0,       0,     p/2,       0]; 

    B = [2/(3*Ls), 1/(3*Ls),   0;
        -1/(3*Ls), 1/(3*Ls),   0;
           0,        0,     1/J_ges;
           0,        0,      0];

    C = [1, 0, 0, 0;
         0, 1, 0, 0;
        -1,-1, 0, 0;
         0, 0, 1, 0;
         0, 0, 0, 1];

     D = [0, 0, 0;
         0, 0, 0;
         0, 0, 0;
         0, 0, 0;
         0,0,0];


sim_time=5*Tm;

% mit Freilaufdioden ohne PWM
sim('BLDC_stern_state_space',[0 sim_time],simset(simget('BLDC_stern_state_space'),'Solver','ode3','FixedStep', 1e-6));

n = omega*30/pi;  % Drehzahl    [rpm]
time = time*10^3; %Zeit in ms

% Spannungen und Str�me
%----------------------
figure;
subplot(3,1,1); plot(time,GEMK_abc,time,Position+min(min(GEMK_abc))-8,'k'); 
                grid on; 
                title(' STERN mit Leerlaufdiode ohne PWM: GEMK abc');
                legend('e_a', 'e_b', 'e_c','Pos')
subplot(3,1,2); plot(time,Uab_Ubc,time,Position+min(min(Uab_Ubc))-8,'k'); 
                grid on; title('Uab Ubc');
                legend('U_{ab}', 'U_{bc}', 'Pos')
subplot(3,1,3); plot(time,iuvw,time,10*Position+min(min(iuvw))-70,'k'); 
                grid on; xlabel('t [ms]'); title('Phasenstr�me'); 
                legend('i_a', 'i_b', 'i_c', 'Pos')

% Drehzahl und Drehmoment
%------------------------
figure;
subplot(3,1,1);
plot(time,n,[0 Tm*1000],[0 max(n)],'k -.'); grid on; title('Drehzahl');
xlabel('t [ms]'); ylabel('n [rpm]');
subplot(3,1,2);
plot(time, M_Motor); grid on; title('Motor_{Moment}');
xlabel('t [ms]'); ylabel('M_{Motor} [Nm]');
subplot(3,1,3);
plot( M_Motor,n); grid on; title('Drehzahl - Drehmoment');
xlabel('M_{Motor} [Nm]'); ylabel('n_{Motor} [rpm]');

