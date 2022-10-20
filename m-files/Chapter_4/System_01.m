% function System_01.m 
%
% Zu untersuchendes System: 
%  - mit Absicht keine Beschreibung und Kommentare! - 
% 
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%
% Datum:    2020-05-25
%
% Änderung: 2020-06-02
%
% siehe auch: test_Systeme.m
%--------------------------------------------------------------------------
function y=System_01(t,f_test,reset)

if nargin>2
    if reset==1
        y_0=0;
        save('Condition_01','y_0');
    end    
end
load('Condition_01','y_0');

n=length(t);   % Anzahl Werte
if n > 1 
    
    y=zeros(1,n);
    dt=t(2)-t(1);
    y(1)=y_0;

        for i=2:n
            y(i)=y(i-1)+(f_test(i-1)-y(i-1))/0.15*dt;   
        end
else
    y=0;
end    
 
y_0=y(end);
save('Condition_01','y_0');