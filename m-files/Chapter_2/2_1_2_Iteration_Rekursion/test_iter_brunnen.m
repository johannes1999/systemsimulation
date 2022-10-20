% Kapitel  2.1 Iteration 
%
% m-file: Konvergenz_Brunnen.m
%
% Iterative Berechnung der Brunnen-Tiefe
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2018 erstellt.
%
% Datum:    2017-05-28
%           2019-02-15
%
% see also:
%--------------------------------------------------------------------------

clearvars;
close all;
format long e;
g=9.81;
v_schall=300;           % Schallgeschwindigkeit                     [m/s]
t_mess=50;              % Zeit bis man den Stein aufschlagen hört   [s]
                        % Versuche folgende Werte: 1s, 10s, 40s, 47s, 50s

% Tiefe exakt 
s_genau=v_schall/g*(v_schall+g*t_mess-sqrt(v_schall^2+2*g*t_mess*v_schall));

% Erste Schätzung
s0=g/2*t_mess^2;

s(1)=s0;    % Iterationswert speichern

ds_max=0.1; % Minimale Wegänderung zwischen 
            % zwei Iterationsschritten
ds=2*ds_max;% Startwert

N=0;        % Zähler Anzahl Iterationschritte

while ((abs(ds) > ds_max) &&(N <10000))
    N=N+1;
    t_schall=s0/v_schall;
    t=t_mess-t_schall;
    s1=g/2*t^2;
    ds=s0-s1;
    s0=s1;
    s=[s s1];
end

figure
plot(1:length(s),s,'*-',[1 length(s)],s_genau*[1 1])
xlabel('Anzahl Interationsschritte [-]')
ylabel('Tiefe [m]')
legend('Iteration', 'exakt')
grid
