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
% �nderung: 
%
% siehe auch: 

%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace l�schen
  
%%  R�uber - Beute Modell
%-----------------------------------------------

% Umwelt und Tourismus 
% Beispiel aus Einf�hrung in LabVIEW; Wolfgang Georgi; Seite 229

% R�uber Beute Modell
% Beispiel aus Wikipedia

% System Parameter

gx=0.05;   % Geburtenrate Beute
ax=0.003;  % Sterberate Beute
gy=0.1;    % Geburtenrate R�uber
ay=0.002;  % Sterberate R�uber

%Startwerte
B_R0 = [90 15]';	% t=0; B_R= [Beute R�uber]

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
    title('R�uber - Beute Modell')
    legend('Beute', 'R�uber')
    
%% description: function Yp = dgl_Raeuber_Beute(~,y,gx,ax,gy,ay)
%		 
% DGL-System 
%
% input:	 	t :  Zeit wird nicht ben�tigt deswegen ~     
%             y(1):  x Beute
%             y(2):  y R�uber
%               gx:  Geburtenrate Beute
%               ax:  Sterberate Beute
%               gy:  Geburtenrate R�uber
%               ay:  Sterberate R�uber
%
% output:		Yp(1): �nderung  der Beute
% 		        Yp(2): �nderung der R�uber
%



function Yp = dgl_Raeuber_Beute(~,y,gx,ax,gy,ay)
%  ~ ist ein Platzhalter f�r die Zeit.
% Der Solver ruft diese function auf und �bergibt 
% an dieser Stelle die Zeit!
% 
% DGLs
% x'=gx*x-ax*x*y
% y'=-gy*y+ay*x*y

 Yp(1)=gx*y(1)-ax*y(1)*y(2);
 Yp(2)=-gy*y(2) +ay*y(1)*y(2);

Yp=Yp'; % Muss ein Spaltenvektor sein
end
