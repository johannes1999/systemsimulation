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
% ?nderung: 2020-06-02
%
% siehe auch: test_Systeme.m
%--------------------------------------------------------------------------
function y=System_02(t,f_test,reset)
if nargin>2
    if reset==1
       % Dieses System muss nicht zur?ckgesetzt werden
    end    
end
k2=0.001;
k1=10;
n=length(t);   % Anzahl Werte

if n > 1
    y1=zeros(1,n);  % initialisieren 
    y2=zeros(1,n);  % initialisieren 
    dt=t(2)-t(1);
        for i=2:n
            y1(i)=y1(i-1)+(-k1*y1(i-1)-y2(i-1)+f_test(i-1))*dt;
            y2(i)=y2(i-1)+1/k2*y1(i-1)*dt;
        end
        y=y2;
        
else
    y=0;
end    