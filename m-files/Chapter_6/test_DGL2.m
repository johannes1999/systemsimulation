% test_DGL2 enthält alle Beispiele für die Rückführung einer DGL 2ter
% Ordnung auf eine System von DGLs 1ter Ordnung
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-21
%
% Änderung: 2018-06-21
%           Fall 0 zugefügt.Einfaches Beispiel Sprungantwort
%           2019-05-09 Beispiel für eigenen Solver Runge_Kutta4sys zugefügt
%           siehe switch in Beispiel 1
%           2021-12-17 Fälle 6 bis 9 gelöscht und umsortiert
%
% siehe auch: dgl_RCL_r_lin, dgl_RCL_r_n_lin, dgl_mdc_lin

%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen
  
Fall=5;
        % 0: Gedämpfter linearer Reihenschwingkreis 
        %    Sprungantwort                                 dgl_RCL_step
        % 1: Gedämpfter linearer Reihenschwingkreis        dgl_RCL_r_lin  
        % 2: Gedämpfter nicht-linearer Reihenschwingkreis  dgl_RCL_r_n_lin
        % 3: Feder Masse Dämpfung-System                   dgl_mdc
        % 4: Räuber - Beute Modelle                        dgl_Raeuber_Beute
        % 5: Spannungsglättung 
        % 6: Buck Converter                                dgl_Buck
        
if Fall ==0
%% 0: Gedämpfter linearer Reihenschwingkreis Sprungantwort          
%--------------------------------------------------------

% System Parameter
%-----------------
R=0.2;              % Widerstand                    [Ohm]
L=1;                % Induktivität                  [H]
C=1;                % Kapazität                     [F]
Tp=2*pi*sqrt(L*C);  % Periodendauer der Schwingung  [s]

% Anstatt R den Dämpfungsgrad vorgeben
% D=0.5;
% R=D*sqrt(L/C);

Tau=L/R;            % Zeitkonstante der Dämpfung    [s]

% Zeitvektor
dt=Tp/100;          % Abtastzeit                    [s]
tmax=8*Tau;

t_in=0:dt:tmax;     % Zeitvektor                    [s]
N=length(t_in);     % Länge des Zeitvektors         [-]

% Störfunktion
Uo=0;              % Versorgungsspannung           [V]

% Anfangsbedingung
y0 = [0 5]';	% t=0; [i  u_c]

solver=1; % 1: ode45
          % 2: eigene RungeKutta

switch solver
    case 1
        % ode45
        %------
        [~,y2] = ode45('dgl_RCL_step',t_in,y0,[],L,R,C,Uo);	% ode45
    case 2
    % RungeKutta4sys
    %------------     
        p=[L R C Uo];
        y2= Runge_Kutta4sys(@dgl_RCL_step2,t_in,y0,p);	% Runge Kutta
        % Wieso der Aufruf mit @ erfolgen muss ist unklar!!!
end

i  =y2(:,1);              % Strom [A]
u_c=y2(:,2);              % Spannung am Kondensator[V]

figure
    plot(t_in,Uo*ones(1,N),'k',t_in,u_c,'b',t_in,i,'r')
    title(' Beispiel linearer Reihenschwingkreis. Eingangsspannung')
    xlabel(' t [s]')
    ylabel(' u [V]; i [A]')
    grid
    legend('Uo', 'u_c', 'i')
    
elseif Fall ==1
%% 1: Gedämpfter linearer Reihenschwingkreis LCR    
%----------------------------------------------

% System Parameter
%-----------------
R=1;                % Widerstand                    [Ohm]
L=1;                % Induktivität                  [H]
C=1;                % Kapazität                     [F]
Tp=2*pi*sqrt(L*C);  % Periodendauer der Schwingung  [s]
fo=1/Tp;            % Eigenfrequenz des ungedämpften Systems [Hz]
Tau=L/R;            % Zeitkonstante der Dämpfung    [s]

% Zeitvektor
dt=Tp/300;           % Abtastzeit                [s]
if Tau>Tp
    tmax=5*Tau;
else
    tmax=5*Tp;
end    
t_in=0:dt:tmax;         % Zeitvektor                [s]
N=length(t_in);         % Länge des Zeitvektors     [-]

