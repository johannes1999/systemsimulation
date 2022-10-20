%	function p_gauss_folded
%	Gefaltete Gauss-fkt
%
%	input	:	x,s,xm  :   x: parameter
%			                S:Standard-Abweichung
%                          xm: Mittelwert
%
%	output	:	      p :  Dichtefunktion der Normalverteilung
%
% 	exampl	:	
%
% copyright:	Philips GmbH, Automotive Playback Modules, (c) 2003
% autor:	APM-PT,	Horst Rumpf
% date:		26-08-03
%
% see also:

function p = p_gauss_folded(x,S,xm)

p=1./sqrt(2*pi*S^2).*(exp(-(x-xm).^2./(2*S.^2))+exp(-(x+xm).^2./(2*S.^2)));
p=p.*(x>=0);

