% Die Function A=DFT(y) 
%
% Diskrete Fourier-Transformation
%
% Eingabe:          y       : Werte-Vektor
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-16
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------

function A=DFT(y)

N=length(y);        % Länge des Wertevektors
A=zeros(1,N);       % komplexe Werte der DFT

for n=1:N           % Schleife über alle Frequenzen
    for m=1:N       % Schleife über alle Mess-Werte
        A(n)=A(n)+y(m)*exp(-1i*2*pi/N*(n-1)*(m-1));
    end
end    
