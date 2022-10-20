%  test_simulink_0.m 
%
% Einführendes Beispiel
% 
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%
% Datum:    2020-08-19
%
% Änderung: 
%
% siehe auch: Simulink Modell SL_Bsp_01
%--------------------------------------
clearvars
close all

% Parameter für das Simulink-Modell SL_Bsp_01
%--------------------------------------------
A=2;                % Amplitude                 
I1_0=-A;            % Integrationskonstante erste Integrator
    
t_sim=linspace(0,4*pi,200); % Zeitvektor                [s]

% Simulink-Modell aufrufen
sim('SL_Bsp_01',t_sim);
       
figure 
 plot(t_sim,Y_1,t_sim,Y_2, t_sim, Y_3);
 grid; xlabel('t [s]'); ylabel('Y_1, Y_2, Y_3')
 title('Simulink Beispiel 01')
 legend('y_1', 'y_2','y_3')
     
 
