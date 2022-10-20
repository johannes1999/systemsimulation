% Die Function y=Euler_Vor(f,t,y0,param_f) 
%
% l�st mit dem Streckenzugverfahren nach Euler mit der Vorw�rtsmethode
% die DGL erster Ordung y'=f(t,y) mit konstanten Koeffizienten. Werden 
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
%           2018-06-06 ohne feval 
%
% siehe auch: test_DGL1	

function y=Euler_Vor(f,t,y0,param_f)
n=length(t);        % L�nge des Zeitvektors
dt=t(2)-t(1);       % Schrittweite
y=zeros(size(t));   % Initialisierung des Ausgabevektors

y(1)=y0;            % Anfangsbedingung

if nargin==4        % zus�tzliche Parameter f�r f d.h. f(t,y,param_f)  
    for i=2:n
        y(i)=y(i-1)+dt*f(t(i-1),y(i-1),param_f);
    end    
else                % keine zus�tzliche Parameter f�r f d.h. f(t,y)  
    for i=2:n
        y(i)=y(i-1)+dt*f(t(i-1),y(i-1));
    end
end







