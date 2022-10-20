% function-file: sin_cardinales.m
%
% 
%
% Erklärung
%
% Berechnet dien Sinuns Cardinales: y=sin(x)/x
% 
% 
% Input:    x: Argument der Funktion
%           option: Wenn option=1 ist wird ein Plot erstellt
%
% Output:   Y=sin(x)/x  
%
% Beispiel: xxx
%
% Autor:	xxx
%
% Datum:    xxx
%
% Änderung: xxx
%
% Benötigte eingene externe functions: 
%
% siehe auch: xxx
%
%--------------------------------------------------------------------------         
function y=sin_cardinales(x,option)

 if nargin < 2 % Es wurde keine Option angegeben
     option=0;
 end

y=sin(x)./x;

if option==1
    figure
    plot(x,y,'b');
    grid
    title('Sinus Cardinales')
    xlabel('x')
    ylabel('y=sin(x)/x')
end



