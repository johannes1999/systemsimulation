% description:		 function Yp = dgl_Buck(t,y,options,para)
%		 	
% DGl eines Buck Converters
%
% System in Matrixform
%
%     |di_L/dt   |     |  0     -1/L   |      |  i_L  |     | 1/L |
% Yp= |          |   = |               |   *  |       |  +  |     |*u_pwm
%     |du_aus/dt |     | 1/C  -1/(R*C) |      | u_aus |     |  0  |
%
%
%     |  i_L  |
% y=  |       |
%     | u_aus |    
%
% input:	 	t :   Zeitvektor                                [s]
%   			y : i_L: Strom durchdie Induktivität            [A]
%			        u_aus: Ausgangsspannung = Spannung an C     [V]
%               ~:   : options for solver, not needed
%               para: 
%                    para(1)=R          Widerstand              [Ohm]
%                    para(2)=C          Kapazität               [F]
%                    para(3)=L          Induktivität            [H]
%                    PWM
%                    para(4)=Ua         Amplitude               [V]
%                    para(5)=f_pwm      PWM Frequenz            [Hz]
%                    para(6)=DutyCycle  Tastverhältnis 0..1     [-]
%			  
% output:		    |di_L/dt   |    
%               Yp= |          | 
%                   |du_aus/dt |   
%
% 		
% autor:	    Horst Rumpf
%
% date:		   3.05.2017
%
% see also:	test_DGL2.m
%  

function Yp = dgl_Buck(t,y,~,para)


R=para(1);              % Widerstand            [Ohm]
C=para(2);              % Kapazität             [F]
L=para(3);              % Induktivität          [H]

% PWM
Ua=para(4);             % Amplitude              [V]
f_pwm=para(5);          % PWM Frequenz           [Hz]
DutyCycle=para(6);      % Tastverhältnis 0..1    [-]

U_pwm=Ua*pwm_t(t,f_pwm,DutyCycle);

% Durch die Diode kann der Strom nie negativ werden
% if y(1)<0
%     y(1)=0;
% end    

% System-Matrix

A=[ 0   -1/L 
   1/C  -1/(R*C)];

b=[1/L
    0 ];   

% DGL
 Yp=A*y+b*U_pwm;	% Yp=[i_L' u_aus']
% if y(1)<0
%     Yp(1)=0;
% end    


