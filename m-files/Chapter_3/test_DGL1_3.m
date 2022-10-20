% test_DGL1_3.m 
%
% L�sung der DGL dx/dt=(t^2+4+x)/t mit ode45
% 
% Diese DGL besitzt nur eine L�sung f�r t=0 wenn x0=-4 ist. 
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-05-23
%
% �nderung: 
%
% siehe auch: test_DGL1_1 und test_DGL1_2
%----------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace l�schen.

% Der Zeitbereich wird in diesem Beispiel nur mit Anfangs und Endwert
% vorgegeben. Mit die Tolereanzvorgabe �ndert sich die Anzahl der 
% St�tzstellen. Den Wert tol einfach �ndern und die Anzahl der x Werte
% ansehen

% Zeitbereich
%-------------
t_start=0.0; t_end=5;
t=[t_start t_end];


% Anfangswert
x0=-4;     

% optionen f�r ode45
tol = 1.e-5;	% Tolerance
options= odeset('RelTol', tol);

% ode45 mit options
[t1,x] = ode45(@dgl_dx_dt,t,x0,options);  

figure
    plot(t1,x,'b')
    xlabel(' t[s]')
    ylabel('x [-]')
    grid
    title('DGL dx/dt=(t^2+4+x)/t mit x_0=-4')

    
function dx_dt=dgl_dx_dt(t,x)
% dgl: dx/dt=(t^2+4+x)/t
%---------------------------
    if t==0
        dx_dt=0;
    else
        dx_dt=(t^2+4+x)/t;
    end
end
    
