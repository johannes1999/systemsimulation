% Die function dgl_RC_PWM(t,Uc,para)
%
% beschreibt eine Reihenschaltung von Widerstand und Kondensator an
% einer PWM-Spannungsversorgung. 
% 
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-14
%
% Änderung: 
%
% siehe auch: test_DGL1_1.m 
%--------------------------------------------------------------------------

function dUc_dt=dgl_RC_PWM(t,Uc,para)

R=para(1);              % Widerstand            [Ohm]
C=para(2);              % Kapazität             [F]

% PWM
Ua=para(3);             % Amplitude              [V]
f_pwm=para(4);          % PWM Frequenz           [Hz]
DutyCycle=para(5);      % Tastverhältnis 0..1    [-]

U_pwm=Ua*pwm_t(t,f_pwm,DutyCycle);

dUc_dt=(-Uc+U_pwm)/(R*C);
