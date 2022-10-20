%  function test_Varistor_fkt.m 
%
%
% Testet die Varistor-Kennline
% I=(|U|/B)^n*[A]
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-03
%
% Änderung: 
%
% siehe auch: Varistor_fkt
%--------------------------------------------------------------------------
clear all
close all

N=400;
U_var=linspace(-1.1,1.1,N);

R=0.5;  % ohmscher Widerstand [Ohm]
B=1;    % Grenzspannung Varistor        [V]
n=15;   % Kennliniensteigung Varistor   [-]

I_var=Varistor_fkt(U_var,B,n);  % Strom durch den Varistor
I_R=U_var/R;
U_R=R*I_var;
I=linspace(-4,4,N+1);
U_v=B*sign(I).*abs(I).^(1/n);

% Reihenschaltung
% Gemeinsamer Strom I_d
Uges=U_var+U_R;

% Parallelschaltung
% Gemeinsame Spannung U_var
Iges=I_var+I_R;

figure
subplot(2,2,1)
    plot(U_var,I_var,'r',U_v,I,'b *')
    grid; xlabel('U [V]'); ylabel('I [A]');
    title('Varistor-Kennline')
subplot(2,2,2)
    plot(U_var,I_R,'b')
    grid; xlabel('U [V]'); ylabel('I [A]');
    title('Widerstandskennline')
subplot(2,2,3)
    plot(Uges,I_var)
    grid; xlabel('U [V]'); ylabel('I [A]');
    title('Reihenschaltung')
subplot(2,2,4)
    plot(U_var,Iges)
    grid; xlabel('U [V]'); ylabel('I [A]');
    title('Parallelschaltung')    
% Varistor an einer Sin-Spannung

