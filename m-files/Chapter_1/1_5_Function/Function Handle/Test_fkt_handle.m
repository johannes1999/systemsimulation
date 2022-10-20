% m-file: Test_fkt_handle
% 
% Übungsbeispiel zeigt anhand der numerischen Ableitung wie ein 
% function handle funktioniert
%
% 		
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-03-17
%
% Änderung: 
%
% siehe auch: numdiff_1, sin_cardinalis
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen

N=400;          % Anzahl Werte
x_a=0;          % Anfangswert
x_e=20;         % Endwert
dx=0.001;       % Schrittweite zum Differenzieren
x=linspace(x_a,x_e,N);   % Vektor x-Werte

% Funktionen 
f1=@(t) sin(t).*exp(-t/5);
f2=@(x) 0.05*(x-10).^3 +0.2*(x-10).^2+(x-10);

%Funktionswerte
y1=feval(f1,x); % ab Matlab 7 auch einfach y1=f1(x) 
y2=feval(f2,x);
y3=sin_cardinalis(x);
% Berechnung der ersten Ableitung mit der function numdiff 
% mit function handle

dy1_dx=numdiff_1(f1,x,dx);
dy2_dx=numdiff_1(f2,x,dx);
dy3_dx=numdiff_1(@sin_cardinalis,x,dx);

figure
subplot(3,2,1)
    plot(x,y1,'b');
    grid
    title('y1=sin(t) e^{-t/5}')
subplot(3,2,2)
    plot(x,dy1_dx,'r');
    grid
    title('dy1/dx')
subplot(3,2,3)
    plot(x,y2,'b');
    grid
    title('y2=0.05(x-10)^3 +0.2(x-10)^2+(x-10)')
subplot(3,2,4)
    plot(x,dy2_dx,'r');
    grid
    title('dy2/dx')
subplot(3,2,5)
    plot(x,y3,'b');
    grid
    title('y3=sin cardinalis(x)')
subplot(3,2,6)
    plot(x,dy3_dx,'r');
    grid
    title('dy3/dx')    
