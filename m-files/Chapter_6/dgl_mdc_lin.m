% description:		 function Yp = dgl_mdc_lin(t,y,options,m,d,c,Fo)
%		 	
% DGL-System 
%
%
% input:	 	t : Zeit [s]
%   			y : x        : displacement         [m]
%			        x'       : velocity             [m/s]
%               m:	mass                            [kg]
%               d:  damping factor                  [N*s/m]
%               c:  spring const                    [N/m]
%               Fo: Pre-Load                        [N]
%
% output:		Yp: [x'' x']
% 		
%
% example:	    see dynamic_T.m
%		       
%
% copyright:	Philips GmbH, Automotive Playback Modules, (c) 2007
% autor:	    APM-DP,	Horst Rumpf
%
% date:		    18.11.2008
%
% see also:	dynamic_T.m
%  

function Yp = dgl_mdc_lin(~,y,~,m,d,c,Fo)

% System-Matrix
%
% d²s/dt² = dv/dt =-d/m*ds/dt  -c/m*s + F/m
% ds/dt  =  ds/dt = ds/dt
%
%
% In Matrixform
%
%     | dv/dt  |     | -d/m  -c/m |      | ds/dt |     | F/m |
%Yp=  |        |   = |            |   *  |       |  +  |    |
%     | ds/dt  |     |  1       0 |      |  s    |     | 0  |
%
%
%     | ds/dt |
% y=  |       |
%     |  s    |    


% System-Matrix

A=[ -d/m     -c/m 
     1        0  ];

b=[1/m
   0   ];   

% Differential-Gleichungs-System
Yp=A*y+b*Fo;	% Yp=[x''  x']


