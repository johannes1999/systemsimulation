% Warping.m
%
% Übungsaufgabe für Matrizen-Rechnung mit matlab 
% Beispiel geometrische Transformation (Warping) eines Dreiecks:
% Translation; Rotation Skalierung; Scherung 
%                 
% 		
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-26
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen. Neue matlab-Version nutzt clearvars!

DreiEck=[0 1 1 0    % x- Werte
         0 0 1 0    % y- Werte
         1 1 1 1];

% Translation
ax=1; ay=1;
T_trans=[1 0 ax
         0 1 ay
         0 0  1];

% Rotation
phi=30*pi/180; c_P=cos(phi); s_P=sin(phi);
T_rot=[c_P -s_P  0
       s_P  c_P  0
        0    0   1]; 

% Skalierung
sx=2; sy=2;
T_skal=[sx 0  0
         0 sy 0
         0 0  1];    
% Scherung
Hx=0.0; Hy=.0;
T_scher=[1   Hx  0
         Hy  1   0
         0   0   1];  
     
DreiEck1=T_scher*T_skal*T_trans*T_rot*DreiEck;    
DreiEck2=T_scher*T_skal*T_rot*T_trans*DreiEck;         

figure
plot(DreiEck(1,:),DreiEck(2,:),'b', DreiEck1(1,:),DreiEck1(2,:),'r',...
     DreiEck2(1,:),DreiEck2(2,:),'g')
axis('equal')
grid
