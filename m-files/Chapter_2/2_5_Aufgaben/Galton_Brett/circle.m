%	function c=circle(xm, ym, r, Al_begin, Al_end)
%			
%
%	description:	This function greates a marix for a circle
%			
%	input:		xm,ym		:	centre point 
%                   r		:	radius
%			Al_begin,Al_end	:	start and end angle [rad]
%
%	output:		c		: 	3x101 Matrix 
%						c(1,:) x-values; 
%						c(2,:) y-values; 
%						c(3,:) z-values=1 (only needed for
%						simple use of rotation and tranlation)
%	example:	
%			
%	result:		
%
%	copyright:	Philips GmbH, Automotive Playback Modules, (c) 1998
%	author:		APM-IP, Horst Rumpf,see Pascal Porcedure 89-02-05
%
%	version:	MATLAB 4.2
%	date:		98-08-05
%
%
%	See also:	rotation, trlate

function c=circle(xm, ym, r, Al_begin, Al_end)

N=100;				% numbers of points
step=(Al_end-Al_begin)/N;
t=Al_begin: step: Al_end;
x=r*cos(t)+xm;
y=r*sin(t)+ym;
c=[x; y; ones(size(t))];
