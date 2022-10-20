% m-file: Konvergenz_Brunnen.m
%
% Konvergenz Brunnentiefe
% Wieso konvergiert die Iteration für die Brunnentiefe ab einer bestimmten
% Messzeit nicht mehr?
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2018 erstellt.
%
% Datum:    2017-05-28
%           2019-02-15
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen

Bsp=3;  % 1: Wachstum 
        % 2: Konvergenz Logistische Gleichung
        % 3: Konvergenz Brunnentiefe
        
switch Bsp
    case 1 % Wachstum (geometrische Reihe)
        r=0.8;
        n=100;
        x=zeros(1,n);
        x(1)=1;
        xl=zeros(1,n);
        xl(1)=0.1;
        for k=2:n
            x(k)=r*x(k-1);                  % geometrisches Wachstum
            xl(k)=r*xl(k-1)*(1-xl(k-1));    % Logistische Gleichung
        end
        figure
        plot(x)
        grid;
        title('geometrisches Wachstum')
        figure
        plot(xl)
        title('logistische Gleichung')
        grid;
    case 2 % Konvergenz Logistische Gleichung
        
        r_start=1;
        r_end=4;
        Nr=1000;
        r1=linspace(r_start,r_end,Nr);
        Nx=1000;
        x=zeros(Nr,Nx);
        for k=1:Nr
            r=r1(k);
            x_n=0.1;
            for i=1:Nx
                x_n=r*x_n*(1-x_n);
            end
            x(k,1)=x_n;
            for i=2:Nx
                x(k,i)=r*x(k,i-1)*(1-x(k,i-1)); 
            end    
        end
         x_k=(r1-1)./r1;
        figure
        plot(r1,x,'b.',r1,x_k,'r')
        title('Konvergenz Logistische Funktion')
        grid

    case 3 % Konvergenz Brunnentiefe
        g=9.81;
        v_schall=300;       % Schallgeschwindigkeit                     [m/s]
        
        tm_start=10;        % Zeit bis man den Stein aufschlagen hört  46 [s] 
        tm_end=100;
        Nr=1000;
        tm=linspace(tm_start,tm_end,Nr);
        Nx=1000;
        x=zeros(Nr,Nx);
        for k=1:Nr
            t_mess=tm(k);
            x_n=g/2*t_mess^2;
           
            for i=1:Nx
                x_n=g/(2*v_schall^2)*(t_mess*v_schall-x_n)^2;
            end
            x(k,1)=x_n;
            for i=2:Nx
                x(k,i)=g/(2*v_schall^2)*(t_mess*v_schall-x(k,i-1))^2; 
            end    
        end
        s_genau=v_schall/g*(v_schall+g*tm-sqrt(v_schall^2+2*g*tm*v_schall));
        figure
        plot(tm,x,'b.',tm,s_genau,'r')
        title('Konvergenz Brunnentiefe')
        xlabel('Zeit [s]')
        ylabel('Tiefe [m]')
        grid

end
