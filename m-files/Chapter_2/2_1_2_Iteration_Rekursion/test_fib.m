% Kapitel  2.1 Iteration und Rekursion 
%
% m-file: test_fib.m 
%
% test_fib.m ruft die Funktionen fibonacci_rec.m und fibonacci_iter.m auf
% um diese zu testen. 
% Weiterhin wird die Fibonacci-Reihe durch eine e-Funktion 	 	
% dargestellt.
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-05-28
%           2020-05-24 Kommentare aufgeräumt
%
% see also:
%------------------------------------------------------------------------

clearvars
close all

N=8;  % N-te Fibonacci Zahl

%% Rekursive Berechnung
%---------------------

fib_rec=fibonacci_rec(N); % Rekursive Berechnung für den N-ten Wert 
                          % der Fibonacci-Reihe
                          
disp(['Rekrusive Berechnung F(' num2str(N) ')= ' num2str(fib_rec)]); 

%% Iterative Berechnung
%---------------------

fib1=fibonacci_iter(N+1); % Berechnet den Vektor bis zur N+1 Fibonacci-Zahl

%% e-Funktion
%-----------

% Berechnung der Parameter für eine e-Funktion aus zwei Punkten
x=[3 N];                            % zwei Punkten
y=[fib1(1+x(1)) fib1(1+x(2))];      % um 1 verschoben

l= 1/(x(1)-x(2))*log(y(1)/y(2));    % Berechnung der Parameter
a=y(2)*exp(-l*x(2));

x1=linspace(1,N,N);     % x-Werte für die Fibonacci-Reihe
x2=linspace(1,N,100);   % x-Werte für die e-Funktion
y2=a*exp(l*x2);         % e-Funktion

figure
plot(x1,fib1(2:end),x2,y2)
grid
legend('Fibonacci', 'e-fkt')
xlabel('N'); ylabel('Fibonacci-Zahl')