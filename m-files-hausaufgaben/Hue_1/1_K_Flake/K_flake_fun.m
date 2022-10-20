% function K_flake_fun
%
% Erklärung 
% Das Argument Punkte ist eine Matrix. In der ersten Zeile stehen die
% x-Koordinaten und in der zweiten Zeile die y-Koordinaten von einem 
% Anfangskurvenzug. Zu beachten ist, dass der letzte Punkt gleich
% dem ersten sein muss, wenn sich der Weg wieder shließen soll, z.B. bei 
% einem gleichseitigen Dreieck. Das zweite Argument gibt die Anzahl der 
% Iterationen an. 
% Mehr als 7 ist nicht sinnvoll, da man die Unterschiede kaum mehr erkennt.
%
% Beispiel:   
%           punkte=[-5 0 5 -5;  0 sqrt(75) 0 0];
%           Diese Punkte ergeben als Anfangskurvenzug ein Dreieck.
%           tiefe=7;        
%           K_flake_fun(punkte, tiefe)       
% 		
%	
% Autor:	
% Quelle: http://www.design1a.de/article/Die_Kochsche_Schneeflockenkurve
%
%           Dieser m-File wurde zur Vorbereitung der Hausübung 1 SS 2020 
%           genutzt.
%
% Datum:    2020-04-16
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------

function [x,y]=K_flake_fun(punkte, tiefe)

[~, n2] = size(punkte);
p = n2-1;
l = 4^tiefe;
n = p*l+1;
x = zeros(n,1);
y = zeros(n,1);

for i=0:p
    x(i*l+1) = punkte(1,i+1);
    y(i*l+1) = punkte(2,i+1);
end

for i=1:tiefe
    l=round(l/4);
for j=0:p-1
    % Indizes
    k0 = j*4*l+1;
    k1 = k0+l;
    k2 = k0+2*l;
    k3 = k0+3*l;
    k4 = (j+1)*4*l+1;

    x(k1)=x(k0)+(x(k4)-x(k0))/3;
    y(k1)=y(k0)+(y(k4)-y(k0))/3;
    x(k3)=x(k4)-(x(k4)-x(k0))/3;
    y(k3)=y(k4)-(y(k4)-y(k0))/3;

    x(k2)=x(k1)+(x(k3)-x(k1))/2+sqrt(3)*(y(k1)-y(k3))/2;
    y(k2)=y(k1)+(y(k3)-y(k1))/2+sqrt(3)*(x(k3)-x(k1))/2;
end
p=p*4;
end

figure;
fill(x,y,'b');
axis('equal','off')