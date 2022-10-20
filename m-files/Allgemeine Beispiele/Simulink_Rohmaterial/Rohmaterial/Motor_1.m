%	function Motor_1.m
%
%	Berechnet die Drehzahl eines DC-Motors mit Berücksichtigung  der
%   Ankerinduktivität
%
%	input	:           Ra  : Ankerwiderstand           [Ohm]
%                       La  : Ankerinduktivität         [H]
%                       Psi : Verketteter Fluß          [Vs]
%                       J   : Massenträgheitsmoment     [kgm/s²]
%                       Io  : Leerlaufstrom             [A]
%
%                       M   : Lastmoment                [Nm]
%                       Ua  : Ankerspannung             [V]
%                       wo  : Anfangsdrehzahl           [1/s]
%
%                       t   : Zeitvekor                 [s]
%
%		
%	output	:           w   : Drehzahlverlauf           [1/s]
%                       Phi : Drehwinkel                [rad]
%                       ia  : Motorstrom                [A]
%                                       
% 	example	:	
%
% 
% copyright:	
% autor:	    Horst Rumpf
% date:		    2014-08-13
%	
% see also: Siehe WUR16-13HRU-045

function [w, Phi, ia] = Motor_1(Ra, La, Psi, Io, J, M, Ua,wo,t)
    
   M_load=M+Io*Psi;
   
   T_m=Ra*J/Psi^2;                          % Elektromechanische Zeitkonstante  [s]
   T_a=La/Ra;                               % Ankerkreiskonstante               [s]
   T_A_m=sqrt((4*T_a^2*T_m)/(T_m-4*T_a));   % Gemischte Zeitkonstante           [s]
   T1=2*T_a*T_A_m/(T_A_m-2*T_a);            % Zeitkonstante 1                   [s]
   T2=2*T_a*T_A_m/(2*T_a+T_A_m);            % Zeitkonstante 2                   [s]
  
   k=1/sqrt(1-4*T_a/T_m);                   % Konstanten zusammengefasst
   k1=(0.5+k/2);
   k2=(0.5-k/2);
   
   w_stat=(Ua/Psi-Ra/Psi^2*M_load);         % Statische Drehzahl                [1/s]
   f_T=k1*exp(-t/T1)+k2*exp(-t/T2);         % Zeitfunktion
    
   w=w_stat*(1-f_T)+wo*f_T;                 % Winkelgeschwindigkeit Fkt von t   [1/s]
  
   Phi=w_stat*t+(wo-w_stat)*(T1*k1*(1-exp(-t/T1))+T2*k2*(1-exp(-t/T2))); % Drehwinkel Fkt von t  [rad]
   ia=1/Psi*M_load*(1-exp(-t/T_m))+J/Psi*(w_stat-wo)*(k1/T1*exp(-t/T1)+k2/T2*exp(-t/T2));% Motorstrom            [A]
 