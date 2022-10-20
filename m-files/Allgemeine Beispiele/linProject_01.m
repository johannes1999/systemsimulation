% m-File: linProject_01.m
%
% Lineare Projektion
% Drei Punktepaare bestehen aus Original- und Bild-Punkte 
% {P1,P'1}, {P2,P'2}, {P3,P'3} beschreiben eine lineare Abbildung mit
% der zu bestimmenden Abbildungsmatrix M.
% M*P=P'
%  Die Matrix M wird aus den3 Punktepaare berechnen.
% Dazu wird ein lineares Gleichungssystem aufgestellt und gelöst.
% 
% autor:	Horst Rumpf
%
% date:		2020-06-16
%
%
% siehe auch:'-'

clearvars; % Variablen löschen

% Vorgabewerte
%-------------
% 3 Punkte als einzelne Vektoren
P1=[1 1 2]';
P2=[0 1 2]';
P3=[0 0 1]';

% 3 zugehörige Bild-Punkte als Vektoren
Pp1=[1 2 3]';
Pp2=[3 1 0]';
Pp3=[2 1 1]';

% Die 3 Punkte als Matrix
Pp=[Pp1; Pp2; Pp3];

% Die 3 Bildpunkte als Vektor
P=[P1'; P2'; P3'];

% Koeffizienten-Matrix 
A=zeros(9);

% Füllen der Koeffizienten-Matrix A 
for z=1:3                               % Über alle Zeilen
    for i=1:3                           
        A(3*(z-1)+i,3*i-2:3*i)=P(z,:);
    end    
    
end

if det(A)==0
    disp('Fehler: Punkte sind linear abhängig')
else    
 Mv=A\Pp;               % Abbildungs-Matrix in Vektor-Form
 M=reshape(Mv,3,3)';    % Abbildungs-Matrix
                        % Auf Zeilen-Spalten-Zuordnung achten!
end                          




