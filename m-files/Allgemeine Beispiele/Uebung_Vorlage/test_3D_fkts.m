% test_3D_fkts.m 
% enthält Beispiele für die Berechnung von 3-D Aufgaben  
% 
% 
% Beispiel: 
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-05-11
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
%clearvars;  % workspace löschen
  

Beispiel=2; % 1

if Beispiel==1
% Erzeugen eines x-y Feldes    
x_axis = linspace(-10,10, 30);
y_axis = linspace(-1, 10, 30);

[x, y] = meshgrid(x_axis, y_axis);

% Berechnen von f(x,y)=z
r = sqrt(x.^2 +y.^2);
z = sin(r)./r;

% Verschiedene Darstellungen
% Beispiele aus Kapitel 1
figure;

subplot(3, 2, 1);
mesh(x, y, z);
title('mesh');

subplot(3, 2, 2);
meshc(x, y, z);
title('meshc');

subplot(3, 2, 3);
meshz(x, y, z);
title('meshz');

subplot(3, 2, 4);
surf(x, y, z);
title('surf');

subplot(3, 2, 5);
surfc(x, y, z);
title('surfc');

subplot(3, 2, 6);
waterfall(x, y, z);
title('waterfall');

% Neue Beispiele
% Erzeugen eines x-y Feldes    
x_axis = linspace(-10,10, 100);
y_axis = linspace(-10, 10,100);

[x, y] = meshgrid(x_axis, y_axis);

% Berechnen von f(x,y)=z
r = sqrt(x.^2 +y.^2);
z = sin(r)./r;

figure
subplot(2,2,1);
surf(x, y, z);
% mit 'CDataMapping','scaled' wird der komplette
% Farbraum ausgenutzt. Ohne werden die Werte als 
% Farbe interpretiert!
surf(x, y, z,'CDataMapping','scaled');
title('surf');
shading flat;
  

subplot(2,2,2);
surf(x, y, z,'CDataMapping','scaled');
colormap('jet')
shading flat; axis('equal');   
view(2); % Draufsicht
colorbar; % Zeigt die Farbzuordnung
title('surf mit Draufsicht');

subplot(2,2,3);
image(z,'CDataMapping','scaled');
 axis('equal');   
title('image');

colorbar 

elseif Beispiel==2
    % Erzeugen eines x-y Feldes    
    
    x_axis = linspace(-10,10, 100);
    y_axis = linspace(-10, 10,100);

    [x, y] = meshgrid(x_axis, y_axis);
    x0=10;
    y0=10;
    a=0.1;
    b=1*ones(size(x));
    r = sqrt((x-x0).^2 +(y-y0).^2);
z = 1./(a*r+b);
x_A=-5; y_A=-5; 
r_A = sqrt((x_A-x0).^2 +(y_A-y0).^2);
z_A=1./(a*r_A+b(1,1));

figure
surf(x, y, z,'CDataMapping','scaled','FaceAlpha',0.5);
colormap('jet')
shading flat;   
xlabel('x')
ylabel('y')
zlabel('z')
hold

plot3(x_A,y_A,z_A,'d r')
end
