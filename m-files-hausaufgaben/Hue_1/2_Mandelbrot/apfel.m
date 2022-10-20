% m-file: apfel
%
% Dieser m-file ist eine Information zur Hausübung 1.2 
%
% Dieser File ist absichtlich nicht gut kommentiert um den Programmablauf 
% anhand eines Nassi Shneiderman Diagramms selbt nachzuvollziehen.
%
% Input:  Vorgaben im File
% output: kein
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%
% Datum:    16-04-2020
%
% Änderung: 
%
% Benötigte eingene externe functions: keine
%
% siehe auch: mandelbrot
%
%--------------------------------------------------------------------------
close all
clearvars

maxIterations=500;
gridSize=1000;

Bereich='Bereich_2'; % Verschiedene Ausschnitte 

switch Bereich
    case 'Bereich_1'    % Komplettes Apfelmännchen
        xlim = [-2, 1];
        ylim = [ -1.5, 1.5];
        
    case 'Bereich_2'    % Sehr keiner Bereich
        xlim = [-0.748766713922161, -0.748766707771757];
        ylim = [ 0.123640844894862,  0.123640851045266];
end

x=linspace(xlim(1),xlim(2),gridSize);
y=linspace(ylim(1),ylim(2),gridSize);
countRes=zeros(gridSize,gridSize);
    
    for k_re=1:gridSize % x-axis (reelle Achse)	
      for k_im=1:gridSize % y-axis (imaginäre Achse) 
  				count=0;
				z1=0+1i*0;
				c=x(k_re)+1i*y(k_im);
				 	while ((count<maxIterations) && (abs(z1)<2))
				 		z1=z1^2+c;	
 						count=count+1;
					end
				countRes(k_re,k_im)=count;
      end
    end

countRes=log(countRes); % log um die Farbskala logarithmisch zu nutzen

figure;
imagesc(x,y,countRes');
colormap( [jet();flipud( jet() );0 0 0] );
axis('equal','off')
