% Die function dgl_RvarC_PWM(t,Uc,para)
%
% beschreibt eine Reihenschaltung von einem Varistor und einem Kondensator 
% an einer PWM-Spannungsversorgung. Diese DGL wird im m-file test_DGL1_2.m
% mit verschieden Solver aufgerufen.
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
% siehe auch: test_DGL1_2.m, test_DGL1_t_fkt.m 
%--------------------------------------------------------------------------

function dUc_dt=dgl_RvarC_PWM(t,Uc,para)

C=para(1);          % Kapazität             [F]
B=para(2);          % Varistor-Konstante    [V]
n=para(3);          % Kennliniensteigung    [-]

Ua=para(4);         % Amplitude             [V]
f_pwm=para(5);      % Frequenz              [Hz]
DutyCycle=para(6);  % Tastverhältnis 0...1  [-]

U_pwm=Ua*pwm_t(t,f_pwm,DutyCycle);

dUc_dt=1/C*Varistor_fkt(U_pwm-Uc,B,n);



