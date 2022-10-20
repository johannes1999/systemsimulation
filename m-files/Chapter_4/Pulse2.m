% description:		 function [t,y]=Pulse1(Amp,T,samplingrate)
%		 	
%               Berechnung der Zeitfunktion eines Puls mit sin(x)/x Im Zeitbereich von -12.5*T bis 12.5*T
% 
%
% input:	 	Amp:            Amplitude
%               T  :            Pulsedauer [ms]
%               Samplingrate:              [Hz]
% output:	    t           :   Time Vector [s]    
% 		        y           :   Time value  
%
% example:	    see Test_Pulseform.m
%		       
%
% copyright:	Philips GmbH, Automotive Playback Modules, (c) 
% autor:	    APM-IP,	Horst Rumpf
%
% date:		   08-03-2005
%		       
%
% see also:	    bump_cdm8.m


function [t,y]=Pulse2(Amp,T,samplingrate)
  T=T/2;
  dt=1/samplingrate;                    
  wo=pi/T;
   t=-25*T:dt:25*T;              % Zeitvektor                       [s]
   
        for i=1:length(t)        % Zeitsignal Beschleunigung Shaker [m/s²]
            if t(i)==0
                y(i)=Amp;
            else
                y(i)=Amp*sin(wo*(t(i)))./(wo*(t(i)));    % prevent  0/0            
            end
             if ((t(i) < -3*T) || (t(i)> 3*T))  % cut out of pulse
                y(i)=0;
            end
        end    
        