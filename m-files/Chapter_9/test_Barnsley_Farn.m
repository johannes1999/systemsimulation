% m-file: test_Barnsley_Farn
% 
% Beispiel-files für Kapitel x.x fraktale Struktur
% Allgemeines Beispiel
%
% Siehe Skript Kapitel x
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation Kapitel 9 SoSe 2020 erstellt.
%
% Datum:    2021-02-16
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars
close all

close all
clearvars
N=100000;
xy=zeros(2,N);

A(:,:,1)=[ 0.00     0.00        % p=1%
           0.00     0.16];
       
A(:,:,2)=[ 0.85     0.04        % p=86%
          -0.04     0.85];
      
A(:,:,3)=[ 0.20    -0.26        % p=7%
           0.23     0.22];
       
A(:,:,4)=[-0.15     0.18        % p=7%
           0.26     0.24];
       
% p[%] 1    86   7    7        
b=    [0    0    0    0
       0.00 1.60 1.60 0.44];    

for i=2:N
    k=select;
    xy(:,i)=A(:,:,k)*xy(:,i-1)+b(:,k);
end
figure
plot(xy(1,:),xy(2,:),'.g')
axis('off')
%-------------------------------------------------------------

function  Nr=select
% Verteilungsfunktion
% Wahrscheinlichkeiten für den Index Nr.
% p : 1 | 86 | 7 | 7
% Nr: 1 | 2  | 3 | 4

N=100*rand;

if N <=1
    Nr=1;
elseif N <= 87
    Nr=2;
elseif N <= 93
   Nr=3;
else
  Nr=4;
end
    
end

        
