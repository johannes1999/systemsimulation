% m-file: test_Grenzen
% 
% Beispiel-files für Kapitel 9.1 Zelluläre Automaten
% Beispiel für die indirekte Adressierung der angrenzenden Zelle
% Siehe Skript Kapitel 9
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation Kapitel 9 SoSe 2020 erstellt.
%
% Datum:    2020-07-30
%
% Änderung: 2020-08-05 Beispiel umschaltbare Grenzen zugefügt
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars
close all

close all
clearvars
Grenze=3;       % 1: mit Grenzen
                % 2: ohne obere und untere Grenze
                % 3: ohne Grenzen
                
                % 4: umschaltbar zwischen den Fällen 1 bis 3
 Fall=3;        %    Fall=1: mit Grenzen       
                %    Fall=2: ohne obere und untere Grenze
                %    Fall=2: ohne Grenzen
%-------------------------------------------------------------

m=5;            % Anzahl Zeilen
n=6;            % Anzahl Spalten
Z=zeros(m,n);   % Zellen

% Zellen durchnummerieren
W=0;            
for i=1:m
    for j=1:n
        W=W+1;
        Z(i,j)=W;
    end
end
disp(Z)

switch Grenze
    case 1 % mit Grenzen
        disp( 'Mit Grenzen')
        for Zeile=2:m-1
            for Spalte=2:n-1
                Alle9Zellen=Z(Zeile+[-1 0 1],Spalte+[-1 0 1]);
                disp(['Zelle(' num2str(Zeile) ',' num2str(Spalte) ')=' num2str(Z(Zeile,Spalte))])
                disp( Alle9Zellen)
            end
        end    
        
    case 2 % ohne obere und untere Grenze
           %-----------------------------
        % Index um die obere und untere Grenze wegzunehmen
        disp( 'Ohne obere und unter Grenze')
        index_z=[m 1:m 1];

        for Zeile=1:m
            for Spalte=2:n-1
                Alle9Zellen=Z(index_z(Zeile+[0 1 2]),Spalte+[-1 0 1]);
                disp(['Zelle(' num2str(Zeile) ',' num2str(Spalte) ')=' num2str(Z(Zeile,Spalte))])
                disp( Alle9Zellen)
            end
        end    
        
    case 3 % ohne Grenzen
           %-------------
        disp( 'Ohne Grenzen')
        % Index um die obere und untere Grenze wegzunehmen
        index_z=[m 1:m 1];
        % Index um die obere und untere Grenze wegzunehmen
        index_s=[n 1:n 1];
        
        for Zeile=1:m
            for Spalte=1:n
                Alle9Zellen=Z(index_z(Zeile+[0 1 2]),index_s(Spalte+[0 1 2]));
                disp(['Zelle(' num2str(Zeile) ',' num2str(Spalte) ')=' num2str(Z(Zeile,Spalte))])
                disp( Alle9Zellen)
            end
        end   
        
    case 4 % Umschaltbar
           %------------
        disp(['Umschaltbar Fall=' num2str(Fall)])
        switch Fall
            case 1 % mit Grenzen
                   %------------
                z=2:m-1;            % Schleifen-Indizes
                s=2:n-1;
                index_z=0:m;        % zugehörige Zellen-Indizes
                index_s=0:n;
                
            case 2  % ohne obere und untere Grenze
                    %-----------------------------
                z=1:m;              % Schleifen-Indizes
                s=2:n-1;        
                index_z=[m 1:m 1];  % zugehörige Zellen-Indizes
                index_s=0:n;
                
            case 3  % ohne Grenzen
                    %-------------
                z=1:m;              % Schleifen-Indizes
                s=1:n;              
                index_z=[m 1:m 1];  % zugehörige Zellen-Indizes
                index_s=[n 1:n 1];     
        end
       
        for Zeile=z
            for Spalte=s
                Alle9Zellen=Z(index_z(Zeile+[0 1 2]),index_s(Spalte+[0 1 2]));
                disp(['Zelle(' num2str(Zeile) ',' num2str(Spalte) ')=' num2str(Z(Zeile,Spalte))])
                disp( Alle9Zellen)
            end
        end   
end % switch Rand
