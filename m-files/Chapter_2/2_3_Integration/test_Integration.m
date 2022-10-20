%  function test_Integration.m 
%
% Beispiele für die numerische Integration
% 
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-03
%
% Änderung: 
%
% siehe auch: simpson, csimpson
%--------------------------------------------------------------------------
clearvars
close all

% Beispielfunktion Sinus
N=400;
f=1/(2*pi); % Frequenz          [Hz]
T=1/f;      % Periodendauer     [s]
w=2*pi*f;   % Kreisfrequenz     [1/s]

t=linspace(0,2*T,N);    % Zeitvektor    [s]
U=sin(w*t);             % Spannung      [V]

% 0: Über Summation
dt=t(2)-t(1);           % Schrittweite
Int_U_sum=cumsum(U)*dt;
figure
plot(t,Int_U_sum)
xlabel('t [s]')
ylabel('Int(U(t))')
% 1: Integral über sin(w*t) von 0 bis 2*T
Int_U_Wert=simpson(t,U);

% 2: Schrittweise Integration über sin(w*t) von 0 bis 2*T
Int_U_Verlauf=csimpson(t,U);

% 3: Berechnung des arithmetischen Gleichrichtwertes
Uarv=ARV(t,U);

% 4: Berechnung des Effektivwertes
Ueff=Eff(t,U);

figure
subplot(2,1,1)
    plot(t,U,'r')
    grid; xlabel('t [s]'); ylabel('U [V]');
    title(['Spannungsverlauf  U_{ARV}=' num2str(Uarv) ' [V]   U_{Eff}=' num2str(Ueff) '[V]']);
subplot(2,1,2)
    plot(t,Int_U_Verlauf,'b')
    grid; xlabel('t [s]'); ylabel('Int(U) [Vs]');
    title(['Integral Wert ' num2str(Int_U_Wert)])
