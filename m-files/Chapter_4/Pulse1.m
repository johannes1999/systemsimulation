% description:		 function [t,y]=Pulse1(Amp,T,samplingrate)
%		 	
%               Berechnung der Zeitfunktion eines Puls mit Standardprofil. Im Zeitbereich von -12.5*T bis 12.5*T
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


function [t,y]=Pulse1(Amp,T,samplingrate)


    T=T/2;                              % Halbe Pulsedauer                  [s]
 
    k1=1.355;
    dT1=k1*T*pi/2;                      % Positive Pre-Pulse
    dT2=2*T/(pi*0.24)+dT1/k1;           % Negative Pre-Pulse
    T_s=[-(dT1+dT2+T) -(dT2+T)  -T];
    
    N=floor(samplingrate*50*T);
    t=linspace(-25*T,25*T,N);
    
        for i=1:floor(length(t)/2)          % Zeitsignal Beschleunigung Shaker [m/s²]
            if  t(i) < T_s(1)
                y(i)=0;
            end
            if (t(i) > T_s(1))& (t(i)<T_s(2))
                 y(i)=0.1785*Amp*sin(2*pi*(t(i)-T_s(1))/(2*dT1)); 
                    if abs(y(i))>0.12*Amp;
                       y(i)=0.12*Amp; 
                    end
             end       
             if (t(i) > T_s(2)) & (t(i)<T_s(3))
                    y(i)=0.445*Amp*sin(2*pi*(t(i)-T_s(3))/(2*dT2)); 
                    if y(i)<-0.24*Amp;
                       y(i)=-0.24*Amp; 
                    end
             end
             if  t(i)>T_s(3)
                    y(i)=Amp*cos(pi/(2*T)*t(i)); 
             end
                    
       end
       y=[y y(length(y):-1:1)];