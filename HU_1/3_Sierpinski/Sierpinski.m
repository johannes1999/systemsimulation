% m-file: Sierpinski
%
% 
% Dieser m-file ist eine Information zur Hausübung 1.3
%
% Dieser File ist absichtlich nicht gut kommentiert um den Programmablauf 
% anhand eines Nassi Shneiderman Diagramms selbt nachzuvollziehen.
%
% Erklärung 
% siehe wikipedia Sierpinski Dreieck und Zellulärer Automat
%
% Input:  Vorgaben im File
% output: kein
%	
% Autor:  Beispiel 1 Zufall
% Quelle: https://de.mathworks.com/matlabcentral/answers/
%         2180-plotting-sierpinski-s-triangle
%
% Dieser m-File wurde zur Vorbereitung der Hausübung 1.3 SS 2020 
% genutzt.
%
% Autor: Beispiel 2 Zelle
%        Horst Rumpf
%
% Datum:    2020-04-16
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars;
close all;

 %Beispiel='Zufall';     % 1: Zufalls-Algorithmus
 Beispiel='Zelle';      % 2: Zellularer Automat
  
switch Beispiel
    case 'Zufall'
        
    N=100000;
    x=zeros(1,N);y=x;
    for a=2:N
        c=randi([0 2]);    
        switch c
        case 0    
            x(a)=0.5*x(a-1);
            y(a)=0.5*y(a-1);
        case 1
            x(a)=0.5*x(a-1)+.25;
            y(a)=0.5*y(a-1)+sqrt(3)/4;
        case 2
            x(a)=0.5*x(a-1)+.5;
            y(a)=0.5*y(a-1);
        end
    end
    figure
    plot(x,y,'k .')
    title('Sierpinski’s triangle made in matlab by Paulo Silva')
    legend(sprintf('N=%d Iterations',N))

    case 'Zelle'
    % Zellularer Automat
        sizeX = 1000;
        sizeY = fix(sizeX/1.95);    % Die Größen in y wurde so gewählt dass
                                    % das Ergebnis gleich ist zu dem ersten
                                    % Beispiel
        SP=zeros(sizeY, sizeX);
        SP(1,fix(sizeX/2))=1;
     
        for z=2:sizeY
            for s=2:sizeX-1
                if (SP(z-1,s-1))~= (SP(z-1,s+1))    
                    SP(z,s)=1;
                end    
            end             
        end
        figure
        imagesc( SP );
        colormap( [1 1 1;0 0 0] );   
        axis('equal')
        axis('off')
        title('Sierpinski Dreieck mit Zellularem Automaten')
end    