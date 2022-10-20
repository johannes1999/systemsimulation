% Bahnkurve.m ist ein m-file um Vorüberlegungen zu dem Projekt Moving Target
% zu testen 
% Ein Target bewegt sich auf einer 2D bzw. 3D-Bahn und wird von einem Jäger
% von einem beliebigen Punkt aus verfolgt.
% 
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2018 erstellt.
%
% Datum:    2018-02-23
%
% Änderung: 
%
% siehe auch: 

%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen
 

% T1 Target Vorgabewerte  
%-----------------------
 Ro_T=6;                % +/- maximale Bewegung in x und y-Richtung [m]
 v_T_max=10;            % max. Bahngeschwindigkeit [m/s]
 m_T=1;                 % Masse Taget               [kg]
 
 % Berechnung des Geländes [m]
 lambda=pi/(Ro_T);              % Wellenlänge des Geländes  [-]
 x_axis = linspace(-1.1*Ro_T,1.1*Ro_T, 100);
 y_axis = linspace(-1.1*Ro_T, 1.1*Ro_T,100);
 [x_g, y_g] = meshgrid(x_axis, y_axis);
 z_g=cos(lambda*x_g)+sin(lambda*y_g);
 
 % T2 abgeleitete Größen
 w_T=v_T_max/(Ro_T*sqrt(5));    % Winkelgeschindigkeit der y-Komponente [1/s]
 T_T=2*pi/w_T;                  % Umlaufzeit für eine Bahn              [s]
 dt=pi/(2*w_T)*1e-2;            % Abtastrate                            [s]
 t_max=2*T_T;                     % Simulationszeit                       [s]
 
 t=0:dt:t_max;                  % Zeitvektor                            [s]
 N=length(t);                   % Anzahl Schritte                       [-]
 
 % T3 Bewegung des Targets in der Ebene und im Raum
 %-------------------------------------------------
 
 % Bahn des Targets [m]
 x_T=Ro_T*sin(2*w_T*t);
 y_T=Ro_T*cos(w_T*t);
 
 z_T=cos(lambda*x_T)+ sin(lambda*y_T);
 
 % Geschwindigkeit des Targets in der Ebene [m/s]
 v_x_T=2*w_T*Ro_T*cos(2*w_T*t);
 v_y_T=-w_T*Ro_T*sin(w_T*t);
 v_T=sqrt(v_x_T.^2+v_y_T.^2);
 v_T_mean=mean(v_T);            %Mittlere Geschwindigkeit
 
 % Geschwindigkeit des Targets im Raum [m/s]
 v_z_T=diff(z_T)/dt;
 v_z_T=[v_z_T v_z_T(end)];
 v_T_3D=sqrt(v_x_T.^2+v_y_T.^2+v_z_T.^2);
 v_T_3D_mean=mean(v_T_3D);      %Mittlere Geschwindigkeit
 
 % Beschleunigung des Targets [m/s²]
 a_x_T=-4*w_T^2*Ro_T*sin(2*w_T*t);
 a_y_T=-w_T^2*Ro_T*cos(w_T*t);
 a_T=sqrt(a_x_T.^2+a_y_T.^2);
 
 a_z_T=diff(v_z_T)/dt;
 a_z_T=[a_z_T a_z_T(end)];
 a_T_3D=sqrt(a_x_T.^2+a_y_T.^2+a_z_T.^2);
 
 % T4 Verrichtete Arbeit [J=Nm]
 % Differentieller Weg [m]
 ds_x=diff(x_T); ds_x=[ds_x ds_x(end)];
 ds_y=diff(y_T); ds_y=[ds_y ds_y(end)];
 
 ds_z=diff(z_T); ds_z=[ds_z ds_z(end)];
 
 % Berechnung durch Summmation (Bewegung in der Ebene)
 dW_T=m_T*abs(dot([ds_x; ds_y],[a_x_T; a_y_T]));
 W_T=cumsum(dW_T); 
 
 % Berechnung durch Integration (Bewegung in der Ebene)
 dW_T1=m_T*abs(dot([v_x_T; v_y_T],[a_x_T; a_y_T]));
 W_T1=csimpson(t,dW_T1);
 
