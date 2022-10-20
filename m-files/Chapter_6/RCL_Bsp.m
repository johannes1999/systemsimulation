% RCL_Bsp wurde erstellt um die Umsetzung eines DGL-Systems erster Ordnung
% mit matlab deutlich zu machen.	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%
% Datum:    2020-08-19
%
% Änderung: 
%
%
% siehe auch: test_DGL2

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
tmax=8*Tau;

t_in=0:dt:tmax;     % Zeitvektor                    [s]
N=length(t_in);     % Länge des Zeitvektors         [-]

% Störfunktion
Uo=0;              % Versorgungsspannung           [V]

% Anfangsbedingung
y0 = [0 5]';	% t=0; [i  u_c]

% Solver-Aufruf
[~,y2] = ode45(@dgl_RCL_step,t_in,y0,[],L,R,C,Uo);	% ode45
    
% Ergebnisse
i  =y2(:,1);              % Strom [A]
u_c=y2(:,2);              % Spannung am Kondensator[V]

figure
    plot(t_in,Uo*ones(1,N),'k',t_in,u_c,'b',t_in,i,'r')
    title(' Beispiel linearer Reihenschwingkreis. Eingangsspannung')
    xlabel(' t [s]')
    ylabel(' u [V]; i [A]')
    grid
    legend('Uo', 'u_c', 'i')
    
%% Lokale function Yp = dgl_RCL_step(t,y,~,L,R,C,Uo)
%		 	
% DGl eines linearen Reihenschwingkreises (Sprungantwort Uo=const).
%
%
% input:	 	t : wird nicht benötig deswegen durch ~ ersetzt     [s]
%   			y : i: Strom                                        [A]
%			        u_c      : Kondensatorspannung                  [V]
%       
%                L: Induktivität                                    [H]
%                R: Widerstand                                      [Ohm]
%                C: Kapazität                                       [F]
%               Uo: Konstante Eingangsspannung                      [V]
%			   
%
% output:		Yp: [i' u_c']  Ableitungen

function Yp =dgl_RCL_step(~,y,L,R,C,Uo)
            % Platzhalter t
% System-Matrix
%
% di/dt    =-R/L*i  -1/L*u_c + Uo*1/L
% du_c/dt  = 1/C*i

%
% In Matrixform
%
%     |di/dt   |     | -R/L  -1/L |    | i |     | 1/L |
%Yp=  |        |   = |            | *  |   |  +  |     |*Uo
%     |du_c/dt |     |  1/C    0  |    |u_c|     |  0  |
%
%
%     | i   |
% y=  |     |
%     | u_c |    


% System-Matrix

A=[-R/L    -1/L;
    1/C      0 ];

b=[1/L
    0 ];   
% DGL-System

Yp=A*y+b*Uo;	% Yp=[i' u_c']
end 