% m-file: cell_ParityRule.m	
% 
% Beispiel-file für Kapitel 9.1 Zelluläre Automaten
% 
% Zellulärer Automat mit Parity-Rule
% 
% Nachbarschaft	:  von Neumann
% Zustandsmenge	: Q={0,1}
% Regel 		: Deterministisch
%                 Ist die Summe der Neumann Nachbarn gerade dann stirbt die Zelle(0), 
%                 ansonsten lebt die Zelle(1) im nächsten Zyklus.
% Berandung		: mit Grenzen
% Anfangswerte  : ein Plus-Zeichen in der Mitte
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation Kapitel 9 SoSe 2020 erstellt.
%
% Datum:    2020-07-31
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
clearvars
close all

% Parity-Rule 
%============
        
Nz=41;     % Anzahl Zeilen
Ns=41;     % Anzahl Spalten
N_iter=13; % Anzahl Iterationen
        
PR=zeros(Nz,Ns);        % alle Zellen auf Null setzen
PR_neu=zeros(Nz,Ns);    % Matrix um Werte bei der Zwischenrechnung
                        % zu speichern ohne die vorherigen Werte zu
                        % überschreiben.
% Anfangswerte
% In die Mitte ein Pulszeichen setzen
z_m=round(Nz/2);
s_m=round(Ns/2);
PR(z_m+[-1 0 1],s_m)=1; 
PR(z_m,s_m+[-1 0 1])=1; 
       
for i=1:N_iter  
    figure 
      s=pcolor(flipud(PR));
      s.LineStyle='none';
      colormap([1 1 1 ;0 0 1]) 
      axis('equal')
      axis('off')
      title(['Parity-Rule Iterations: ' num2str(i)])
      pause(0.01)
            
    for z=2:Nz-2        % Zeilen
        for s=2:Ns-2    % Spalten
            Nachbarn=[PR(z,s+[-1 1]) PR(z+[-1 1],s)'];  % Neumann Nachbarn als Vektor
            SummeNachbarn=sum(Nachbarn, 'all');         % Summe aller Nachbarn
                    
            % oder in einem Schritt
            % SummeNachbarn=sum([PR(z,s+[-1 1]) PR(z+[-1 1],s)'], 'all');
            PR_neu(z,s)=mod(SummeNachbarn,2); % Gerade=0 Ungerade=1         
        end
    end
    PR=PR_neu;   
end
        