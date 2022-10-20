% Ueb_LCR enthält alle Beispiele für die Rückführung einer DGL 2ter
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
%
% siehe auch: dgl_RCL_r_lin, dgl_RCL_r_n_lin, dgl_mdc_lin

%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen
  
% System Parameter
%-----------------
R=0.2;              % Widerstand                    [Ohm]
L=1;                % Induktivität                  [H]
C=1;                % Kapazität                     [F]
Tp=2*pi*sqrt(L*C);  % Periodendauer der Schwingung  [s]
Tau=L/R;            % Zeitkonstante der Dämpfung    [s]

% Zeitvektor
dt=Tp/100;          % Abtastzeit                    [s]
tmax=8*Tau;         % Simulationszeit               [s]

t=0:dt:tmax;        % Zeitvektor                    [s]
Nt=length(t);       % Länge des Zeitvektors         [-]

% Störfunktion
U0=5;              % Versorgungsspannung           [V]
u_in=U0;

% Anfangsbedingung
i0=0;               % Anfangsstrom                   [A]    
u_c0=0;             % Anfangsspannung am Kondensator [V]

% Für die ode45 werden die Anfangswerte als Spaltenvektor benötigt
y0 = [i0 u_c0]';	% t=0; [i  u_c]

%% Auskommentierter Bereich von der Lösung mit den Streckenzugverfahren
% uc=zeros(1,Nt);     % Spannungswerte am Kondensator
% i=zeros(1,Nt);      % Stromwerte
% 
% uc(1)=u_c0;         % Erster Wert ist gleich Spannungswert
% i(1)=i0;            % 
% 
% for k=2:Nt
%        uc(k)=uc(k-1)+1/C*i(k-1)*dt;
%        i(k)=i(k-1)+(-R/L*i(k-1)-1/L*uc(k-1)+1/L*u_in);
% end 

%% Berechnung mit ode45 und interner function

[~,y] = ode45(@dgl_RCL,t,y0,[],L,R,C,U0);	

    i =y(:,1);  % Strom [A]
    uc=y(:,2);  % Spannung am Kondensator[V]

figure
    plot(t,U0*ones(1,Nt),'k',t,uc,'b',t,i,'r')
    title(' Beispiel linearer Reihenschwingkreis. Eingangsspannung')
    xlabel(' t [s]')
    ylabel(' u [V]; i [A]')
    grid
    legend('Uo', 'u_c', 'i')

    %% DGL für Reihenschwingkreis
    % Es kann zwischen zwei Darstellungsformen gewählt werden 
    function Yp = dgl_RCL(~,y,L,R,C,U_in)

    %GleichungenMatrix='Gleichungen';
    GleichungenMatrix='Matrix';
    switch GleichungenMatrix

        case 'Gleichungen'
        %------------------------------------------    
            i=y(1);    % Strom                 [A]
            uc=y(2);   % Kondensatorspannung   [V]
     
            % Differentialgleichssystem
            di_dt=-R/L*i-1/L*uc+1/L*U_in;
            duc_dt=1/C*i;

            % Rückgabewerte    
            Yp=[di_dt
                duc_dt]; 
        %-----------------------------------------

        case 'Matrix'
        %-----------------------------------------
            % System-Matrix
            A=[-R/L    -1/L;
                1/C      0 ];

            b=[1/L
                0 ];

            % DGL-System
            Yp=A*y+b*U_in;	% Yp=[i u_c]'

    end %switch

    end % function
