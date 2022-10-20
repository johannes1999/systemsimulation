%Simulation der HUD Kinematik

%Löschen aller Variablen im Workspace
clear all;

%Schließen aller Plots
close all;

clc;

home;

ON = 1;
OFF = 0;

%---------------------------------
%Benötigte Variablen

%Simulation
sim_time = 300e-3;          %Zeitdauer der Simulation in [s]

%Simulationsverfahren
%PWM Pulse
pwm_pulse = ON;             %ON - PWM Pulse verwenden OFF - PWM Pulse nicht verwenden
%Kommutierung
komm = OFF;                  %ON - Kommutierungs wird verwenden OFF - Kommutierung wird
                            %nicht verwendet
komm_start = ON;            %ON - Motor startet in einem Kommutierungspunkt OFF - Motor
                            %startet nicht in einem Kommutierungspunkt
%Steigender Duty Cycle
duty_on = OFF;               %ON - Der Duty Cycle steigt bei jedem Impuls um den Wert
                            %von duty_wert an
duty_wert = 5;             %Wert um den der Duty Cycle pro Impuls ansteigt in [%]                            

%PWM
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
%PWM Pulse

pwm_pause = 20e-3;
pwm_on_time = 2e-3;
% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
on_time = 3e-3;             %Einschaltdauer der PWM in [s]
amplitude = 8;              %Ampltide der Motorspannung/PWM in [V]
duty_cycle = 28;            %Duty cycle der PWM in [%]
pwm_periode = 16e-6;        %Periodendauer der PWM in [s]
resolution = 16;            %Auflösung der PWM [Zählerendwert]

%Motor
Jm = 1.069e-6;          %Massenträgheitsmoment des Motors in [kgm^2]

%Getriebe
i = 198;                %Getriebeübersetzung
Jc = 5.4e-5;            %Massenträgheitsmoment des Combiners in [kgm^2]
wirk = 0.38;            %Wirkungsgrad
Mlast = 20e-3;          %30e-3

%Gesamtes Massenträgheitsmoment

J = Jm + (Jc / (i*i));

%------------------------------------
%Anpassen der Parameter, falls PWM Pulse verwendet werden soll
if pwm_pulse == ON
    on_time = sim_time;
end
%if duty_wert == ON
    
%-----------------------------------------------------------

% Starten des Simulationsmodells
sim('Kinematik',[0 sim_time],simset(simget('Kinematik'),'Solver','ode5','FixedStep', 1e-6));

%Ploten der Ergebnisse



figure('name','Title of the window here');
title('Test');

subplot(2,2,1);
plot(t_out.signals.values,w_out.signals.values, t_out.signals.values, (30*w_out.signals.values/pi));
xlabel('time [s]');
ylabel('w [1/s] || n [min^-^1]');
title('Winkelgeschwindigkeit');
grid on;
hold;

subplot(2,2,2);
plot(t_out.signals.values,uind_out.signals.values,t_out.signals.values,ua_out.signals.values,t_out.signals.values,hall_impuls_out.signals.values);
xlabel('time [s]');
ylabel('uind [V] / PWM [V]');
title('Spannungsverlauf / Hall-Sensor');
grid on;
hold;

subplot(2,2,3);
plot(t_out.signals.values,i_out.signals.values);
xlabel('time [s]');
ylabel('i [A]');
title('Motorstrom');
grid on;
hold;

subplot(2,2,4);
[ax, h1, h2] = plotyy(t_out.signals.values,(umdrehung_rad_out.signals.values*180/pi),t_out.signals.values,umdrehung_grad_out.signals.values);
xlabel('time [s]');
set(get(ax(1),'Ylabel'),'String','Umdrehung Combiner [°]') 
set(get(ax(2),'Ylabel'),'String','Umdrehung Motor [°]')
title('Motor / Combiner Bewegung');
grid on;

figure(2)
plot((umdrehung_rad_out.signals.values*180/pi),i_out.signals.values)
grid;
figure
plot(t_out.signals.values,uind_out.signals.values,t_out.signals.values,ua_out.signals.values,t_out.signals.values,hall_impuls_out.signals.values);
figure
%plot(t_out.signals.values,winkelbeschleunigung_out.signals.values)
plotyy(t_out.signals.values,(umdrehung_rad_out.signals.values*180/pi),t_out.signals.values,umdrehung_grad_out.signals.values);


