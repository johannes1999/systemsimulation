% function System_0.m 
%
% Zu untersuchendes System: 
%  - mit Absicht keine Beschreibung und Kommentare! - 
% 
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%
% Datum:    2020-05-25
%
% Änderung: 2.06.2020
%
% siehe auch: test_Systeme.m
%--------------------------------------------------------------------------
function y=System_0(t,f_test,reset)

if nargin>2
    if reset==1
       % Dieses System muss nicht zurückgesetzt werden
    end    
end

n=length(t);   % Anzahl Werte
y=zeros(1,n);  % initialisieren 
if n > 1
    dt=t(2)-t(1);
        for i=2:n
            y(i)=y(i-1)+(f_test(i-1)-y(i-1))/0.15*dt;  
        end
else
    y=0;
end    