% Berechnung durch Summation (Bewegung im Raum)
 dW_T_3D=m_T*abs(dot([ds_x; ds_y; ds_z],[a_x_T; a_y_T; a_z_T]));
 W_T_3D=cumsum(dW_T_3D);
 
 % T5.1 Darstellung in der Ebene
 %------------------------------
 figure(1);
 subplot(2,2,1)
    plot(x_T,y_T);
    title('S(x,(t),y(t))')
    xlabel('x'); ylabel('y'); grid;
 subplot(2,2,2)
    plot(t,v_x_T,'b',t,v_y_T,'g',t,v_T,'r');
    title('v [m/s]')
    xlabel('t [s]'); ylabel('v[m/s]');
    legend('v_x', 'v_y', '|v|'); grid; 
 subplot(2,2,3)
    plot(t,a_x_T,'b',t,a_y_T,'g',t,a_T,'r');
    title('a [m/s^2]')
    xlabel('t [s]'); ylabel('a[m/s^2]');
    legend('a_x', 'a_y', '|a|'); grid;
 subplot(2,2,4)
    plot(t,W_T,'r',t,W_T1,'-. b');
    title('W [J]')
    xlabel('t [s]'); ylabel('a[m/s^2]'); grid;
 
 % T5.2 Darstellung in der Raum
 %-----------------------------
 figure(2);
 subplot(2,2,1)
    plot3(x_T,y_T,z_T);
    title('S(x,(t),y(t),z(t))')
    xlabel('x'); ylabel('y');zlabel('z'); grid;
 subplot(2,2,2)
    plot(t,v_x_T,'b',t,v_y_T,'g',t,v_z_T,'c',t,v_T_3D,'r');
    title('v_{3D} [m/s]'); grid;
    xlabel('t [s]'); ylabel('v[m/s]');
    legend('v_x', 'v_y', 'v_z', '|v|'); grid; 
 subplot(2,2,3)
    plot(t,a_x_T,'b',t,a_y_T,'g',t,a_z_T,'c',t,a_T_3D,'r');
    title('a_{3D} [m/s^2]'); grid;
    xlabel('t [s]'); ylabel('a[m/s^2]');
    legend('a_x', 'a_y', 'a_z', '|a|'); grid;
 subplot(2,2,4)
 plot(t,W_T_3D,'b');
  title('W_{3D} [J]')
 grid; 

 % 6 Darstellung der Bewegung im Raum
 %-----------------------------------
 
figure(3)
for k=1:N
  
  plot3(x_T(1:k-1),y_T(1:k-1),z_T(1:k-1),'.g',x_T(k),y_T(k),z_T(k),'o r');
  set(gca,'xlim',1.1*[-Ro_T Ro_T],'ylim',1.1*[-Ro_T Ro_T],'zlim',1.1*[-Ro_T Ro_T]);
  %axis('equal')
   hold on
   surf(x_g, y_g, z_g,'CDataMapping','scaled','FaceAlpha',0.5);
   colormap('copper')%  jet
   shading flat;   
   set(gca,'xlim',1.1*[-Ro_T Ro_T],'ylim',1.1*[-Ro_T Ro_T]);
   axis('equal')
   hold off
   pause(0);  
end 
 
% H1 Verfolger (H für Hunter) in der Ebene
%-----------------------------------------

x_HT=0.9;                      % x-fache Geschwindigkeit des Targets
v_H_max=x_HT*v_T_mean;       % Max. Geschwindigkeit des Hunters
t_a_min=5;                  % Beschleuigungszeit bis zur max. Geschwindigkeit
a_H_max=v_H_max/t_a_min;    % Maximale Beschleunigung

% Anfangswerte Verfolger
v_H_o=0;                    % Anfangsgeschwindigkeit
a_H_o=a_H_max;              % Anfangsbeschleunigung
x_H_o=-2*Ro_T;              % Anfangsposition x
y_H_o=2*Ro_T;               % Anfangsposition y

x_H=zeros(1,N);
y_H=zeros(1,N);
v_H=zeros(1,N);

x_H(1)=x_H_o;
y_H(1)=y_H_o;
v_H(1)=v_H_o;

R_catch=0.02;               % Abstand Target - Hunter inhalb dessen das 
                            % Target als gefangen bewertet wird.
k=1;                        % Schleifenzähler
Dx=x_T(k)-x_H(k);           % L Anfangsabstand Target - Hunter
Dy=y_T(k)-y_H(k);
L=sqrt(Dx^2+Dy^2);

