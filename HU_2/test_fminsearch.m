% m-file test_fminsearch
%
% Erklärung 
% Nullstellensuche bei mehrparametrigen Funktionen mit fminsearch. 
%
% 
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%
% Datum:    14-06-2020
%
% Änderung: 
%
% siehe auch: test_fminseach_1.m,test_fminseach_2.m, test_fminseach_3.m
%
%--------------------------------------------------------------------------
clearvars;
close all;
Fkt=2;      % 1: Paraboloid
            % 2: Polynomfläche 3ten Grades

switch Fkt
    case 1
        % Funktion beschreiben 

        % Werte-Bereich
        N=50; % Anzahl Werte für die Darstellung
        x_Bereich=linspace(-4,4,N);
        y_Bereich=linspace(-4,4,N);

        % Raster für die Funktion
        [x, y]=meshgrid(x_Bereich, y_Bereich);  
        z=x.^2+y.^2;    % Funktion z(x,y)        
        figure
        mesh(x,y,z)
        xlabel('x'); ylabel('y'); zlabel('z')
    
        StartPunkt=[3 3];    
        % StartPunkt[x-Wert y-Wert]

        NullStelle=fminsearch(@z1,StartPunkt);
        % NullStelle(1)ist der x-Wert und
        % NullStelle(2)ist der y-Wert der Nullstelle
        figure
            mesh(x,y,z)
            xlabel('x')
            ylabel('y')
            zlabel('z')
            hold
            plot3(StartPunkt(1),StartPunkt(2),z1(StartPunkt),'* b','Linewidth',2,'MarkerSize',14)
            plot3(NullStelle(1),NullStelle(2),z1(NullStelle),'* r','Linewidth',2,'MarkerSize',14)
    case 2
        % Funktion beschreiben 

        % Werte-Bereich
        N=50; % Anzahl Werte für die Darstellung
        x_Bereich=linspace(-6,6,N);
        y_Bereich=linspace(-6,6,N);

        % Raster für die Funktion
        [x, y]=meshgrid(x_Bereich, y_Bereich);  
        z=2*x.^3+2*y.^3-50*x-50*y;    % Funktion z(x,y)        
        figure
        mesh(x,y,z)
        xlabel('x'); ylabel('y'); zlabel('z')
    
        StartPunkt=[-2 -2];    
        % StartPunkt[x-Wert y-Wert]

        NullStelle=fminsearch(@z2,StartPunkt);
        % NullStelle(1)ist der x-Wert und
        % NullStelle(2)ist der y-Wert der Nullstelle
        figure
            mesh(x,y,z)
            xlabel('x')
            ylabel('y')
            zlabel('z')
            hold
            plot3(StartPunkt(1),StartPunkt(2),z2(StartPunkt),'* b','Linewidth',2,'MarkerSize',14)
            plot3(NullStelle(1),NullStelle(2),z2(NullStelle),'* r','Linewidth',2,'MarkerSize',14)
end
%% function z1
%-------------
% Argumente für die Funktion z1
% parameter(1) ist der x-Wert
% parameter(2) ist der y-Wert

function z=z1(parameter)
x=parameter(1);
y=parameter(2);
z=x.^2+y.^2;
end

%% function z2
%-------------
% Argumente für die Funktion z2
% parameter(1) ist der x-Wert
% parameter(2) ist der y-Wert

function z=z2(parameter)
x=parameter(1);
y=parameter(2);
z=2*x.^3+2*y.^3-50*x-50*y;    % Funktion z(x,y)     
end

