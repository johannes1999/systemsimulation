%  m-File test_Diode_fkt.m 
%
% Testet die Diodenfunktion Diode_fkt(U_f)
% I_d=I_s(T)*(exp(U_f/(n*U_T))-1)
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-03
%
% Änderung: 2018-02-26
%
% siehe auch: Diode_fkt
%--------------------------------------------------------------------------
clearvars
close all

N=400;
U_f=linspace(-1,0.85,N);    % Diodenspannung    [V]

R=0.5;                      % Widerstand        [Ohm]
I_d=Diode_fkt(U_f);         % Diodenstrom       [A]

% Reihenschaltung
% Gemeinsamer Strom I_d
U_R=R*I_d;
Uges=U_f+U_R;

% Parallelschaltung
% Gemeinsame Spannung U_f
I_R=U_f/R;
Iges=I_d+I_R;

figure
subplot(2,2,1)
    plot(U_f,I_d,'r')
    grid; xlabel('U [V]'); ylabel('I [A]');
    title('Dioden-Kennline')
subplot(2,2,2)
    plot(U_f,I_R,'b')
    grid; xlabel('U [V]'); ylabel('I [A]');
    title('Widerstandskennline')
subplot(2,2,3)
    plot(Uges,I_d)
    grid; xlabel('U [V]'); ylabel('I [A]');
    title('Reihenschaltung')
subplot(2,2,4)
    plot(U_f,Iges)
    grid; xlabel('U [V]'); ylabel('I [A]');
    title('Parallelschaltung')    
