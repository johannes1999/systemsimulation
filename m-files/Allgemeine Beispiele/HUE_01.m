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

N=400;
Uo=10;
U=linspace(-Uo,Uo,N);
B=5;        % Bei B fliessen ca 1A  B   [V]
R0=100000000;       % Widerstandswert bei U=0   [Ohm]
G0=1/R0;     
n=5;        % Steilheit der Kennline

R=R_var(U,[G0, B, n]);
I=U./R;
figure
subplot(2,1,1)
plot(U,R);
grid
subplot(2,1,2)
plot(U,I);
grid





