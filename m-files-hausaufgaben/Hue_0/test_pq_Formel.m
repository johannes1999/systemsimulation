% m-file: test_p_q_Formel.m
%
% 
%
% Erklärung
%
% Berechnet pq-Formel
% x^2+p*x+q=0
%
% 
% Input:    
% Output:   
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

clearvars

p=2;
q=-5;
radiant=(p/2)^2-q;
if radiant < 0
    disp('Negative Wurzel')
else
    [x1,x2]=pq_fun(p,q);
disp(x1)
disp(x2)
end

function [Null_1, Null_2]=pq_fun(p,q)
    Null_1=-p/2+sqrt((p/2)^2-q);
    Null_2=-p/2-sqrt((p/2)^2-q);
end

