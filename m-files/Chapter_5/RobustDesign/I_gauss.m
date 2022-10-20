%	function F = I_gauss(S,xm, xu, xo)
%	Verteilungsfunktion der Gauss'schen Glocken-Kurve
%
%	input	:	S  - Standard-Abweichung
%			    xm - Mittelwert
%               xu - untere Integrationsgrenze
%               xo - obere Integrationsgrenze
%
%	output	:	      F :  Integralwert in den Grenzen xu , xo
%
% 	exampl	:	Berechnung Wahrscheinlichkeit 
%
% copyright:	Philips GmbH, Automotive Playback Modules, (c) 2003
% autor:        APM-PT,	Christian Hopf
% date:         2005-07-05
%

function F = I_gauss(S,xm, xu, xo)
x=linspace(xu,xo,10000);
Fx  = 1./(S.*sqrt(2*pi)).*exp(-1/2.*((x-xm)./S).^2);
[F, ~]=simpson(x,Fx);
