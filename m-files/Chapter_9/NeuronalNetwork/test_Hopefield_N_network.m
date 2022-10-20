% m-file: test_Hopefield_N_network.m	
% 
% Es werden Würfelaugen als Muster in einem Hopefield-Netzwerk gespeichert.
% Siehe Skript.
% Dieses Netzwerk stellt einen Assoziativen Speicher dar. Die zu
% erkennenden Muster werden "abgespeichert" (d.h. die Wichtungsmatrix wird 
% aus dem Mustern berechnet) und nicht "gelernt". Somit handelt es sich um
% ein unsupervised learning. 
% siehe Buch Neuronale Netze; Expert-Verlag; Gerhard Rigoll; 
% Seite 134 bis 155
% Mit den 9 Neuronen kann nur ein Muster (3,3) gespeichert werden. Durch
% Anpassung Schwellwert-Vektors (Bias) können 3 Muster gespeichert und
% erkannt werden. Die Ergebnisse bei der Eingabe von nichtgespeicherten
% Muster wird getestet. 
%
% Autor: Horst Rumpf 	
%       
%        Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%        funktionale Systemsimulation Kapitel 9 SoSe 2022 erstellt.
%
% Datum:    2021-01-11
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars;
clc;
Fall=4;     % 1: 3 und 6 gespeichert Bias b =0-Vektor
            %    Ergebnis: Die 3 wird nicht erkannt
            % 2: 3 und 6 gespeichert Bias b =1-Vektor
            %    Ergebnis:  Die 3 und die 6 werden erkannt, aber 
            %               fehlerhafte Augenzahlen sind nicht plausibel.
            % 3: 3 und 6 gespeichert Bias b optimiert
            %    Ergebnis:  Die 3 wird erkannt und fehlerhafte
            %               Augenzahlen sind plausibel
            % 4: 1,3 und 6 gespeichert Bias b von nach Formel
            %    Ergebnis:  Nur die 1 wird erkannt
            % 5: 1,3 und 6 gespeichert Bias b optimiert
            %    Ergebnis:  Die 1 3 und 6 werden erkannt   
            
% Würfel-Augen Muster
%--------------------
x1=[0 0 0 0 1 0 0 0 0]';    % Würfelzahl 1
x2=[1 0 0 0 0 0 0 0 1]';    % Würfelzahl 2
x3=[1 0 0 0 1 0 0 0 1]';    % Würfelzahl 3
x4=[1 0 1 0 0 0 1 0 1]';    % Würfelzahl 4 
x5=[1 0 1 0 1 0 1 0 1]';    % Würfelzahl 5
x6=[1 0 1 1 0 1 1 0 1]';    % Würfelzahl 6 

% TestMuster
%-----------
xt1=[1 0 0 0 1 0 0 0 0]';  % 3 Punkt unten fehlt
xt2=[0 0 0 0 1 0 0 0 1]';  % 3 Punkt oben fehlt
xt3=[1 0 0 0 0 0 0 0 0]';  % nur Punkt oben
xt4=[1 1 1 1 1 1 1 1 1]';  % alle Punkte

% Test-Matrix
% 10 Test-Muster
%---------------
TM=[x1 x2 x3 x4 x5 x6 xt1 xt2 xt3 xt4];
[Nz, Ns]=size(TM);

% Gewichtungs-Matrix berechnen
%-----------------------------
% Transformation von [0 1] -> [-1 1]
x1T=2*x1-1; % 1 
x3T=2*x3-1; % 3 
x6T=2*x6-1; % 6 

% Fall 1: die 2 und die 6 werden gespeichert
WT1=x3T*x3T' + x6T*x6T';
WT1=WT1.*~eye(9,9);  % Hauptdiagonale auf 0

% Fall 2: die 1, 2 und die 6 werden gespeichert
WT2=x1T*x1T' +x3T*x3T' + x6T*x6T';
WT2=WT2.*~eye(9,9);  % Hauptdiagonale auf 0

switch Fall
%Verschiedene Fälle
%------------------
    case 1 % : 3 und 6 gespeichert b =0-Vektor    
        b=zeros(9,1);
        WT=WT1;
    case 2 % : 3 und 6 gespeichert b =1-Vektor    
        b=ones(9,1);
        WT=WT1;   
    case 3 % : 3 und 6 gespeichert b optimiert 
        b=[1 0 0 0 1 0 0 0 1]';
        WT=WT1;      
    case 4 % : 1,3 und 6 gespeichert b nach Formel 
        b=(x1T+x3T+x6T); % b=[1 -3 -1 -1 1 -1 -1 -3 1]';
        WT=WT2;     
    case 5 % : 1,3 und 6 gespeichert b nach Formel und optimiert
        b=[1 -3 -1 -1 3 -1 -1 -3 1]';
        WT=WT2;          
end

k_max=22;       % Max. Anzahl Iterationen 
for i=1:Ns     % Schleife über alle Test-Muster
    x=TM(:,i); % i-tes Test-Muster
    disp(['INPUT Test-Nr.: ' num2str(i)]) % Testmuster ausgeben
    disp(reshape(x,3,3)');
    k=0;                % Schleifenzähler
    x_n=x+1;            % Vor der Schleife muss x_n ungleich x sein!
    
    while ~isequal(x_n,x) && (k < k_max)    % Iteration
        k=k+1;          % Schleifenzähler erhöhen
        x_n=x;          % neues Muster -> altes Muster
        x=WT*x_n+b;     % neues Muster 
        x=x>0;          % Hard Limiter
        if k > k_max-2  % Anzeigen, wenn evtl. oszilliert
          disp(reshape(x,3,3)')
        end
    end
    disp('OUTPUT')          % Ergebnis ausgeben
    disp(reshape(x,3,3)');
end
