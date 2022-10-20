% description:		 function Yp = dgl_RCL_r_lin(t,y,options,L,R,C,u,t_in)
%		 	
% DGl eines linearen Reihenschwingkreises. Der zeitliche Verlauf der 
% Versorgungsspannung wird durch den Vektor u vorgegeben. In der Berechung
% werden die benötigten Zwischenwerte linear interpoliert.
%
% input:	 	t :   time                                          [s]
%   			y : i: current                                      [A]
%			    u_c  : Output voltage = capacitor voltage           [V]
%               ~:   : options for solver, not needed   
%                L: Inductance                                      [H]
%                R: Resistance                                      [Ohm]
%                C: Capacity                                        [F]
%                u: Input Voltage                                   [V]
%             t_in: Related time vector                             [s]       
%			  
% output:		Yp: [i' u_c']
% 		
% autor:	    Horst Rumpf
%
% date:		    18.11.2008
%               25.11.2008
%               21.04.2017
%
% see also:	test_DGL2.m
%  

function Yp = dgl_RCL_r_lin(t,y,~,L,R,C,u,t_in)


% System in Matrixform
%
%     |di/dt   |     | -R/L    -1/L  |      | i  |     |    1/L    |
%Yp=  |        |   = |               |   *  |    |  +  |           |*u_1
%     |du_c/dt |     |  1/C      0   |      |u_c |     |     0     |
%
%
%     | i   |
% y=  |     |
%     | u_c |    


% System-Matrix

A=[-R/L     -1/L 
    1/C       0 ];

b=[1/L
    0 ];   

% Eingangsspannung

u_1=interp1(t_in,u,t); % t_in und u sind die Eingabewerte. 
                        % zur Berechnung werden Werte zwischen den
                        % Stützstellen benötigt. die function inpterp1
                        % interpoliert diesen Wert.

% Differential-Gleichung
Yp=A*y+b*u_1;	% Yp=[i' u_c']


