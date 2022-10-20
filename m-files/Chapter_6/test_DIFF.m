% test_DIFF enthält alle Beispiele für das Differenzen-Verfahren für DGL 2ter
% Ordnung 
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-22
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen
  
Fall=1;
        % 1: DGL mit der Struktur y''=f(x,y)
        % 2: DGl mit der Struktur y''=f(x,y,y')  nicht ausgearbeitet d_dgl_4
       
if Fall ==1
% 1: DGL mit der Struktur y''=f(x,y)    
%-----------------------------------

% Anfangsbedingung
x0=0;           % 
y0 = [1 3/2]';	% Y0=[y_0  dy_dx_0]

% Gesucht: y(x=pi/2)
x_end=pi/2;

% Vorgegebene Genauigkeit
eps_soll=1e-5;
eps_ist=1;          % Startwert für die While-Schleife
Nstuetz=2;          % Anfangswert für die Stützstellenanzahl
n_while=0;          % Whileschleifenzähler

while (eps_ist>eps_soll)    % Abbruch beim Erreichen der Genauigkeit
Nstuetz=Nstuetz*2;          % Verdoppeln der Stützstellenzahl
dx=x_end/Nstuetz;           % Schrittweite

%Anlaufrechnung
x(1)=x0;                                        % erster Punkt
y(1)=y0(1);                                     %
x(2)=x(1)+dx;                                   % zweiter Punkt
y(2)=y0(1)+dx*y0(2)+dx^2/2*dgl_Y2_xy(x0,y0(1)); 

% Differenzen-Verfahren
    for k=3:Nstuetz
        y(k)=-y(k-2)+2*y(k-1)+dx^2*dgl_Y2_xy(x(k-1),y(k-1));
        x(k)=x(k-1)+dx;
    end
% Ermittlung der Genauigkeit    
    y_neu=y(end);
 if n_while==0
    y_alt=y_neu;                       % beim ersten Schleifendurchlauf
 else                                  % den 
    eps_ist= abs((y_alt-y_neu)/y_neu); % relative Änderung
    y_alt=y_neu;
 end
 
 n_while=n_while+1;
end
% Analytische Lösung
y_a=(1+sin(x)).^(3/2);

figure
    plot(x,y,'b',x,y_a,'--r')
    title(' Beispiel DGL mit der Struktur y''=f(x,y)')
    xlabel('x')
    ylabel('y')
    legend('numerisch', 'analytisch')
    grid

elseif Fall==2
% 2: DGl mit der Struktur y''=f(x,y,y')  nicht ausgearbeitet   

end

% Verschiedene DGLs
%------------------

% 1. Beispiel 
%------------
function d2Y_dx2=dgl_Y2_xy(x,y)

d2Y_dx2=3*cos(x)^2/(4*y^(1/3))-3/2*sin(x)*y^(1/3);
end