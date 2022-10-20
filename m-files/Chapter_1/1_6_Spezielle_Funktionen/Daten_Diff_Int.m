% m-file Daten_Diff_Int.m
%
% Daten aus Excel lesen und schreiben siehe 
% ...\05_Matlab_work\Chapter_1\1_6_Spezielle_Funktionen
% Beispiel-File DataExcel2Matlab.m
%
% Integration und Differenzieren siehe Kapitel 1 und Beispiel-Files:  
% ...\05_Matlab_work\Chapter_2\2_3_Integration\ 
% Beispiel-File: test_Integration.m
%
% Autor:	Horst Rumpf
%
%
% Datum:    7-01-2022
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen

% Daten aus einem Excel-File auslesen
%------------------------------------

% Der PathName muss dem Pfad entsprechen, in dem die Exceldatei liegt!  
PathName = 'C:\Users\Horst\Documents\01_Vorlesungen\01_Studium Plus\07_System_Simulation\05_Matlab_work\Chapter_1\1_6_Spezielle_Funktionen\';
FileNameExcel='ExcelTestFile1.xlsx';
PathFileExcel=[PathName FileNameExcel]; % Pfad und Filename zusammenführen

sheet = 'Blatt_Nr_1'; % Die Blattbezeichnung in dem Excel-file
Range = 'D2:E10002'; % Der Datenbereich, der aus den Excel-Blatt eingelesen werden soll


%ExcelData =xlsread(PathFileExcel,sheet,Range); % 
ExcelData =readcell(PathFileExcel,'sheet',sheet,'range',Range ); % 
t=cell2mat(ExcelData(:,1)); % Erste Spalte sind die Zeitwerte
y=cell2mat(ExcelData(:,2)); % Zweite Spalte sind die Funktionswerte


figure
    plot(1e3*t,y);
    grid
    xlabel('t [ms]')
    ylabel('y')
    title(['Daten aus dem Excelfile ' FileNameExcel]); 
    
% Daten in einem mat-file speichern 
%----------------------------------
FileNameMat='MatTestFile1.mat';
PathFileMat=[PathName FileNameMat]; % Pfad und Filename zusammenführen

save(PathFileMat,'t','y');


clearvars t y;  % Variablen t und y löschen

% Daten aus einem mat-file laden 
%-------------------------------
load(PathFileMat);

% Wenn die Daten konstante Abstände haben:
dt=t(2)-t(1);

% Daten Differenzieren
dy_dt=diff(y)/dt;
% Hinweis: durch die Differenzenbildung ist der Vektor dy_dt um1 kürzer
% als die Vektoren t und y

% Integrieren mit der Rechteckformel
Int_y1=cumsum(y)*dt; % Z.B. Obersumme

% Integration mit der Simpsonformel
% Siehe Kapitel 2 und Beispiel-File ...\05_Matlab_work\Chapter_2\2_3_Integration
%test_integration.m
Int_y2=csimpson(t,y);


figure
subplot(3,1,1)
    plot(t,y);
    grid
    xlabel('t [s]')
    ylabel('y')
    title(['Daten aus dem mat-file ' FileNameMat]); 
 subplot(3,1,2)
    plot(t(1:end-1),dy_dt);
    grid
    xlabel('t [s]')
    ylabel('dy/dt')
    title('Differentiation dy/dt');    
 subplot(3,1,3)
    plot(t,Int_y1,'b',t,Int_y2,'r ');
    grid
    xlabel('t [s]')
    ylabel('I_y')
    title('Integration');    
    legend('Obersumme', 'Simpson')
