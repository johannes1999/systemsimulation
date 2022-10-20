% Die Function y=Runge_Kutta4sys(f,t,y0,param_f) 
%
% löst mit dem Runge-Kutta Verfahren 4ter Ordnung ein DGL Gleichungssystem
% erster Ordung mit konstanten Koeffizienten mit n Gleichungen:
% y'(n)=f(t,y(n))
% Werden noch weitere Parameter param_f für die Funktion f mit übergeben 
% können auch DGLs erste Ordnung mit abhängigen Koeffizienten berücksichtigt
% werden.
%
% Eingabe:          f       : Function handle     
%                   t       : Zeitvektor
%                   y0      : Anfangswerte Spaltenvektor mit n-Werten 
%                   param_f : Zusätzliche Parameter für die Funktion f 
% 		
%	
% autor:	Horst Rumpf
%
% date:		2019-05-09
%
% siehe auch: test_DGL2	

function y=Runge_Kutta4sys(f,t,y0,param_f)

n_t=length(t);          % Länge des Zeitvektors
dt=t(2)-t(1);           % Schrittweite

N_DGLs=length(y0);      % Anzahl Differentialgleichungen 1ter Ordnung
y=zeros(N_DGLs,n_t);    % Initialisierung des Ausgabevektors
y(:,1)=y0;              % Anfangswerte zuweisen

if nargin==4        % zusätzliche Parameter für f d.h. f(t,y,param_f)  
    for i=2:n_t       
        l0=f(t(i-1),y(:,i-1),param_f);
        l1=f(t(i-1)+dt/2,y(:,i-1)+dt/2*l0,param_f);
        l2=f(t(i-1)+dt/2,y(:,i-1)+dt/2*l1,param_f);
        l3=f(t(i-1)+dt/2,y(:,i-1)+dt/2*l2,param_f);
        y(:,i)=y(:,i-1)+dt/6*(l0+2*l1+2*l2+l3);     
    end    
else                % keine zusätzliche Parameter für f d.h. f(t,y,param_f)  
    for i=2:n_t
        l0=f(t(i-1),y(:,i-1));
        l1=f(t(i-1)+dt/2,y(:,i-1)+dt/2*l0);
        l2=f(t(i-1)+dt/2,y(:,i-1)+dt/2*l1);
        l3=f(t(i-1)+dt/2,y(:,i-1)+dt/2*l2);
        
        y(:,i)=y(:,i-1)+dt/6*(l0+2*l1+2*l2+l3);  
    end
end
y=y'; % Ausgabevektor wird gedreht, damit das AusgabeFormat zu ode45 passt 






