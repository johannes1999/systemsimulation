% description:		 function Yp = dgl_RCL_r_n_lin(t,y,options,Lo,R,C,u,a,t_in)
%		 	
% DGl eines nicht-linearen Reihenschwingkreises. Die Induktivität ist 
% stromabhängig. a ist der Faktor, über den die nichtlinearität eingestellt
% wird. 
% Der zeitliche Verlauf der Versorgungsspannung wird durch den 
% Vektor u vorgegeben. In der Berechung
% werden die benötigten Zwischenwerte linear interpoliert.
%
% input:	 	t :    time                                         [s]
%   			y : i: current                                      [A]
%			        u_c      : Output voltage = capacitor voltage   [V]
%          opitons:          : options for solver   
%                L: Inductance                                      [H]
%                R: Resistance                                      [Ohm]
%                C: Capacity                                        [F]
%                u: Input Voltage                                   [V]
%             t_in: Related time vector                             [s]       
%                a: nonlinear factor                                [1/A]
%			   
%
% output:		Yp: [i' u_c']
% 		
%
% example:	    see dynamic_T.m
%
% copyright:	Philips GmbH, Automotive Playback Modules, (c) 2008
% autor:	    APM-DP,	Horst Rumpf
%
% date:		    18.11.2008
%               26.11.2008
%
% see also:	dynamic_T.m
%  

function Yp = dgl_RCL_r_n_lin(t,y,~,Lo,R,C,u,a,t_in)

% System-Matrix
%
% di/dt    =-R/L*i  -1/L*u_c + u_1*1/L
% du_c/dt  = 1/C*i

%
% In Matrixform
%
%     |di/dt   |     | -R/L(i)  -1/L(i) |      | i |     | 1/L(i) |
%Yp=  |        |   = |                  |   *  |   |  +  |        |*u_1
%     |du_c/dt |     |  1/C      0      |      |u_c|     |   0    |
%
% with L(i)=L1=3*Lo*(sinh(a*y(1)).^2-(a*y(1)).^2)/(sinh(a*y(1)).^2*(a*y(1)).^2);
%      y(1)= i
%      for i=0 L(i=0)=Lo
%
%     | i   |
% y=  |     |
%     | u_c |    


% Inductance with magnetisation influence (see example 1  Numerische Verfahren der Elektrotechnik)
if (y(1)==0)||(a==0) 
        L1=Lo;
    else
        L1=3*Lo*(sinh(a*y(1)).^2-(a*y(1)).^2)/(sinh(a*y(1)).^2*(a*y(1)).^2);
end    

% System-Matrix

A=[-R/L1    -1/L1;
    1/C       0 ];

b=[1/L1
    0 ];   

% Distortion function

u_1=interp1(t_in,u,t); % interpolate u_1 at t from the given vectors t_in and u 

% Differential-Equation-System
Yp=A*y+b*u_1;	% Yp=[i' u_c']
