% m-file DataExcel2Matlab
%
% Beispiel zum Datenaustausch mit Excel. 
% 
% Unter help xlsread, xlswrite, save und load findet man viele
% weiter Beispiele und Möglichkeiten Daten auszutauschen.
%
% Dieser m-File beinhaltet 
%                          1. Daten aus einem Excel-File lesen
%                          2. Diese Daten als mat-file speichern
%                          3. Daten aus dem mat-file auslesen
%                          4. Daten in einen Exce-File schreiben
%
% Wenn Daten nur einmalig aus einem Excel-File zu lesen sind ist es
% sinnvoll diese Daten als mat-file zu speichern und dann immer diesen
% file zu nutzen, weil der Datenzugriff wesentlich schneller erfolgt und
% die Daten schon den richtigen Variablen-Namen zugeordnet sind.
%                  
% Damit das Beispiel funktioniert muss der Pfad-Name PathName den Pfad 
% enthalten in dem der File ExcelTestFile.xlsx liegt!!!
% Wenn von Matlab aus Daten in einen Excel-File geschrieben werden sollen
% muss der Excel-File geschlossen sein!!!
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2018 erstellt.
%
% Datum:    2018-07-25
%
% Änderung: 2021-11-26 xlsread gegen readcell ausgetauscht
%                      xlswrite gegen writematrix ausgetauscht
%                      Excel-File ExcelTestFile.xlsx angelegt
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen

% Daten aus einem Excel-File auslesen
%------------------------------------

% Der PathName muss dem Pfad entsprechen, in dem die Exceldatei liegt!  
PathName = 'C:\Users\Horst\Documents\01_Vorlesungen\01_Studium Plus\07_System_Simulation\05_Matlab_work\Chapter_1\1_6_Spezielle_Funktionen\';
FileNameExcel='ExcelTestFile.xlsx';
PathFileExcel=[PathName FileNameExcel]; % Pfad und Filename zusammenführen

sheet = 'Blatt_Nr_1'; % Die Blattbezeichnung in dem Excel-file
Range = 'D4:E600'; % Der Datenbereich, der aus den Excel-Blatt eingelesen werden soll


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
FileNameMat='MatTestFile.mat';
PathFileMat=[PathName FileNameMat]; % Pfad und Filename zusammenführen

save(PathFileMat,'t','y');


clearvars t y;  % Variablen t und y löschen

% Daten aus einem mat-file laden 
%-------------------------------
load(PathFileMat);

figure
    plot(1e3*t,y);
    grid
    xlabel('t [ms]')
    ylabel('y')
    title(['Daten aus dem mat-file ' FileNameMat]); 
    
y2=3*y; % Originalwerte modifiziert

% Daten nach Excel schreiben
%---------------------------

% Hinweis: der Excel-File muss geschlossen sein damit Matlab Daten
%          schreiben kann.
RangeNew = 'F4'; % obere linke Ecke des Datenbereichs
writematrix([t, y2],PathFileExcel,'sheet',sheet,'range',RangeNew);%  xlswrite
