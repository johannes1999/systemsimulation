% description:		 function [Int, Err] = simpson(x,y)
%		 	
% Numerische Integration mit Simpson-Regel
%
% input:	 	x : Argument-Werte Vektor
%			    y : Funktion-Werte Vektor oder Matrix
%
% output:		Int  : Integralwert
% 			    Err  : 0= Kein Fehler 1= dx-Werte unterschiedlich
%
% example:	x=0:0.001:pi;
%		y=sin(x);
%		[A, Fehler]=simpson(x,y)
%		A =2.0000  
%		Fehler=0
%
% copyright:	Philips GmbH, Automotive Playback Modules, (c) 1997
% autor:	APM-IP,	Horst Rumpf
%
% date:		97-07-28		
%           04-11-2004 Error of calcuation in a case of odd points eliminated
% see also:	csimpson(x,y)



function [Int, Err] = simpson(x,y)

c=[1 4 1];
n=length(x);

if rem(n,2) == 0
 No=n-1;
else
 No=n;
end

dx=diff(x);
z=0;
Err=0;

 for i=1: 2: (No-2)
       if abs(dx(i)-dx(i+1)) > 1e-5
	  Err=1;
       end
     z=z+(c*[y(i); y(i+1); y(i+2)]*dx(i));
 end
Int=z/3;

if rem(n,2)==0
    Int=Int+(y(n-1)+y(n))*dx(n-1)/2; % Last element if numbers of points are odd
end