% Versorgungsspannung
%--------------------
%power='Sine';
%power='Step';
power='Sweep';
switch power
          case {'Step'}
            u=1*ones([1,N]);                % power supply          [V]
            %i_in=1*ones([1,N]);             % current supply        [A]
          case {'Sine'}
            u=1*sin(2*pi*0.3*t_in+pi/2);    % power supply          [V]
            %i_in=1*sin(2*pi*0.3*t_in+pi/2); % current supply        [A]
           case {'Sweep'}
         
            u=lin_sweep(t_in,0.0*fo,3*fo,0,t_in(end));    % power supply          [V]      
end

% Anfangsbedingung
y0 = [0 0]';	% t=0; [i  u_c]

% Toleranzen
tol = 1.e-10;	% Tolerance

options= odeset('RelTol', tol);
[~,y2] = ode45('dgl_RCL_r_lin',t_in,y0,options,L,R,C,u,t_in);	% Runge Kutta 
i  =y2(:,1);              % Strom [A]
u_c=y2(:,2);              % Spannung am Kondensator[V]

figure
subplot(3,1,1)
    plot(t_in,u,'b')
    title(' Beispiel linearer Reihenschwingkreis. Eingangsspannung')
    xlabel(' t [s]')
    ylabel('  U [V]')
    grid
subplot(3,1,2)
    plot(t_in,u_c,'g')
    xlabel(' t [s]')
    ylabel(' U_c [V]')
    title(' Spannung am Kondensator')
    grid
subplot(3,1,3)
    plot(t_in,i,'r')
    xlabel(' t [s]')
    ylabel(' i [A]')
    title(' Strom')
    grid


elseif Fall==2
%% 2: Gedämpfter nicht-linearer Reihenschwingkreis    
%    stromabhängige Induktivität 
%-------------------------------------------------

% System Parameter
%-----------------
R=1;                 % Widerstand                    [Ohm]
Lo=1;                % Induktivität für i=0          [H]
C=1;                 % Kapazität                     [F]
Tp=2*pi*sqrt(Lo*C);  % Periodendauer der Schwingung  [s]
Tau=Lo/R;            % Zeitkonstante der Dämpfung    [s]

% stromabhängige Induktivität 
            
