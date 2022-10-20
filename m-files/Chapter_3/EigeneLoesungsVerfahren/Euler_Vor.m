% Die Function y=Euler_Vor(f,t,y0,param_f) 
%
% löst mit dem Streckenzugverfahren nach Euler mit der Vorwärtsmethode
% die DGL erster Ordung y'=f(t,y) mit konstanten Koeffizienten. Werden 
% noch weitere Parameter param_f für die Funktion f mit übergeben können
% auch DGLs erste Ordnung mit abhängigen Koeffizienten berücksichtigt
% werden.
%
% Eingabe:          f       : Function handle     
%                   t       : Zeitvektor
%                   y0      : Anfangswerte
%                   param_f : Zusätzliche Parameter für die Funktion f 
% 		
%	
% autor:	Horst Rumpf
%
% date:		2017-03-10
%           2018-06-06 ohne feval 
%
% siehe auch: test_DGL1	

function y=Euler_Vor(f,t,y0,param_f)
n=length(t);        % Länge des Zeitvektors
dt=t(2)-t(1);       % Schrittweite
y=zeros(size(t));   % Initialisierung des Ausgabevektors

y(1)=y0;            % Anfangsbedingung

if nargin==4        % zusätzliche Parameter für f d.h. f(t,y,param_f)  
    for i=2:n
        y(i)=y(i-1)+dt*f(t(i-1),y(i-1),param_f);
    end    
else                % keine zusätzliche Parameter für f d.h. f(t,y)  
    for i=2:n
        y(i)=y(i-1)+dt*f(t(i-1),y(i-1));
    end
end







