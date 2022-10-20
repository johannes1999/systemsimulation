% m-file test_fminsearch
%
% Erklärung 
% Man hat öfter den Fall dass die Struktur eine Funktion bekannt ist und
% einigeDatenpunkte zur Verfügung stehen. Die Parameter der Funktion sollen
% ermittelt werden.

% Beispiel:
%  Die Ladefunktion u(t)=Uo*(1-exp(-t/Tau) hat zwei Parameter Uo und Tau. 
%  Selbst mit zwei Messpunkten P1(t1|u1) und P2(t2|u2) lassen sich die
%  Parameter nicht exakt berechnen. 
%
%  Mit der function fminsearch können die Parameter bestimmt werden.
%  Es werden allerdings Startwerte benötigt.
%
%  
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    4-04-2019
%
% Änderung: 14-06-2020 in test_fminsearch_1 geändert
%
% siehe auch: 
%
%--------------------------------------------------------------------------
clearvars;
close all;

Beispiele=1;    % 1: Ladekurve
                % 2: Schwingung
switch Beispiele
    case 1
    %% Ladekurve
    %----------
    
    % Systemparameter
    C=20e-3;      % Kapazität               [F]
    R=100;        % Vorwiderstand           [Ohm]
    Tau=R*C;      % Zeitkonstante           [s] 

    Uo=10;        % Spannungquelle          [V] 

    % Zeitbereich 
    t_start=0;
    t_end=5*Tau;
    t_end2=7*Tau;
    Nt=800;                         % Anzahl Werte
    t=linspace(t_start,t_end,Nt);   % Zeitvektor für fit
    t2=linspace(t_start,t_end2,Nt); % Zeitvektor über den fit-Bereich hinaus
    u_c=Uo*(1-exp(-t/Tau));         % Ladefunktion


    % Ausgewählte "Meßwerte"
    %-----------------------
    PkteAnzahl=2; % Zwei unterschiedliche Anzahl von Punkten
    switch PkteAnzahl
        case 1          
        % Nur zwei Punkte
            P1=5;       % Auswahl von
            P2=50;      % zwei Punkten
            t_m=[t(P1) t(P2)];       
            uc_m=[u_c(P1) u_c(P2)];
        
            figure
            plot(t_m,uc_m,'* r')
            grid
            xlabel('Zeit [s]')
            ylabel('Messwerte')
        case 2  
        % Beliebige Anzahl Punkte
            n=50;                   % Vorgabewerte reduzieren
            t_m=t(1:n:end);
            uc_m=u_c(1:n:end);
        
            % Beispiel mit Ausgleichspolynom
            %-------------------------------
            % Punkte durch einen Polynom n-ten Grades (n_poly annähern)
            n_poly=6;
            p_polynom=polyfit(t_m,uc_m,n_poly); % y=a_o +a1*x+a2*x^3 ....
            y_poly1=polyval(p_polynom,t);       % Ausgleichsploynom im Vorgabe-
                                                % bereich
            y_poly2=polyval(p_polynom,t2);      % Ausgleichsploynom ausserhalb des 
                                                % Vorgabe-Bereichs                                        
            figure
            plot(t_m,uc_m,'* r')
            grid
            xlabel('Zeit [s]')
            ylabel('Messwerte')

            figure
            plot(t_m,uc_m,'* r',t,y_poly1,'b')
            grid
            xlabel('Zeit [s]')
            ylabel('Messwerte, Ausgleichspolynom')
            title( 'Im Vorgabe-Bereich')

            figure
            plot(t_m,uc_m,'* r',t2,y_poly2,'b')
            grid
            xlabel('Zeit [s]')
            ylabel('Messwerte, Ausgleichspolynom')
            title( 'Ausserhalb des Vorgabe-Bereichs')
    
    end % Switch PkteAnzahl

    % Parameter-Ermittlung mit fminsearch
    %------------------------------------

    % Start-Wert für fminsearch
    po=[1 1];    % p=[Uo Tau]

    p=fminsearch(@LadeFkt_f_min_fun,po,[],t_m,uc_m);

    Uo_est=p(1);                            % Ermittelte Parameter
    Tau_est=p(2);                           % 
    u_c_est=Uo_est*(1-exp(-t2/Tau_est));     % Funktion mit den ermittelten
                                        % Parametern
    figure;
    plot(t_m,uc_m,'* r',t2,u_c_est,'b',t,u_c,'-. r')
    xlabel('t [s]')
    ylabel('Messwerte, fit-Funktion')
    title('Ausgleichsfunktion mit fminsearch')
    grid
    
    case 2
    %% Schwingung
    A=5;
    Tau=1;
    w=2*pi*2;
    Phi=pi/6;
    t=linspace(0,5*Tau,400);
    t_m=linspace(0,Tau,20);
    y_m=A*exp(-t_m/Tau).*sin(w*t_m+Phi); % Vorgabewerte
    y=A*exp(-t/Tau).*sin(w*t+Phi);        % Exakte Lösung
    
    
    % Start-Wert für fminsearch
    po=[1 3 10 0];    % p=[A Tau w Phi]

    p=fminsearch(@Schwingung_fun,po,[],t_m,y_m);

    A_est=p(1);                            % Ermittelte Parameter
    Tau_est=p(2);                           % 
    w_est=p(3);
    Phi_est=p(4);
    
    y_est=A_est*exp(-t/Tau_est).*sin(w_est*t+Phi_est);        % Funktion mit den ermittelt
    
    figure
     plot(t_m,y_m,'* r',t,y_est,'b')
     grid
     xlabel('t [s]')
     ylabel('y_{mess}')
     title('Messwerte und "best fit" ')     
    
    
end

%% function LadeFkt_f_min_fun
%--------------------------
% Ermittlung der Parameter Uo und Tau
% mit dem Minimum der minimalen Fehlerquadrate.

function y=LadeFkt_f_min_fun(p,t_mess,Uc_mess)
Uo=p(1);
Tau=p(2);

Uc_est=Uo*(1-exp(-t_mess/Tau)); % Vorgabe der Funktionsstruktur

y=sum((Uc_est-Uc_mess).^2);     % Summe der Fehlerquadrate
end


%% function Schwingung_fun
%--------------------------
% Ermittlung der Parameter Uo und Tau
% mit dem Minimum der minimalen Fehlerquadrate.

function y=Schwingung_fun(p,t_mess,U_mess)
% p=[A Tau w Phi]
A=p(1);
Tau=p(2);
w=p(3);
Phi=p(4);

U_est=A*exp(-t_mess/Tau).*sin(w*t_mess +Phi); % Vorgabe der Funktionsstruktur

y=sum((U_est-U_mess).^2);     % Summe der Fehlerquadrate
end
