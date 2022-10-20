% description:		 function [y f]= lin_sweep(t,f0,f1,t0,t1)
%		 	
% Erzeugt ein linearen sweep eines sinusförmigen Signals im 
% Frequenzbereich von fo bis f1
%
% input:	 	f0: Frequenz zum Zeitpunkt t0
%               f1: Frequenz zum Zeitpunkt t1
%
%               t: Zeitvektor
% output:		f: Frequenzvektor 
% 		        y: Sweep-Vektor
%
% example:      Im Prinzip ist der Sweep eine Phasenmodulation 
%               mit y=sin(phi(t))und  phi(t)=Integral w(t)*dt 
%               mit w(t)=w0+(w1-w0)/(t1-t0)*(t-t0)
%	
% autor:	    Horst Rumpf
%
% date:		 05-04-2004		
%
% see also:	
%  

function [y,f] = lin_sweep(t,f0,f1,t0,t1)

w0=2*pi*f0;
w1=2*pi*f1;
dwdt=(w1-w0)/(t1-t0);
w=w0+dwdt*(t-t0);
f=w/(2*pi);

y=sin(w0*t+dwdt*(0.5*t.^2-t0*t));


