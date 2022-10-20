%	function p_gauss
%	Glocken-Kurve
%
%	input	:	x,s,xm  :   x: parameter
%			                S:Standard-Abweichung
%                          xm: Mittelwert
%
%	output	:	      p :  Dichtefunktion der Normalverteilung
%
% 	exampl	:	
%
% autor:	Horst Rumpf
% date:		26-08-03
%
% see also:

function p = p_gauss(x,S,xm)

p=1./sqrt(2*pi*S^2).*exp(-(x-xm).^2./(2*S.^2));

