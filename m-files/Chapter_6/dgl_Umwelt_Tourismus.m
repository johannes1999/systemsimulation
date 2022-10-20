% description:		 function Yp = dgl_Umwelt_Tourismus(t,y,[],a,b,c,d,k);	
%		 
% DGL-System 
%
% input:	 	t : Zeit      
%             y(1):  x Massenstrom der Touristen
%             y(2):  y Qualit�t der Umwelt
%   			a : Touristenzahlverlustrate infolge von �berf�llung
%               b : Werbewirkung durch Umweltqualit�t
%               c : Rate der Umweltzerst�rung
%               d : Rate der Umwelterholung
%               k : Tragf�higkeit der Umwelt

%
% output:		Yp(1): �nderung des Touristenmassenstroms
% 		        Yp(2): �nderung der Umweltqualit�t
%
% example:	    see dynamic_T.m
%		        
%
% copyright:	Philips GmbH, Automotive Playback Modules, (c) 2008
% autor:	    APM-DP,	Horst Rumpf
%
% date:		    25.11.2008
%
% see also:	dynamic_T.m
%  

function Yp = dgl_Umwelt_Tourismus(t,y,~,a,b,c,d,k)

% 
% x'=-a*x+b*y
% y'=d+y*(1-y/k)-c*x*y

Yp(1)=-a*y(1)+b*y(2);
Yp(2)=d*y(2)*(1-y(2)/k)-c*y(1)*y(2);

Yp=Yp';

