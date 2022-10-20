% Die Function y=Euler_Rueck.(f,t,y0,param_f) 
%
% l�st mit dem Streckenzugverfahren nach Euler mit der R�ckw�rtsmethode
% die DGL erster Ordung y'=f(t,y) mit konstanten Koeffizienten.  Werden 
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
% Autor:	Horst Rumpf
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-03-10
%
% siehe auch: H_UE_02	

function y=Euler_Rueck(f,t,y0,param_f)
n=length(t);        % L�nge des Zeitvektors
dt=t(2)-t(1);       % Schrittweite
y=zeros(size(t));   % Initialisierung des Ausgabevektors

y(1)=y0;            % Anfangsbedingung

if nargin==4        % zus�tzliche Parameter f�r f d.h. f(t,y,param_f)  
    for i=2:n
        y_p=y(i-1)+dt*f(t(i-1),y(i-1),param_f); % Pr�diktor-Wert
        y(i)=y(i-1)+dt*f(t(i),y_p,param_f);     % Korrektor-Wert
    end    
else                % keine zus�tzliche Parameter f�r f d.h. f(t,y)  
    for i=2:n
        y_p=y(i-1)+dt*f(t(i-1),y(i-1)); % Pr�diktor-Wert
        y(i)=y(i-1)+dt*f(t(i),y_p);     % Korrektor-Wert
    end
end







