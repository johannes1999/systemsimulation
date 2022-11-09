% testSysteme.m
%
% Testen von Sytemen
%
% Die Syteme sind als eine function gegeben - als Black Box - und
% durch Testfunktionen soll herausgefunden werden um welche Syteme es
% sich handelt und die Systemparameter sollen abgeschätzt werden.
% 
% Dieser file ist nur ein Vorschlag um die Systeme 1,2,3 zu untersuchen
% fügen Sie selbständig Testfunktionen ein.
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%
% Datum:    2020-05-25
%           2021-11-13 Kommentare ergänzt und aufgeräumt
%
% Änderung: 
%
% siehe auch: System_0, System_01, System_02, System_03
%--------------------------------------------------------------------------
clearvars;
close all;
%cd 'C:\Users\Horst\Documents\01_Vorlesungen\01_Studium Plus\07_System_Simulation\05_Matlab_work\Chapter_4';
%% Testwiederholungen
N_tests=10; % Mit N_tests können Sie vorgeben wie oft eine System-function
            % mit der gleichen Testfunktion aufgerufen werden soll um zu 
            % überprüfen ab das System zeitvariant ist!


%% Testfunktion

% Hier können Sie die Zeitdauer und die zeitliche Auflösung einstellen.

tmax=5;          % max Zeitdauer     [s]
dt=1e-3;         % Schrittweite      [s]
t=0:dt:tmax;     % Zeitvektor        [s]

Testfunktion=3; % Es stehen 3 Testfunktionen zur Verfügung, 
                % deren Paramenter Sie ändern können: 
                % 1: Sprungfunktion
                     A1=1; % Amplitude
                % 2: Sinus-Funktion
                    A2=1; % Amplitude
                    f2=4; % Frequenz    [Hz]
                % 3: Rechteck-Funktion
                    A3=1; % Amplitude
                    f3=.5; % Frequenz    [Hz]

%% Auswahl des zu testenden Systems   
% Unter den 4 Systemen befinden sich auch zeitvariante Systeme. 
% Wenn diese ihr Verhalten verändert haben, dann können Sie mit 
% SystemAuswahl=5 diese wieder auf ihr ursprüngliches Verhalten zurücksetzen!

SystemAuswahl=3;% Es sind 4 Systeme vorgegeben SystemAuswahl=1 bis 4
                % mit SystemAuswahl=5 werden die Systeme zurückgesetzt.

%% ------------------------------------------------------------------------------
% Die folgende Umsetzung ist für die Übung nicht relevant
switch Testfunktion
    case 1
    %Sprungfunktion
        f_test=A1*ones(1,length(t));
    case 2
    % Sinus
    f_test=A2*sin(2*pi*f2*t);
    case 3
    % Rechteckimpusle
     f_test=A3*sign(sin(2*pi*f3*t));
end   

figure; 
for i=1:N_tests
    switch SystemAuswahl
        case 1
            y=System_0(t,f_test); 
            Titel='System 0';
        case 2    
            y=System_01(t,f_test);
            Titel='System 1';
        case 3    
            y=System_02(t,f_test);   
            Titel='System 2';
        case 4
            y=System_03(t,f_test);
            Titel='System 3';
        case 5
            System_0(0,0,1); 
            System_01(0,0,1); 
            System_02(0,0,1); 
            System_03(0,0,1); 
            Titel='!!!Systeme wurden zurückgesetzt!!!';
            t=0;
            f_test=0;
            y=0;
    end     

subplot(2,1,1); 
    plot(t,f_test,'g');
    hold 'on'
    grid 'on'
    xlabel('t [s]')
    ylabel('Testfunktion')
subplot(2,1,2); 
    plot(t,y);
     hold 'on'
    xlabel('t [s]')
    ylabel('Systemantwort')
    title(Titel)
    grid  'on'
    pause(0.1)
end

% figure;
% my_FFT(t,y,1,Titel);