a=5.0;  % Faktor für die Nichtlinearität    [1/A]
N=200;
i_1=linspace(-1,1,N);
L1=zeros(1,N);
for k=1:N
    i1=i_1(k);
    if (i1==0)||(a==0) 
        L1(k)=Lo;
    else
        L1(k)=3*Lo*(sinh(a*i1).^2-(a*i1).^2)/(sinh(a*i1).^2*(a*i1).^2);
        %L1(k)=3*Lo*(1./*(a*i1).^2 sinh(a*i1).^2-(a*i1).^2)/(sinh(a*i1).^2*(a*i1).^2);
    end    
end 

figure
    plot(i_1,L1)
    xlabel(' Strom [A]')
    ylabel(' Induktivität L(i) [H]')
    title(' Drossel mit nichtlinearer Magnetisierungskurve')
    grid

% Zeitvektor
dt=Tp/100;           % Abtastzeit                [s]
if Tau>Tp
    tmax=5*Tau;
else
    tmax=5*Tp;
end    
t_in=0:dt:tmax;       % Zeitvektor                [s]
N=length(t_in);     % Länge des Zeitvektors     [-]

% Versorgungsspannung
%--------------------
power='Sine';
%power='Step';

switch power
          case {'Step'}
            u=1*ones([1,N]);                % power supply          [V]
            i_in=1*ones([1,N]);             % current supply        [A]
          case {'Sine'}
            u=1*sin(2*pi*0.3*t_in+pi/2);    % power supply          [V]
            i_in=1*sin(2*pi*0.3*t_in+pi/2); % current supply        [A]
end


% Anfangsbedingung
y0 = [0 0]';	% t=0; [i  u_c]

% Toleranzen
tol = 1.e-10;	% Tolerance

options= odeset('RelTol', tol);
[t,y3] = ode45('dgl_RCL_r_n_lin',t_in,y0,options,Lo,R,C,u,a,t_in);	% Runge Kutta 
i  =y3(:,1);              % Strom [A]
u_c=y3(:,2);              % Spannung am Kondensator[V]

figure
subplot(3,1,1)
    plot(t_in,u,'b')
    title(' Beispiel nicht-linearer Reihenschwingkreis. Eingangsspannung')
    xlabel(' t [s]')
    ylabel('  U [V]')
    grid
subplot(3,1,2)
    plot(t_in,u_c,'g')
    xlabel(' t [s]')
    ylabel(' U_c [V]')
    title(' Spannung am Kondensator')
    grid
subplot(3,1,3)
    plot(t_in,i,'r')
    xlabel(' t [s]')
    ylabel(' i [A]')
    title(' Strom')
    grid
 
 elseif Fall==3
 %% 3: Mass Spring Damping System 
 %-------------------------------

% System Parameter
%-----------------

m=1;        % mass              [kg]
d=0.5;      % damping factor    [N*s/m]
c=1;        % spring const      [N/m]
Fo=1;       % Pre-Load          [N]
 
% start value 	
yo=[  0   0];   %	mechanical: x'	   x	
              
                
t0=0;   te=20;	% time span [s]

options= odeset('RelTol', 1e-6);

[t_m,y_m]=ode45('dgl_mdc_lin',[t0,te],yo,options,m,d,c,Fo);       % mechanical system

figure
subplot(2,1,1)
    plot(t_m,y_m(:,1),t_m,y_m(:,2))
    xlabel(' time [s]')
    legend('v [m/s]','x [m]')
    grid
  

elseif Fall==4

%% Umwelt und Tourismus und Räuber - Beute Modell
%-----------------------------------------------

% Umwelt und Tourismus 
% Beispiel aus Einführung in LabVIEW; Wolfgang Georgi; Seite 229


a=1;            % Touristenzahlverlustrate infolge von Überfüllung
b=5;            % Werbewirkung durch Umweltqualität
c=1;            % Rate der Umweltzerstörung
d=1;            % Rate der Umwelterholung
k=1;            % Tragfähigkeit der Umwelt
N=1000;
t_start =0;
t_end   =200;
t=linspace(t_start, t_end, N);

% Start-value 
tol = 1.e-11;	% Tolerance
y0 = [0 1.0]';	% t=0;  y : [x=0 y=0]
%y0=[Massenstrom der Touristen   Qualität der Umwelt]
options= odeset('RelTol', tol);
[~,Y1] = ode45('dgl_Umwelt_Tourismus',t,y0,[],a,b,c,d,k);	

figure
subplot(2,1,1)
    plot(t,Y1(:,1))
    grid;
    xlabel('t [Jahre]');
    ylabel('Tourismus  [-]');
    title('Umwelt und Tourismus (Räuber - Beute Modell)')
subplot(2,1,2)
    plot(t,Y1(:,2))
    grid;
    xlabel('t [Jahre]');
    ylabel('Umweltqualität [-]');

% Räuber Beute Modell
% Beispiel aus Wikipedia

gx=0.05;   % Geburtenrate Beute
ax=0.003;  % Sterberate Beute
gy=0.1;    % Geburtenrate Räuber
ay=0.002;  % Sterberate Räuber

%B_R= [Beute Räuber]
B_R0 = [90 15]';	% t=0;
[~,B_R] = ode45('dgl_Raeuber_Beute',t,B_R0,options,gx,ax,gy,ay);	% Runge Kutta 
   
figure
 %subplot(2,1,1)
    plot(t,B_R(:,1),'b',t,B_R(:,2),'r')
    grid;
    xlabel('t [Jahre]');
    ylabel('Population [-]');
    title('Räuber - Beute Modell')
    legend('Beute', 'Räuber')


    
elseif Fall==5   
%% 5: Spannungsglättung 
%     siehe LaborBuch Seite 112 -113 31-08-2011
%----------------------------------------------

Np=2;                              % Number of periodes 

            R_V=0.5;                 % Vorwiderstand            [Ohm]
            R_L=19.6;                % Lastwiderstand           [Ohm]
  
            C_L=20e-7;              % Glättungskonesator        [F]
     
            Uo=10;                  % Powersupply Voltage (controlled 0...20V)      [V]
            f=100e3;                % Frequency is fixed                            [Hz]
            T=1/f;       

% Time vector
dt=T*1e-4;                  % sample time           [s]
t_in=0:dt:Np*T;             % time vector           [s]
N=length(t_in);             % length of time vector [-]


% Supply voltage
%--------------

 u=Uo*abs(sin(2*pi*f*t_in));         % power supply          [V]
% Start conditions
%-----------------

y0 = Uo*0.8781; %Uo[V]
tol = 1.e-10;	% Tolerance

%-----------
options= odeset('RelTol', tol);
[t,U_L] = ode45('dgl_U_glatt',t_in,y0,options,R_V,R_L,C_L,u,t_in);	% Runge Kutta 

U_L=U_L';
U_V=u-U_L;
Io=U_V/R_V;
Io=Io.*(Io>=0);
I2=U_L/R_L;
I1=Io-I2;


figure
subplot(2,2,1)
     plot(t_in*1e6,u)
    title('Noload case')
    xlabel(' time [µs]')
    ylabel(' U_0 [V]')
    grid
     
 subplot(2,2,2)
     plot(t_in*1e6,U_L)
    xlabel(' time [µs]')
    ylabel(' U_L [A]')
    grid

subplot(2,2,3)
     plot(t_in*1e6,Io)
    title('Noload case')
    xlabel(' time [µs]')
    ylabel(' I_0 [V]')
    grid
    
subplot(2,2,4)
     plot(t_in*1e6,I2)
    xlabel(' time [µs]')
    ylabel(' I_L [A]')
    grid
figure
subplot(2,1,1)
     plot(t_in*1e6,u,'b',t_in*1e6,U_L,'r')
    title('Noload case')
    xlabel(' time [µs]')
    ylabel(' U_0 [V]')
    grid
subplot(2,1,2)
     plot(t_in*1e6,Io,'r')
    title('Noload case')
    xlabel(' time [µs]')
    ylabel(' I_0 [V]')
    grid
    
 % Näherung Lückwinkel
 a=2.7421e-004; 
 Phi=180/pi*(acos(1-1/((1/a)*R_L*C_L+0.5)));
 Phi_Lueck= 180-Phi;    % Lückwinkel


elseif Fall==6
%  % 10: Buck Converter                                                                         
%    siehe: dgl_Buck   
%----------------------
% System Paramenter
L=1e-3;     % Induktivität  [H]
C=100e-6;   % Kapazität     [F]

% Störfunktion Versorgungsspannung als PWM
f_pwm=20e3;          % PWM Frequenz  [Hz]
DutyCycle=0.5;       % Duty Cycle    [1/100]
Uein=5;              % Amplitude     [V]

R_max=4*L*f_pwm;       % max Widerstand (Lückfrei)   [Ohm]
R=2*R_max;           % Widerstand                  [Ohm]

Tau=R*C;    % Zeitkonstante [s]

% Parameter Zusammenfassung
para=[R C L Uein f_pwm DutyCycle];

% Anfangswerte
i_L0=0;
u_aus0=0;
y0=[i_L0 u_aus0]';

% Zeitbereich 
t_start=0; t_end=0.005;%10*Tau;
dt_grob=Tau/10000;
N=floor((t_end-t_start)/dt_grob);
t=linspace(t_start,t_end,N);

figure
plot(t,Uein*pwm_t(t,f_pwm,DutyCycle));

% Lösung mit ode45
%-----------------

% optionen für ode45
tol = 1.e-12;	% Tolerance
options= odeset('RelTol', tol,'NonNegative',1);
[~,Y] = ode45('dgl_Buck',t,y0,options,para);
i_L=Y(:,1);
u_aus=Y(:,2);

figure
subplot(2,1,1)
plot(1e3*t,i_L,'r')
xlabel('t [ms]')
ylabel('i_L [A]')
grid
subplot(2,1,2)
plot(1e3*t,u_aus,'b')
xlabel('t [ms]')
ylabel('u_{out} [V]')
grid
end % Ende Fall
