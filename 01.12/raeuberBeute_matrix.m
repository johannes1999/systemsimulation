close all;  % Alle plots schliessen
clearvars;  % workspace löschen



gx = 0.05;
gy = 0.1;
ax = 0.003;
ay = 0.002;

dt=0.01;          % Abtastzeit                    [s]
tmax=200;        % Simulationszeit               [s]

t=0:dt:tmax;       % Zeitvektor                    [s]

x_0=90;    % Beute  [n]
y_0=15;   % Räuber      [n]

y0 = [x_0 y_0]';	% t=0;
[~,y] = ode45(@dgl_Raeuber_Beute,t,y0,[],gx,ax,gy,ay);
beute =y(:,1);   % Spannung an der Batterie  [V]
raeuber =y(:,2);  % Spannung an der Last      [V]

figure
    plot(t,beute,'b',t,raeuber,'r')
    title('Räuber-Beute Modell')
    xlabel(' t [s]')
    ylabel(' beute [n]; raeuber [n]')
    grid


function Yp = dgl_Raeuber_Beute(~,y,gx,ax,gy,ay)


Yp(1)=gx*y(1)-ax*y(1)*y(2);
Yp(2)=-gy*y(2) +ay*y(1)*y(2);

Yp=Yp'; % Muss ein Spaltenvektor sein


end % function