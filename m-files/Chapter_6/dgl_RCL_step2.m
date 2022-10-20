% description:		 function Yp = dgl_RCL_step2(t,y,p)
%		 	
% DGl eines linearen Reihenschwingkreises (Sprungantwort Uo=const).
%
%
% input:	 	t :    time                                         [s]
%   			y : i: current                                      [A]
%			        u_c      : Output voltage = capacitor voltage   [V]
%          opitons:          : options for solver   
%                L: Inductance                                      [H]
%                R: Resistance                                      [Ohm]
%                C: Capacity                                        [F]
%               Uo: Input Voltage                                   [V]
%			   
%
% output:		Yp: [i' u_c']
% 		
%
% example:	    siehe test_DGL2.m (und dynamic_T.m)
%
% copyright:	Philips GmbH, Automotive Playback Modules, (c) 2008
% autor:	    APM-DP,	Horst Rumpf
%
% date:		    18.11.2008
%               26.11.2008
%               20.06.2018
%               9.05.2019 angepasst auf eigenen Solver

% see also:	test DGL2.m
%  

function Yp = dgl_RCL_step2(~,y,p)
             
% System-Matrix
%
% di/dt    =-R/L*i  -1/L*u_c + Uo*1/L
% du_c/dt  = 1/C*i

%
% In Matrixform
%
%     |di/dt   |     | -R/L  -1/L |    | i |     | 1/L |
%Yp=  |        |   = |            | *  |   |  +  |     |*Uo
%     |du_c/dt |     |  1/C    0  |    |u_c|     |  0  |
%
%
%     | i   |
% y=  |     |
%     | u_c |    

% Parameterübergabe
L=p(1);
R=p(2);
C=p(3);
Uo=p(4);

% System-Matrix

A=[-R/L    -1/L;
    1/C      0 ];

b=[1/L
    0 ];   
% DGL-System

Yp=A*y+b*Uo;	% Yp=[i' u_c']
