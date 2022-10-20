%  m-file: test_polynom.m
%
% Matlab stellt für das Arbeiten mit Polynomen einige hilfreiche functions
% zur Verfügung, die hier vorgestellt werden.
%
%           Dieser m-file wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2019 erstellt.
%
% Datum:    2019-02-25
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars
close all

% 1. Die function polyfit legt durch eine gegebene Punktmenge x, y einen
%    Polynom mit dem grad n. Die Berechnung erfolgt mit den minimalen 
%    Fehlerquadraten.
%    Das Ergebnis sind die Polynom-Koeffizienten in absteigender
%    Reihenfolge.
%   z.B.: y=5*x^4 -3*x^2 +x -15. Polynom-Koeffizienten: p_koef=[5 0 -3 1 -15]

x=[ 1 2 3  4 5  6];     % gegebene Punkte
y=[-6 5 4  1 2  5];
n_poly=3;               % gewählter Grad des Ausgleich-Polynoms

p_koef=polyfit(x,y,n_poly);
disp('Polynom-Koeffizienten des Ausgleichpolynoms');
disp(p_koef);

% 2. Die Berechnung eines Polynoms mit gegebenen Polynom-Koeffizienten
%    erfolgt mit der function polval.

N=400;                  % Anzahl der zu berechnenden Punkte
x1=linspace(0.8,6.5,N);   % x-Werte
y1=polyval(p_koef,x1);  % Berechnung der y-Werte

% 3. Die Nullstellen des Polynoms können mit der function roots berechnet
%   werden.

x_null=roots(p_koef);
disp('Nullstellen');
disp(x_null);

p_2=p_koef(1)*poly(x_null);
disp('Zurückgerechnete Polynomkoeffizienten');
disp(p_2);

% 4. Für das Differenzieren und Integrieren gibt es auch zwei functions:
%    Differenzieren: polyder. Integrieren: polyint

p_diff=polyder(p_koef); % Polynomkoeffizienten des differenzierten Polynoms
p_int=polyint(p_koef);  % Polynomkoeffizienten des integrierten Polynoms

y1_diff=polyval(p_diff,x1);  % Berechnung der Ableitungswerte
y1_int=polyval(p_int,x1);    % Berechnung der Werte der Stammfunktion
                             
% Für den Integralwert mit Grenzen
% z.B. x_o=6 und x_u=1.4504 

x_o=6;      % Obere Integral-Grenze
x_u=1.4504; % Untere Integral-Grenze    
Int=polyval(p_int,x_o)-polyval(p_int,x_u);    

% Darstellung der Fläche
xf=linspace(x_u,x_o,N); % x-Werte
yf=polyval(p_koef,xf);  % Berechnung der y-Werte

figure
subplot(2,2,1)
    plot(x,y,'r *',x1,y1,'b')
    grid; xlabel('x'); ylabel('y'); title('Ausgleichspolynom: y(x)')
    legend('Punkte', 'Ausgleichspolynom')
subplot(2,2,2)
    plot(x1,y1_diff,'b')
    title('Ableitung des Ausgleichpolynoms dy/dx'); grid; xlabel('x'); ylabel('y''(x)')
subplot(2,2,3)
    plot(x1,y1_int,'b')
    title('Stammfunktion des Ausgleichpolynoms'); 
    grid; xlabel('x'); ylabel('F(x)')
subplot(2,2,4)
    fill([xf max(xf)],[yf 0],'b')
    hold
    plot(x1,y1,'r')
    grid
    title(['Integralwert x_u=' num2str(x_u) 'x_o=' num2str(x_o) ' I=' num2str(Int)]); 
    xlabel('x'); ylabel('y(x)')
