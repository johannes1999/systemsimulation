% test_DGL1_1.m 
%
% Es werden verschiedene L�sungsalgorithmen zur L�sung von DGLs erster
% Ordnung an verschiedenen Beispielen in diesem m-file gezeigt ohne f�r die
% L�sungsalgorithmen eine eigene function zu schreiben. 
% Es geht darum sich auf den L�sungsalgorithmus zu fokusieren.
% In dem m-file test_DGL1_2 werden eigene functions f�r die Algorithmen
% geschrieben und genutzt.
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-14
%
% �nderung: 2017-05-14
%           2019-04-24 Stromberechnung zugef�gt
%           2019-05-01 Taylor Approximation zugef�gt
%           2020-05-24 if then in switch ge�ndert 
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace l�schen.


% 1: RC-Schaltung mit linearen Komponenten und konstanter Spannungsquelle
%------------------------------------------------------------------------

%% DGL: RC-Reihenschaltung an einer Konstantspannungsquelle 
%      und an einer Wechselspannung
% --------------------------------------------------------
f=@(Uc,Ua,Tau) (-Uc+Ua)/Tau;
f1=@(Uc,Ua,Tau,w,t) (-Uc+Ua*sin(w*t))/Tau;

%% System Parameter
R=10;       % Widerstand    [Ohm]
C=0.01;     % Kapazit�t     [F]
Tau=R*C;    % Zeitkonstante [s]

%% St�rfunktion
Uo=10;      % Versorgungsspannung   [V]
w=4*pi/Tau;
% Zeitbereich 
t_start=0; t_end=5*Tau;
dt_grob=Tau/100;
N=floor((t_end-t_start)/dt_grob);   % Anzahl Werte
t=linspace(t_start,t_end,N);        % Zeitvektor    [s]

%% Anfangswert
Uc0=0;      % Spannung am Kondensator zum Zeitpunkt t=0

% Zeitvektor
n=length(t);        % L�nge des Zeitvektors
dt=t(2)-t(1);       % Schrittweite

% Analytische L�sung
% Wird zur Berechnung des relativen Fehlers 
% der L�sungsalgorithmen benutzt

Uc_exakt=Uo-(Uo-Uc0)*exp(-t/Tau);

% Initialisierung 
uc=zeros(size(t));  % Initialisierung des Ausgabevektors

uc(1)=Uc0;          % Anfangsbedingung

%% L�sungsverfahren
% ================

fall=6;             % 1: Euler Vorw�rts
                    % 2: Euler R�ckw�rts
                    % 3: Crank-Nicolson Verfahren
                    % 4: Runge Kutta 4ter Ordnung   
                    % 5: Taylor Approximation 
                    % 6: Euler Vorw�rts mit Wechselspannung   
switch fall                    
    case 1
    %% Euler Vorw�rts
    %----------------
        Ueberschrift='Euler Vorw�rts';
            for i=2:n
                uc(i)=uc(i-1)+f(uc(i-1),Uo,Tau)*dt;   
            end
    
    case 2    
    %% Euler R�ckw�rts 
    %-----------------
        Ueberschrift='Euler R�ckw�rts';
            for i=2:n
                uc_p=uc(i-1)+f(uc(i-1),Uo,Tau)*dt;  % Pr�diktor-Wert
                uc(i)=uc(i-1)+f(uc_p,Uo,Tau)*dt;    % Korrektor-Wert
            end
    case 3    
    %% Crank-Nicolson Verfahren 
    %--------------------------
        Ueberschrift='Crank-Nicolson';
            for i=2:n
                uc_p=uc(i-1)+f(uc(i-1),Uo,Tau)*dt;                      % Pr�diktor-Wert
                uc(i)=uc(i-1)+(f(uc(i-1),Uo,Tau)+f(uc_p,Uo,Tau))*dt/2;  % Korrektor-Wert
            end
    
    case 4    
    %% Runge Kutta 4ter Ordnung 
    %--------------------------
        Ueberschrift='Runge Kutta 4ter Ordnung';
            for i=2:n
                l0=f(uc(i-1),Uo,Tau);
                l1=f(uc(i-1)+dt/2*l0,Uo,Tau);
                l2=f(uc(i-1)+dt/2*l1,Uo,Tau);
                l3=f(uc(i-1)+dt/2*l2,Uo,Tau);
 
                uc(i)=uc(i-1)+dt/6*(l0+2*l1+2*l2+l3);  
            end
    
    case 5    
    %% Taylor Approximation 
    %-------------------------
    Ueberschrift='Taylor Approximation';
        for i=2:n
            % Nicht zusammengefasst
            % uc(i)=uc(i-1)+f(uc(i-1),Uo,Tau)*dt-dt^2/(2*Tau)*f(uc(i-1),Uo,Tau);
            uc(i)=uc(i-1)+f(uc(i-1),Uo,Tau)*(1-dt/(2*Tau))*dt; 
        end
    
    case 6        
    %% Euler Vorw�rts
    %----------------
    Ueberschrift='Euler Vorw�rts';
        for i=2:n
            uc(i)=uc(i-1)+f1(uc(i-1),Uo,Tau,w,t(i))*dt;
        end
        figure
        plot(t,uc,'b',t,Uo*sin(w*t),'r')
        xlabel(' t[s]')
        ylabel('u_C [V]')
        grid
        
end % Switch

%% Relativer Fehler in Prozent
ErrRel=100*(uc-Uc_exakt)./Uc_exakt; % [%]
    if fall < 6
        i_c=C*f(uc,Uo,Tau);
    else
        i_c=C*f1(uc,Uo,Tau,w,t);
    end

figure
subplot(2,2,1)
    plot(t,uc,'b')
    xlabel(' t[s]')
    ylabel('u_C [V]')
    grid
    title(Ueberschrift)
subplot(2,2,2)
    plot(t,i_c,'r')
    xlabel(' t[s]')
    ylabel('i_C [A]')
    grid    
subplot(2,1,2)
    plot(t,ErrRel,'k');
    xlabel(' t[s]')
    ylabel('rel. Fehler [%]')
    grid