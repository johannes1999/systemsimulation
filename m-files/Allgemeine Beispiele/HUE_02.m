% Vorbereitung für die HÜ_01
%
%
% 
% 		
%	
% autor:	Horst Rumpf
%
% date:		2017-03-10
%
%
% siehe auch: R_var	
clearvars
close all

Uo=10;
R=10;
G0=1/10;
B=5;
n=5;
C=0.01;
Tau=R*C;
t_start=0; t_end=5*Tau;
dt_grob=Tau/100;
N=floor((t_end-t_start)/dt_grob);
t=linspace(t_start,t_end,N);
y0=0;
Nonlin=[G0,B,n];
f=@(t,y,Nonlin) (Uo-y)./(R_var(Uo-y,Nonlin)*C);

y=Runge_Kutta4(f,t,y0,Nonlin);

figure
subplot(2,1,1)
plot(t,y);
grid




