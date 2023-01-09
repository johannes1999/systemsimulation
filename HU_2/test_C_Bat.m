close all;  % Alle plots schliessen
clearvars;  % workspace löschen



cBat = 1;
rBat = 0.2;
cLast = 0.5;
rLast = 0.1;

Tau=cBat*rBat;     % Zeitkonstante der Dämpfung    [s]
dt=0.001;          % Abtastzeit                    [s]
tmax=4*Tau;        % Simulationszeit               [s]

t=0:dt:tmax;       % Zeitvektor                    [s]

uBat0=5;    % Spannung an der Batterie  [V]
uLast0=0;   % Spannung an der Last      [V]

y0 = [uBat0 uLast0]';	% t=0;
[~,y] = ode45(@dgl_RCC,t,y0,[],cLast,cBat,rBat,rLast);
uBat =y(:,1);   % Spannung an der Batterie  [V]
uLast =y(:,2);  % Spannung an der Last      [V]

figure
    plot(t,uBat,'b',t,uLast,'r')
    title('Entladung der Batterie in den Kondensator')
    xlabel(' t [s]')
    ylabel(' uBat [V]; uLast [V]')
    grid
    legend('uBat', 'uLast')


duBatdt=@(cBat, rBat, uLast, uBat) (1/(cBat*rBat))*(uLast-uBat);

duLastdt=@(uBat, cLast, rBat, uLast, rLast) (uBat/(cLast*rBat))*(uLast/(cLast*((rLast*rBat)/(rBat+rLast))));

function Yp = dgl_RCC(~,y, cLast, cBat, rBat, rLast)

    uBat=y(1);    % Spannung an der Batterie  [V]
    uLast=y(2);   % Spannung an der Last      [V]
    
    % Differentialgleichssystem
    duBatdt=(1/(cBat*rBat))*(uLast-uBat);
    duLastdt=(uBat/(cLast*rBat))*(uLast/(cLast*((rLast*rBat)/(rBat+rLast))));
    
    % Rückgabewerte    
    Yp=[duBatdt
        duLastdt]; 

end % function
