% m-File: PktLadungen.m
%
% E-Feld von Punktladungen
% 
% autor:	Horst Rumpf
%
% date:		2020-06-22
%
%
% siehe auch:'-'

clearvars; % Variablen löschen
close all;
% Position Punktladungen
%-------------
% 3 Punkt-Ladungen
N=40;
xmin=-1.5;
ymin=-1.5;
xmax=1.5;
ymax=1.5;

P1=[-1 0]';
P2=[1 0]';
P3=[0 1]';
repmat(P1,1,N);
x1=linspace(-1.5,1.5, N);
y1=linspace(-1.5,1.5, N);
[x,y]=meshgrid(x1,y1);
dx1=x-repmat(P1(1,:),N,N);
dy1=y-repmat(P1(2,:),N,N);

P1abs=sqrt(dx1.^2+dy1.^2);
E1x=dx1./P1abs.^3;
E1y=dy1./P1abs.^3;


%E1=sqrt(E1x.^2+E1y.^2);

dx2=x-repmat(P2(1,:),N,N);
dy2=y-repmat(P2(2,:),N,N);

P2abs=sqrt(dx2.^2+dy2.^2);
E2x=-dx2./P2abs.^3;
E2y=-dy2./P2abs.^3;

Ex=E1x+E2x;
Ey=E1y+E2y;
E=sqrt(Ex.^2+Ey.^2);


[Dx,Dy] = gradient(E);

% Richtungsvektor
e_x=Dx./D_betr;
e_y=Dy./D_betr;

x0=-1;
y0=0;
xf(1)=x0;
yf(1)=y0;
ds=0.01;


D_betr=sqrt(Dx.^2+Dy.^2);
Ex(E>10)=NaN;
Ey(E>10)=NaN;
E(E>10)=NaN;
figure
%quiver(x,y,Ex,Ey)
%axis 'equal'

%figure
quiver(x,y,Dx./D_betr,Dy./D_betr)
%axis 'equal'
hold
%figure
contour(x,y,E)
grid
axis 'equal'