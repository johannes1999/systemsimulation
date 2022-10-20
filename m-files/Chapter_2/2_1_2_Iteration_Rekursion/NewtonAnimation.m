% m-file NewtonAnimation
%
% Animation zum Newton-Verfahren
% Mit einer beliebigen Taste wird weitergeschaltet!
%
% Newton-Verfahren. Die Ableitung wird mit einem Differenzenquotient
% berechnet. Die Vorgabe der Schrittweite für diesen Quotienten ist fest
% vorgegeben. Es ist zu überlegen ob eine dynamische Anpassung sinnvoll 
% ist. Eine Fehlerausgabe sollte zugefügt werden.
% 
%
% Eingabe:          
% 
% Beispiel:
%         
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%           Kapitel  2.1 Iteration 
%
% Datum:    2020-05-23
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars
close all
  
N=400;                          % Anzahl Werte
n_iter=5;                       % Anzahl Iterations-Schritte
x_max=10.5;                     % x-Werte
x_min=-0.5;
x=linspace(x_min,x_max,N);
y=fkt(x);                       % Funktionswerte
y_min=min(y);
y_max=max(y);
x_n=x_max*0.95;                 % Startwert 

figure 
for i=1:n_iter
    y_n=fkt(x_n);               % Funktions-Startwert
    hold off                    % Bild neu
    plot(x,y,'b','LineWidth',1.5);
    text(x_n,-400,['x_' num2str(i-1)],'FontSize',14,'HorizontalAlignment','center')
    axis('off')
    hold on
    plot([x_min x_max],[ 0 0],'k','LineWidth',0.5); %x-Achse
     
    pause; % mit beliebiger Taste weiter
       
    plot(x_n,y_n,'* r','LineWidth',1.5);            % Neuer Punkt
    plot(x_n*[1 1],[0.1 y_n],'-. k','LineWidth',0.5);
    text(x_n+0.5,y_n,['y_'  num2str(i-1)],'FontSize',14,'HorizontalAlignment','center')
    
    % Newton-Verfahren
    x_0=x_n-y_n/fkt1(x_n);
    y_0=fkt(x_0);
    
    pause; % mit beliebiger Taste weiter
    
    plot([x_n x_0],[y_n 0],'r','LineWidth',1.5);
    plot(x_0,0,'b o','LineWidth',1.5);
    grid
    
    pause; % mit beliebiger Taste weiter
    
    x_n=x_0;
end

% Funktion y(x)
%---------------
function y=fkt(x)
  y=x.^4-400;
end

% Ableitung dy/dx
%----------------
function y1=fkt1(x)
   y1=4*x.^3;
end
  