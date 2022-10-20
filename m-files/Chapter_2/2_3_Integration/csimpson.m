% description:		 function [Int, Err] = csimpson(x,y)
%		 	
% Numerische Integration mit Simpson-Regel 
%
% input:	 	x : Argument-Werte Vektor
%			    y : Funktion-Werte Vektor oder Matrix
%
% output:		Int  : Integral-Vektor
% 			    Err  : 0= Kein Fehler 1= dx-Werte unterschiedlich
%
% example:	x=0:0.001:pi;
%		    y=sin(x);
%		[A, Fehler]=csimpson(x,y)
%		A =Werte entsprechen 1-cos(x)
%		Fehler=0
%
% copyright:	Philips GmbH, Automotive Playback Modules, (c) 1997
% autor:	    APM-IP,	Horst Rumpf
%
% date:		98-02-13		
%
% see also:	simpson



function [Int, Err] = csimpson(x,y)

c=[1 4 1];
n=length(x);
n1=n;
if rem(n,2) == 1
 x(n+1)=x(n)+abs(x(n-1)-x(n));
 y(n+1)=y(n);
 n=length(x);
end

dx=diff(x);
z=0;
Err=0;
Int(1)=0;
 for i=1: 2: (n-2)
       if abs(dx(i)-dx(i+1)) > 1e-5
	  Err=1;
       end
     z=z+(c*[y(i); y(i+1); y(i+2)]*dx(i));
     Int(i+1)=z;
     Int(i+2)=z; 
 end
Int=Int/3;
   for i=1:2:(n-2)
       Int(i+1)=Int(i)+(Int(i+2)-Int(i))/2;	% lineare Interpolation
   end

n2=length(Int);					            % Vektorlänge Ergebnis an Vorgabevektor 
if n2<n1					                % anpassen
    Int(n1)=Int(n2);
end
