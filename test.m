clearvars
clc

disp('Löse das Lineare gleichungssystem A*x=b')
%Kommentar
A =[ 1     1    -1
     2     1     1
     1     0    -3];
b = [

     0
     1
    -1];

x=A\b;

x


periodes = 4; % Anzahl der Perioden
N = 50; % Punkte pro Periode
N= N*periodes;
t = linspace(0,periodes*2*pi, N);
y=sin(t);
figure
plot(t,y)
grid