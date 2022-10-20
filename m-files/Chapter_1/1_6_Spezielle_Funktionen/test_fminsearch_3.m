% m-file test_fminsearch_3
%
% Drittes Beispiel für fminsearch
%
% Erklärung 
% Corona-Entwicklung mit logistischen und exponentiellem Wachstum
%
% y(t)=G/(1+(G/y(t=0)-1)*exp(-k*t))
%
%  Mit der function fminsearch können diese Parameter bestimmt werden.
%  Es werden allerdings Startwerte benötigt.
% 
% Input:  Lädt Daten aus dem mat-file CorData.mat
% output: 
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2019 erstellt.
%
% Datum:    1-05-2019
%
% Änderung: 
%
% Benötigte eingene externe functions: keine
%
% siehe auch: test_fminsearch
%
%--------------------------------------------------------------------------
clearvars;
close all;
 % Daten aus mat-file
     data_path='C:\Users\Horst\Documents\01_Vorlesungen\01_Studium Plus\07_System_Simulation\05_Matlab_work\Chapter_1\1_6_Spezielle_Funktionen\';
     mat_File='CorData.mat';
    f_p_mat=[data_path mat_File]; % Pfad mit Dateiname
    %save(f_p_mat, 'CF');
    load(f_p_mat); % CF
    CF_org=CF;
    t_org=0:length(CF_org)-1;
    
    % Annahme
    te=40;
    CFe= 0.095e6;
    CF=[CF_org CFe];
    t=0:length(CF)-1;
    t(end)=te;
   
 %% Best Fit
 %----------------------------
% Logistisches Wachstum 
% y(t)=G/(1+(G/y(t=0)-1)*exp(-k*t))
% Start-Werte
G_0=0.15*10e6;           % Grenze    [-]
k_0=1/20;               %           [1/s]
y_0=CF(1);
po=[G_0 k_0 y_0];       % Startwerte

p=fminsearch(@LogWachstum_fmin_fun,po,[],t(1:40),CF(1:40));

G_est=p(1);             % Ermittelte Parameter
k_est=p(2);                           
y_0_est=p(3);
t_est=linspace(0,60,400);
CF_est1=G_est./(1+(G_est/y_0_est-1)*exp(-k_est*t_est));       % Funktion mit den ermittelten

p=fminsearch(@LogWachstum_fmin_fun,po,[],t(1:45),CF(1:45));

G_est=p(1);             % Ermittelte Parameter
k_est=p(2);                           
y_0_est=p(3);
CF_est2=G_est./(1+(G_est/y_0_est-1)*exp(-k_est*t_est));       % Funktion mit den ermittelten

% Expotentielles Wachstum 
% y(t)=yo+f*exp(k*t)
% Start-Werte
y_0=CF(11);
f=1;                    %          [-]
k_0=1/20;               %          [1/s]

po_e=[y_0 f k_0];       % Startwerte

pe=fminsearch(@ExpWachstum_fmin_fun,po_e,[],t_org(11:35),CF_org(11:35));

yo_est=pe(1);                            % Ermittelte Parameter
ke_est=pe(2);                           
f_est=pe(3);

te_est=linspace(10,length(t_org)+3,200);
CFe_est=yo_est+f_est*exp(ke_est*te_est); % Vorgabe der Funktionsstruktur

figure; 

   plot(t_est,CF_est1,'-. b',t_est,CF_est2,' b',te_est,CFe_est,'g',t,CF,'r*'); 
   grid; xlabel('t [Tage]'); ylabel('CF [-]')
   title('Corona-Entwicklung ')% Parametern
   legend('1te Schätzung am Tag 35', '2te Schätzung am Tag 45', 'expotentiell', 'Original Data')
   set(gca, 'ylim',[0 180000]);
%% function LogWachstum_fmin_fun
%--------------------------------
% Ermittlung der Parameter G, k und yo

function y=LogWachstum_fmin_fun(p,t,CF_ist)
G=p(1);
k=p(2);
yo=p(3);


CF_est=G./(1+(G/yo-1)*exp(-k*t)); % Vorgabe der Funktionsstruktur

y=sum((CF_est-CF_ist).^2);     % Summe der Fehlerquadrate
end

%% function ExpWachstum_fmin_fun
%--------------------------------
% Ermittlung der Parameter G, k und yo

function y=ExpWachstum_fmin_fun(p,t,CF_ist)
y0=p(1);
k=p(2);
f=p(3);


CF_est=y0+f*exp(k*t); % Vorgabe der Funktionsstruktur

y=sum((CF_est-CF_ist).^2);     % Summe der Fehlerquadrate
end

