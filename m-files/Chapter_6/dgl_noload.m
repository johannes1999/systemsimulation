% description:		 function Yp = dgl_noload(t,y,options,L1,R1,L2,R2,C1,u,t_in)
%		 	
% DGL-System 
%
%
% input:	 	t :   time                                          [s]
%   			y : i: current                                      [A]
%			        u_c      : Output voltage = capacitor voltage   [V]
%          options:          : options for solver   
%                L: Inductance                                      [H]
%                R: Resistance                                      [Ohm]
%                C: Capacity                                        [F]
%                u: Input Voltage                                   [V]
%             t_in: Related time vector                             [s]       

%			  
% output:		Yp: [i' u_c']
% 		
%
% example:	    see dynamic_T.m
%
% copyright:	Philips GmbH, Automotive Playback Modules, (c) 2007
% autor:	    APM-DP,	Horst Rumpf
%
% date:		    5.08.2011
%
% see also:	dynamic_T.m
%  

function Yp = dgl_noload(t,y,options,L1,R1,L2,R2,C1,u,t_in)

% System-Matrix
%
% di/dt    =-R/L*i  -1/L*u_c + u_1*1/L
% du_c/dt  = 1/C*i

%
% In Matrixform
%
%     |dio/dt  |     | -R1/L1    0   -1/L1 |      | io  |     |   1/L1  |
%     |        |   = |                     |      |     |     |         |
% Yp= |di2/dt  |     |    0   -R2/L2  1/L2 |   *  | i2  |  +  |    0    |*Uo
%     |        |   = |                     |      |     |     |         |
%     |duc/dt  |     |  1/C1  -1/C1    0   |   *  | u_c |  +  |    0    |

%
%
%     | io  |
% y=  | i2  |
%     | u_c |    


% System-Matrix

A=[-R1/L1    0   -1/L1; 
      0   -R2/L2  1/L2;
     1/C1  -1/C1   0   ];

b=[1/L1
    0 
    0  ];


% Distortion function

u_o=interp1(t_in,u,t); % interpolate u_1 at t from the given vectors t_in and u

% Differential-Equation
Yp=A*y+b*u_o;	% Yp=[io' i2' u_c']
