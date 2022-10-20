% Die Function y=Runge_Kutta4(f,t,y0,param_f) 
%
% l�st mit dem Runge-Kutta Verfahren 4ter Ordnung die DGL erster Ordung 
% y'=f(t,y) mit konstanten Koeffizienten.  Werden 
% noch weitere Parameter param_f f�r die Funktion f mit �bergeben k�nnen
% auch DGLs erste Ordnung mit abh�ngigen Koeffizienten ber�cksichtigt
% werden.
%
% Eingabe:          f       : Function handle     
%                   t       : Zeitvektor
%                   y0      : Anfangswerte
%                   param_f : Zus�tzliche Parameter f�r die Funktion f 
% 		
%	
% autor:	Horst Rumpf
%
% date:		2017-03-10
%
% siehe auch: H_UE_02	

function y=Runge_Kutta4(f,t,y0,param_f)

n=length(t);        % L�nge des Zeitvektors
dt=t(2)-t(1);       % Schrittweite
y=zeros(size(t));   % Initialisierung des Ausgabevektors

y(1)=y0;            % Anfangsbedingung

if nargin==4        % zus�tzliche Parameter f�r f d.h. f(t,y,param_f)  
    for i=2:n
        
        l0=f(t(i-1),y(i-1),param_f);
        l1=f(t(i-1)+dt/2,y(i-1)+dt/2*l0,param_f);
        l2=f(t(i-1)+dt/2,y(i-1)+dt/2*l1,param_f);
        l3=f(t(i-1)+dt/2,y(i-1)+dt/2*l2,param_f);
        y(i)=y(i-1)+dt/6*(l0+2*l1+2*l2+l3);     
    end    
else                % keine zus�tzliche Parameter f�r f d.h. f(t,y,param_f)  
    for i=2:n
        
        l0=feval(f,t(i-1),y(i-1));
        l1=feval(f,t(i-1)+dt/2,y(i-1)+dt/2*l0);
        l2=feval(f,t(i-1)+dt/2,y(i-1)+dt/2*l1);
        l3=feval(f,t(i-1)+dt/2,y(i-1)+dt/2*l2);
        
        y(i)=y(i-1)+dt/6*(l0+2*l1+2*l2+l3);  
    end
end







