% test_DGL1_2.m 
%
% Es werden verschiedene Lösungsalgorithmen zur Lösung von DGLs erster
% Ordnung an verschiedenen Beispielen gezeigt. Im Unterschied zu DGL1_1
% werden die Lösungsalgorithmen als functions geschrieben.
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-14          
%
% Änderung: 2018-06-06 Kommentare verberssert und Lösungsverfahren ohne
%                      feval-Funktion für neue Matlab-Versionen
%           2020-05-24 If then gegen switch getauscht    
%
% siehe auch: Euler_Vor, Euler_Rueck, Runge_Kutta4, ode45
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen

Fall=3;     % 1: RC linear mit konst. Spannungsquelle mit verschiedenen
            %    Lösungsverfahren.
            % 2: RC linear mit PWM Spannungsquelle mit 
            %    Euler_Vor und ode45
            % 3: Varistor-C Reihenschaltung (nichtlinear) mit PWM 
            %    Spannungsquelle mit Euler_Vor und ode45
          
switch Fall            
    case 1
    %% 1: RC-Schaltung mit linearen Komponenten und konstanter Spannungsquelle
    %------------------------------------------------------------------------
    % System Paramenter
    R=10;       % Widerstand    [Ohm]
    C=0.01;     % Kapazität     [F]
    Tau=R*C;    % Zeitkonstante [s]

    % Störfunktion
    Uo=10;      % Versorgungsspannung   [V]

    % Parameter Zusammenfassung
    para=[R C Uo];

    % Anfangswert
    Uc0=0;     % Kondensatorspannung [V]

    % Zeitbereich 
    t_start=0; t_end=5*Tau;
    dt_grob=Tau/100;
    N=floor((t_end-t_start)/dt_grob);   % Anzahl Werte
    t=linspace(t_start,t_end,N);        % Zeitvektor    [s]

    % Verschiedene Lösungsverfahren
    y1=Euler_Vor(@dgl_RC_lin,t,Uc0,para);       % Euler Vorwärts

    y2=Euler_Rueck(@dgl_RC_lin,t,Uc0,para);     % Euler Rückwärts

    y3=Runge_Kutta4(@dgl_RC_lin,t,Uc0,para);    % Runge Kutta 4
    
    [~,y4] = ode45(@dgl_RC_lin,t,Uc0,[],para);  % ode45 ohne options

    figure
    subplot(2,2,1)
        plot(t,y1);
        grid; xlabel('t [s]'); ylabel('U_C [V]')
        title('Euler Vorwärts')
    subplot(2,2,2)
        plot(t,y2);
        grid; xlabel('t [s]'); ylabel('U_C [V]')
        title('Euler Rückwärts')
    subplot(2,2,3)
        plot(t,y3);
        grid; xlabel('t [s]'); ylabel('U_C [V]')
        title('Runge Kutta 4ter Ordnung')
    subplot(2,2,4)
        plot(t,y4);
        grid; xlabel('t [s]'); ylabel('U_C [V]')
        title('ode45')
    
    case 2
    %% 2: RC linear mit zeitabhängige Spannungsquelle
    %------------------------------------------------
    % System Paramenter
        R=10;       % Widerstand    [Ohm]
        C=0.01;     % Kapazität     [F]
        Tau=R*C;    % Zeitkonstante [s]

        % Störfunktion Versorgungsspannung als PWM
        f_pwm=5/Tau;          % PWM Frequenz  [Hz]
        DutyCycle=0.1;          % Duty Cycle    [1/100]
        Ua=10;                  % Amplitude     [V]

        % Parameter Zusammenfassung
        para=[R C Ua f_pwm DutyCycle];

        % Anfangswert
        Uc0=0;
        % Zeitbereich 
        t_start=0; t_end=5*Tau;
        dt_grob=Tau/100;
        N=floor((t_end-t_start)/dt_grob);
        t=linspace(t_start,t_end,N);

        % Lösung mit Euler
        %-----------------
        y1=Euler_Vor(@dgl_RC_PWM,t,Uc0,para);       % Euler Vorwärts

        % Lösung mit ode45
        %-----------------

        % optionen für ode45
        tol = 3.0e-14;	% Tolerance
        options= odeset('RelTol', tol);
        [~,y2] = ode45(@dgl_RC_PWM,t,Uc0,options,para);  % ode45 ohne options

        figure
            plot(t,y1,'b',t,y2,'r');
            grid; xlabel('t [s]'); ylabel('U_C [V]')
            title('Euler Vorwärts und ODE45')
            legend('euler', 'ode45')
    
        % Berechnung des Stromes aus i=C*duc/dt
        Uc=y1;
        i_RC=zeros(1,N);
        for i=1:N
            i_RC(i)=C*dgl_RC_PWM(t(i),Uc(i),para);
        end    
        figure
        subplot(2,1,1)
            plot(t,Uc,'b');
            grid; xlabel('t [s]'); ylabel('U_C [V]')
            title('Euler Vorwärts')
        subplot(2,1,2)
            plot(t,i_RC,'r');
            grid; xlabel('t [s]'); ylabel('i_C [V]')
    
    case 3
    %% 3: RC nichtlinear mit zeitabhängige Spannungsquelle   
    %    Der Widerstand wurde durch einen Varistor ersetzt
    %-----------------------------------------------------

    % System Paramenter
    C=0.01;     % Kapazität     [F]

    % Varistor Parameter
    B=15;
    n=5;
    Tau=B*C;    % Abschätzung Zeitkonstante [s]

    % Störfunktion Versorgungsspannung als PWM
    f_pwm=0.5/Tau;          % PWM Frequenz  [Hz]
    DutyCycle=0.3;          % Duty Cycle    [1/100]
    Ua=10;                  % Amplitude     [V]

    % Parameter Zusammenfassung
    para=[C B n Ua f_pwm DutyCycle];

    % Anfangswert
    Uc0=0;
    % Zeitbereich 
    t_start=0; t_end=10*Tau;
    dt_grob=Tau/100;
    N=floor((t_end-t_start)/dt_grob);
    t=linspace(t_start,t_end,N);

    % Lösung mit Euler
    %-----------------
    y1=Euler_Vor(@dgl_RvarC_PWM,t,Uc0,para);       % Euler Vorwärts

    % Lösung mit ode45
    %-----------------

    % optionen für ode45
    tol = 1.e-10;	% Tolerance
    options= odeset('RelTol', tol);
    [~,y2] = ode45(@dgl_RvarC_PWM,t,Uc0,options,para);  % ode45 ohne options

    figure
        plot(t,y1,'b',t,y2,'r');
        grid; xlabel('t [s]'); ylabel('U_C [V]')
        title('Euler Vorwärts und ODE45')
        legend('euler', 'ode45')
    % Berechnung des Stromes aus i=C*duc/dt
    Uc=y2;
    i_RC=zeros(1,N);
    for i=1:N
        i_RC(i)=C*dgl_RvarC_PWM(t(i),Uc(i),para);
    end    
   figure
   subplot(2,1,1)
    plot(t,Uc,'b');
    grid; xlabel('t [s]'); ylabel('U_C [V]')
   subplot(2,1,2)
    plot(t,i_RC,'r');
    grid; xlabel('t [s]'); ylabel('i_C [V]')    


end % switch Fall