figure(4)
while (L>R_catch)&&(k<N)
  
  plot(x_T(1:k-1),y_T(1:k-1),'.g',x_T(k),y_T(k),'o r',x_H(1:k-1),y_H(1:k-1),...
       '. b',x_H(k),y_H(k),'x r');
  set(gca,'xlim',[x_H_o Ro_T],'ylim',[-Ro_T y_H_o]);
  
  pause(0);  
  % Richtungsvektor Hunter zum Target
  Dx=x_T(k)-x_H(k);
  Dy=y_T(k)-y_H(k);
  L=sqrt(Dx^2+Dy^2); % Abstand Hunter zum Target
  Dx=Dx/L;           % Richtungsvektor Hunter - Target
  Dy=Dy/L;
  
  % Strategie Hunter
  % hält immer auf die aktuelle Position des Targets zu
  %----------------------------------------------------
  % Geschwindigkeit Hunter
  v_H(k+1)=v_H(k)+a_H_max*dt;
  
  if v_H(k+1)>v_H_max       % Begrenzung der Geschwindigkeit des Hunters
      v_H(k+1)=v_H_max;
  end
  x_H(k+1)=x_H(k)+v_H(k+1)*dt*Dx;   % Neue Position des Hunters
  y_H(k+1)=y_H(k)+v_H(k+1)*dt*Dy;
  
  k=k+1; % Schleifenzähler erhöhen
end 

% H2 Verfolger (H für Hunter) im Raum
%------------------------------------

%x_HT=1;                     % x-fache Geschwindigkeit des Targets
v_H_max=x_HT*v_T_3D_mean;       % Max. Geschwindigkeit des Hunters
t_a_min=5;                  % Beschleuigungszeit bis zur max. Geschwindigkeit
a_H_max=v_H_max/t_a_min;    % Maximale Beschleunigung

% Anfangswerte Verfolger
v_H_o=0;                    % Anfangsgeschwindigkeit
a_H_o=a_H_max;              % Anfangsbeschleunigung
x_H_o=-2*Ro_T;              % Anfangsposition x
y_H_o=2*Ro_T;               % Anfangsposition y
z_H_o=2*Ro_T;               % Anfangsposition y

x_H=zeros(1,N);
y_H=zeros(1,N);
z_H=zeros(1,N);
v_H=zeros(1,N);

x_H(1)=x_H_o;
y_H(1)=y_H_o;
z_H(1)=z_H_o;
v_H(1)=v_H_o;

R_catch=0.02;               % Abstand Target - Hunter inhalb dessen das 
                            % Target als gefangen bewertet wird.
k=1;                        % Schleifenzähler
Dx=x_T(k)-x_H(k);           % L Anfangsabstand Target - Hunter
Dy=y_T(k)-y_H(k);
Dz=z_T(k)-z_H(k);
L=sqrt(Dx^2+Dy^2++Dz^2);

figure(5)
while (L>R_catch)&&(k<N)
  
  plot3(x_T(1:k-1),y_T(1:k-1),z_T(1:k-1),'.g',x_T(k),y_T(k),z_T(k),'o r',...
        x_H(1:k-1),y_H(1:k-1),z_H(1:k-1),'. b',x_H(k),y_H(k),z_H(k),'x r');
  set(gca,'xlim',1.1*[-Ro_T Ro_T],'ylim',1.1*[-Ro_T Ro_T],'zlim',1.1*[-2 Ro_T]);
  %axis('equal')
  hold on
  surf(x_g, y_g, z_g,'CDataMapping','scaled','FaceAlpha',0.5);
  colormap('copper')%  jet
  shading flat; 
  grid;
  set(gca,'xlim',1.1*[-Ro_T Ro_T],'ylim',1.1*[-Ro_T Ro_T]);
  axis('equal')
  hold off
  pause(0.005);  
  % Richtungsvektor Hunter zum Target
  Dx=x_T(k)-x_H(k);
  Dy=y_T(k)-y_H(k);
  Dz=z_T(k)-z_H(k);
  L=sqrt(Dx^2+Dy^2+Dz^2); % Abstand Hunter zum Target
  Dx=Dx/L;           % Richtungsvektor Hunter - Target
  Dy=Dy/L;
  Dz=Dz/L;
  % Strategie Hunter
  % hält immer auf die aktuelle Position des Targets zu
  %----------------------------------------------------
  % Geschwindigkeit Hunter
  v_H(k+1)=v_H(k)+a_H_max*dt;
  
  if v_H(k+1)>v_H_max       % Begrenzung der Geschwindigkeit des Hunters
      v_H(k+1)=v_H_max;
  end
  x_H(k+1)=x_H(k)+v_H(k+1)*dt*Dx;   % Neue Position des Hunters
  y_H(k+1)=y_H(k)+v_H(k+1)*dt*Dy;
  z_H(k+1)=z_H(k)+v_H(k+1)*dt*Dz;
  if Dz>0                           % Der Hunter soll nie niedriger sein
      z_H(k+1)=z_T(k);              % als die Beute.
  end    
  k=k+1; % Schleifenzähler erhöhen
end    