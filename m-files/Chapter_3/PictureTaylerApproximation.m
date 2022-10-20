%PictureTaylerApproximation.m 
%
% Geometrische Deutung Talyor Approximation
% IN ARBEIT: Gestaltet sich eher schwierig
%
% DGL: RC-Reihenschaltung an einer Wechselspannung 
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%
% Datum:    2020-05-25
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars;
close all;

x_0=0; y_0=0;
x_max=10;
n=400;
x=linspace(x_0,x_max,n);
dx=x(2)-x(1);
y=zeros(1,n);
dy_dx=y+0.5*x.^2;

%% Euler Vorwärts
%----------------

y(1)=y_0;      % Anfangswert
  for i=2:n
      y(i)=y(i-1)+(y(i-1)+0.5*x(i-1)^2)*dx;   
  end
 
%% Ausgabe
%---------
x_n=9;
[~,n_x]=min(abs(x-x_n));
y_max=max(y);
dy_dx_max=max(dy_dx);
plot3(x,y,dy_dx,'LineWidth',2);
hold
plot3(x,y,0*dy_dx);
plot3(x,0*y,dy_dx,'-.');
plot3(0*x,y,dy_dx,'-.');
plot3(x_n,y(n_x),dy_dx(n_x),'*r','LineWidth',2);

plot3(x_n*[1 1],y(n_x)*[1 1],[0 dy_dx(n_x)],'-. r');
plot3(x_n*[1 0],y(n_x)*[1 1],[0 0],'-. k','LineWidth',0.5);
plot3(x_n*[1 0],y(n_x)*[1 1],dy_dx(n_x)*[1 1],'-. k','LineWidth',0.5);
plot3(x_n*[1 1],y(n_x)*[1 0],dy_dx(n_x)*[1 1],'-. k','LineWidth',0.5);
% Koordinaten-Achsen
plot3([0 x_max], [0 0], [0 0],'k');
plot3([0 0], [0 y_max], [0 0],'k');
plot3([0 0], [0 0], [0 dy_dx_max],'k');
text( x_max,0,-2,'x','FontSize',14)
text( 0,y_max,-2,'y','FontSize',14)
text( 2.5,0,dy_dx_max-4,'f(x,y(x))','FontSize',14)
axis('off')
AZ =204;
EL =32.5;
view(AZ,EL);




