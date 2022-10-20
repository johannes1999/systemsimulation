% description:		 function pwm_t
%		 	
% PWM als Zeitfunktion
% 
% 
% input:
%       Zeitpunkt oder Zeitvektor   :   t           [s]
%       PWM-Frequenz                :   f_PWM       [Hz]
%       Duty Cycle                  :   D           [%/100]

% output:	
%           PWM Wert(e)             :   A         [-]
%
% example:	
%           
%		
%
% copyright:    
% autor:	    Horst Rumpf
%
% date:		    27-10-2016
%
% see also:	
% 

function A = pwm_t(t,f_PWM,D)

w=pi*f_PWM;   % Winkelgeschwindigkeit [1/s]
              % Wegen Frequenzverdopplung durch die Betragsbildung
              % nur pi*f und nicht 2*pi*f

A=abs(sign(sin(w*t))-sign(sin(w*t-D*pi)))/2;