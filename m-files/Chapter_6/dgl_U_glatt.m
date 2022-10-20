% description:		 function Yp = dgl_U_glatt(t,y,options,R_V,R_L,C_L,u,t_in)
%		 	
% DGL-System: Glättung einer gleichgerichteten Wechselspannung
%             
%
% input:	 	t :    time                                         [s]
%   			u :    Gleichgerichtete Spannung                    [V]
%          opitons:          : options for solver   
%                R_V: Vorwiderstand                                 [Ohm]
%                R_L: Vorwiderstand                                 [Ohm]
%                C_L: Glättungswiderstand                           [F]
%                u  : Gleichgerichtete Spannung                     [V]
%               t_in: Related time vector                           [s]       
%			   
%
% output:		Yp: [u_L']
% 		
%
% example:	    see dynamic_T.m
%
% copyright:	PLDS, (c) 2011
% autor:	   	Horst Rumpf
%
% date:		    30.08.2011
%             
%
% see also:	dynamic_T.m
%  

function Yp = dgl_U_glatt(t,u_L,~,R_V,R_L,C_L,u,t_in)

% DGL
%
% du_L/dt    =1/(R_V*C_L)*(u_o-u_L*(1+R_V/R_L))


% Distortion function

u_o=interp1(t_in,u,t); % interpolate u_1 at t from the given vectors t_in and u 

% Differential-Equation-System
Yp=1/(R_V*C_L)*(u_o-u_L*(1+R_V/R_L));	%

a=C_L*Yp+u_L/R_L;
if a < 0
    Yp=-u_L/(R_L*C_L);	%
end
