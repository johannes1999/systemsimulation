% Rauber_Beute_Bsp.m wurde erstellt um die Umsetzung 
% eines DGL-Systems erster Ordnung mit matlab deutlich zu machen.	
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%
% Datum:    2020-08-20
%
% Änderung: 
%
% siehe auch: 

%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen
  
%%  Räuber - Beute Modell
%-----------------------------------------------

% Umwelt und Tourismus 
% Beispiel aus Einführung in LabVIEW; Wolfgang Georgi; Seite 229

% Räuber Beute Modell
% Beispiel aus Wikipedia

% System Parameter

gx=0.05;   % Geburtenrate Beute
ax=0.003;  % Sterberate Beute
gy=0.1;    % Geburtenrate Räuber
ay=0.002;  % Sterberate Räuber

%Startwerte
B_R0 = [90 15]';	% t=0; B_R= [Beute Räuber]

% Simulationszeit
N=1000;
t_start =0;
t_end   =200;
t=linspace(t_start, t_end, N);

[~,B_R] = ode45(@dgl_Raeuber_Beute,t,B_R0,[],gx,ax,gy,ay);	
 


figure

    plot(t,B_R(:,1),'b',t,B_R(:,2),'r')
    grid;
    xlabel('t [Jahre]');
    ylabel('Population [-]');
    title('Räuber - Beute Modell')
    legend('Beute', 'Räuber')
    
%% description: function Yp = dgl_Raeuber_Beute(~,y,gx,ax,gy,ay)
%		 
% DGL-System 
%
% input:	 	t :  Zeit wird nicht benötigt deswegen ~     
%             y(1):  x Beute
%             y(2):  y Räuber
%               gx:  Geburtenrate Beute
%               ax:  Sterberate Beute
%               gy:  Geburtenrate Räuber
%               ay:  Sterberate Räuber
%
% output:		Yp(1): Änderung  der Beute
% 		        Yp(2): Änderung der Räuber
%



function Yp = dgl_Raeuber_Beute(~,y,gx,ax,gy,ay)
%  ~ ist ein Platzhalter für die Zeit.
% Der Solver ruft diese function auf und übergibt 
% an dieser Stelle die Zeit!
% 
% DGLs
% x'=gx*x-ax*x*y
% y'=-gy*y+ay*x*y

 Yp(1)=gx*y(1)-ax*y(1)*y(2);
 Yp(2)=-gy*y(2) +ay*y(1)*y(2);

Yp=Yp'; % Muss ein Spaltenvektor sein
end
