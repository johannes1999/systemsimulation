% m-file: cell_DistributionExercise.m	
%
% Zellularer Automat 
% =============================================
% !!! DIESE AUFGABE IST NOCH IN BEARBEITUNG !!!
% =============================================
%
% Beispiel-file für Kapitel 9.1 Zelluläre Automaten
%                  
% Autor:	
%           (Siehe auch http://bit.ly/2wu1dUL)

%           Dieser m-File wurde im Rahmen einer Hausübung für die Vorlesung
%           Strukturelle und funktionale Systemsimulation SS 2020 erstellt.
%
% Dieses Programm dient der Untersuchung von Ausgleichsvorgängen mittels eines Zellularen Automaten.
% In der Matrix P wird eine Häufung in den Zellen P(bz:ez,bs:es) gesetzt - der Rest ist null
% Durch verschiedene Strategien wird versucht eine Gleichverteilung herbeizuführen.
% Alle Strategien haben gemeinsam, dass jede Zelle ihre 8 Nachbarn abfragt. die Reihenfolge ist in
% den Indizes-Vektoren ss und zz (Spalte und Zeile) vorgeben 
% Die erste Idee zu dieser Problematik entstand im Juli 2003 und wurde als
% Projekt 2017 als Aufgabe definiert, aber nicht abgeschlossen.
%           
%
% Datum:    2003-07-21
%           2020-08-05
%
% Änderung: komplette Überarbeitung des files cell2 von 21.07.2003. 
%
% siehe auch: 


close all
clearvars

fall=1; % fall=1 Strategie one by one (a,b und c durch % aktivieren
        % fall=2 Strategie fifty-fifty
        % fall=3 Strategie one by one mit endlos-verknüpfter Matrix(a,b und c durch % aktivieren
        % fall=4 Strategie fifty-fifty mit endlos-verknüpfter Matrix
        % fall=5 Strategie one by one typ a) mit endlos-verknüpfter Matrix mit Ingnoranten und Schmarotzern
        % fall=6 Richter Automat Strategie one by one typ a) mit endlos-verknüpfter Matrix
        % fall=7 Auswertung der Strategien
        
% Indizes-Vektoren für die Abfrage der 8 Nachbarn
ss=[-1, 0, 1, 1, 1, 0,-1,-1];     % 1  2  3
zz=[ 1, 1, 1, 0,-1,-1,-1, 0];     % 8  c  4
                                  % 7  6  5
% Matrix-Grösse
Nz=40;     % Anzahl Zeilen
Ns=40;     % Anzahl Spalten

% Füllbereich 
bs=1; es=20;      % Spalten-Bereich von Spalte bs bis Spalte es
bz=1; ez=20;      % Zeilen-Bereich von Zeile bz bis Zeile ez
N_iter=300;           % Durchläufe main-loop
d=zeros(1,N_iter);
P=zeros(Nz,Ns);   % Matrix mit Nullen füllene

Nstart=round(Ns*Nz/((es-bs+1)*(ez-bz+1)));  % Startwert für den vorbesetzten Bereich 
P(bz:ez,bs:es)=Nstart; 

% Fall 1 Strategie one by one
% die verschiedenen Strategien 1a) 1b) und 1c) können durch Auskommentieren der entsprechenden
% Abfrage-Zeile ausgewählt werden
switch fall
    case 1
 
   for i=1:N_iter                  % Anzahl der Iterationen 
          
    d(i)=sum(sum(P.^2))/(Ns*Nz);   % Als Konvergenz-Kriterium wird ein Flächen-Moment benutzt
    
    figure(1);                      % Images für Video abspeichern
    image(64/Nstart*P);
	axis('equal');
	axis('off');
    title(['Konvergenz-Kriterium ' num2str(d(i))]);
    M0(:,i) = getframe;
    
    z_random=randperm(Nz);
    s_random=randperm(Ns);
    for z=z_random                                      % Ein Durchlauf über
        for s=s_random                                  % die Matrix
            k_random=randperm(8);
            for k=k_random                               % Schleife über die 8 Nachbarn
                vz=z+zz(k);                         % Indizes für den Nachbar
                vs=s+ss(k);      
                if ((vs<1)||(vs>Ns)||(vz<1)||(vz>Nz))  % Rand der Matrix abfragen
                    vs=s;                           % Ist der Rand erreicht vergleicht
                    vz=z;                           % die Zelle sich mit sich selbst
                end
                if P(z,s)>P(vz,vs)                 % Strategie 1a): Hat der Nachbar weniger 
                %if ((P(z,s)>P(vz,vs))&((P(z,s)>1)));% Strategie 1b): Hat der Nachbar weniger 
                                                    %                und die Zelle mehr als 1  
               %if P(z,s)>(P(vz,vs)+1);              % Strategie 1c): Nur wenn die Zelle nach 
                                                    %                dem Tausch eins mehr hat 
                   P(z,s)=P(z,s)-1;                 %                gibt die Zelle eins ab
                   P(vz,vs)=P(vz,vs)+1;
                end
            end
        end 
    end
  end
  
    figure(1)
    %R=1;                % Video wiederholen
    %while R ==1
 	movie(M0,1,5)
    close(1)
    %R=input('Video Wiederholen = 1');
    %end
    
    figure(2)
    plot(d)  
    grid
    title('Konvergenz Kriterium d')
    xlabel('Anzahl Durchläufe')
    ylabel('[-]')
    disp('Pause')
    
% Fall 2 Strategie fifity-fifty
    case 2
 
   for i=1:N_iter                                         % Anzahl der Durchläufe 
        i 
    Pmax=max(max(P)); % Als Konvergenz-Kriterium wird die Differenz d zwischen dem maximal- und
    Pmin=min(min(P)); % minimal-Wert in der Matrix genommen
    d(i)=(Pmax-Pmin);
    
    figure(1);              % Images für Video abspeichern
    image(64/Nstart*P);
 	axis('equal');
 	axis('off');
    title(['Delta max-min' num2str(d(i))]);
    M0(:,i) = getframe;
    
    for z=1:Nz                                          % Ein Durchlauf über
        for s=1:Ns                                      % die Matrix
            for k=1:8                                   % Schleife über die 8 Nachbarn
                vz=z+zz(k);                             % Indizes für den Nachbar
                vs=s+ss(k);
                if not(((vs<1)|(vs>Ns)|(vz<1)|(vz>Nz))) % Rand der Matrix abfragen
                   W= (P(z,s)+P(vz,vs))/2;              % Halbe-Halbe machen
                   P(z,s)=W;
                   P(vz,vs)=W;
                end
            end
        end
    end 
  
  end
    
    figure(1)
    R=1;                % Video wiederholen
    while R ==1
 	movie(M0,1,5)
    close(1)
    R=input('Video Wiederholen = 1');
    end
    
    figure(2)
    plot(d)  
    grid
    title('Konvergenz Kriterium d')
    xlabel('Anzahl Durchläufe')
    ylabel('[-]')
    
    case 3      %  one by one mit endlos-verknüpfter Matrix
   for i=1:N_iter     %  Anzahl der Durchläufe 
          
    d(i)=sum(sum(P.^2))/(Ns*Nz);   % Als Konvergenz-Kriterium wird ein Flächen-Moment benutzt
    
    figure(1);                      % Images für Video abspeichern
    image(64/Nstart*P);
	axis('equal');
	axis('off');
    title(['Konvergenz-Kriterium ' num2str(d(i))]);
    M0(:,i) = getframe;
    
    
    for z=1:Nz                                      % Ein Durchlauf über
        for s=1:Ns                                  % die Matrix
            for k=1:8                               % Schleife über die 8 Nachbarn
                vz=z+zz(k);                         % Indizes für den Nachbar
                vs=s+ss(k);      
                if vs<1 
                    vs=Ns;  end                % Matrix endlos verknüpfen
                if vs>Ns 
                    vs=1;  end
                if vz<1 
                    vz=Nz;  end
                if vz>Nz 
                    vz=1;  end
               
                %if P(z,s)>P(vz,vs);                 % Strategie 1a): Hat der Nachbar weniger 
                if ((P(z,s)>P(vz,vs))&&((P(z,s)>1)))% Strategie 1b): Hat der Nachbar weniger 
                                                    %                und die Zelle mehr als 1  
               %if P(z,s)>(P(vz,vs)+1);             % Strategie 1c): Nur wenn die Zelle nach 
                                                    %                dem Tausch eins mehr hat 
                   P(z,s)=P(z,s)-1;                 %                gibt die Zelle eins ab
                   P(vz,vs)=P(vz,vs)+1;
                  
                end
            end
        end 
    end
  end
  
    figure(1)
    R=1;                % Video wiederholen
    while R ==1
 	movie(M0,1,5)
    close(1)
    R=input('Video Wiederholen = 1');
    end
    
    figure(2)
    plot(d)  
    grid
    title('Konvergenz Kriterium d')
    xlabel('Anzahl Durchläufe')
    ylabel('[-]')
    disp('Pause')
    
% Fall 4 Strategie fifity-fifty mit endlos-verknüpfter Matrix
    case 4

   for i=1:N_iter                                         % Anzahl der Durchläufe 
         
    Pmax=max(max(P)); % Als Konvergenz-Kriterium wird die Differenz d zwischen dem maximal- und
    Pmin=min(min(P)); % minimal-Wert in der Matrix genommen
    d(i)=(Pmax-Pmin);
    
    figure(1);              % Images für Video abspeichern
    image(64/Nstart*P);
	axis('equal');
	axis('off');
    title(['Delta max-min' num2str(d(i))]);
    M0(:,i) = getframe;
    
     Pmax=max(max(P));
    Pmin=min(min(P));
    f=64/(Pmax-Pmin);
    figure(2);                      % Images für Video abspeichern
    image(f*(P-Pmin));
	axis('equal');
	axis('off');
    title(['Konvergenz-Kriterium ' num2str(d(i))]);
    M1(:,i) = getframe;
    
    for z=1:Nz                                          % Ein Durchlauf über
        for s=1:Ns                                      % die Matrix
            for k=1:8                                   % Schleife über die 8 Nachbarn
                vz=z+zz(k);                             % Indizes für den Nachbar
                vs=s+ss(k);
                if vs<1 vs=Ns;  end                % Matrix endlos verknüpfen
                if vs>Ns vs=1;  end
                if vz<1 vz=Nz;  end
                if vz>Nz vz=1;  end
                W= (P(z,s)+P(vz,vs))/2;              % Halbe-Halbe machen
                P(z,s)=W;
                P(vz,vs)=W;   
            end
        end
    end 
  
  end
    
    figure(1)
    R=1;                % Video wiederholen
    while R ==1
 	movie(M1,1,5)
    close(1)
    R=input('Video Wiederholen = 1');
    end
    
    figure(2)
    plot(d)  
    grid
    title('Konvergenz Kriterium d')
    xlabel('Anzahl Durchläufe')
    ylabel('[-]')
    
    case 5      %  one by one mit Begrenzung, Schmarotzer und Ignoranten
   
   for ii=1:1               % Vorgabe Prozent Schmarotzer oder Ignoranten, 
       NsI=[];              % wird aber duch Doppelbelegung nicht erreicht.
       NzI=[];              % Der Wert wird nachträglich berechnet. siehe Variable Pr
       B=[];
       P(1:Nz,1:Ns)=0;  % Matrix mit Nullen füllene
       P(bz:ez,bs:es)=Nstart; 
       ii
   Proz_Ignorant=1;
   N_Ignorant=round(Proz_Ignorant/100*Ns*Nz);
   NsI=(round(rnd_vect(N_Ignorant,'uniform',[Ns/2 (Ns-1)/2],[],[])));
   NzI=(round(rnd_vect(N_Ignorant,'uniform',[Nz/2 (Nz-1)/2],[],[])));
  
   Proz_Schmarotzer=ii;
   N_Schmarotzer=round(Proz_Schmarotzer/100*Ns*Nz);
   NsS=(round(rnd_vect(N_Schmarotzer,'uniform',[Ns/2 (Ns-1)/2],[],[])));
   NzS=(round(rnd_vect(N_Schmarotzer,'uniform',[Nz/2 (Nz-1)/2],[],[])));
   
   % Besetzung der Schmarotzer und Ignoranten -Matrix B
   B=zeros(Nz,Ns);
   
   for i=1:N_Ignorant 
       B(NzI(i),NsI(i))=30;
   end
   
   for i=1:N_Schmarotzer
      B(NzS(i),NsS(i))=50;
   end
   
   figure(1)
   image(B);
	 axis('equal');
	 axis('off');
   title('Verteilung Schmarotzer');
  
   for i=1:N_iter                     % Anzahl der Durchläufe 
          
    d(i)=sum(sum(P.^2))/(Ns*Nz);   % Als Konvergenz-Kriterium wird ein Flächen-Moment benutzt
    
    figure(2);                      % Images für Video abspeichern
    image(64/Nstart*P);
	  axis('equal');
	  axis('off');
    M0(:,i) = getframe;
    
   
    for z=1:Nz                                      % Ein Durchlauf über
        for s=1:Ns                                  % die Matrix
          if B(z,s) == 0 
            for k=1:8                               % Schleife über die 8 Nachbarn
                vz=z+zz(k);                         % Indizes für den Nachbar
                vs=s+ss(k);  
                if ((vs<1)||(vs>Ns)||(vz<1)||(vz>Nz))  % Rand der Matrix abfragen
                    vs=s;                           % Ist der Rand erreicht vergleicht
                    vz=z;                           % die Zelle sich mit sich selbst
                end
          
               
                if ((P(z,s)>P(vz,vs)) && not(B(vz,vs) == 30))                 % Strategie 1a): Hat der Nachbar weniger 
                     P(z,s)=P(z,s)-1;                                         %                gibt die Zelle eins ab
                     P(vz,vs)=P(vz,vs)+1;
       
               end  % if Strategie
            end     % k-Schleife Nachbarn testen
          end       % if Schmarotzer   
        end         % z, s-Schleife über Matrix
    end             % -"-
  end               % ml Schleife Wiederholen
  
  % Wieviel Prozent bleiben durch die Schmarotzer und Ignoranten auf Null? Nullsum
  
  Nullsum=0;                    % Anzahl Rest Nullen - die, die nichts abbekommen haben (ohne Nullen von
                                % den Ignoranten und Schmarotzer)
  NullP  =0;                    % Anzahl Rest Nullen - die, die nichts abbekommen haben
  NullB  =0;                    % Anzahl Zellen die nicht durch Scmarotzer oder Ignoranten belegt sind

  for z=1:Nz                    % Auszählen der oben angegebenen Werte                   
        for s=1:Ns 
             if B(z,s)==0       
             NullB=NullB+1;
            end
            if P(z,s)==0
             NullP=NullP+1;
            end
            if ((P(z,s)==0) && (B(z,s)==0))
                 Nullsum=Nullsum+1;
            end
        end
    end
    
  Pr(ii)=1-NullB/(Nz*Ns);          % Prozentualer Anteil Ingnoranten und Schmarotzer
  Ign_Null(ii)=Nullsum*100/NullB;  % Prozentualer Anteil der Rest Nullen - die, die nichts abbekommen haben 
                                   % (ohne Nullen von den Ignoranten und Schmarotzer)    
                                   % Bezogen auf die Ausgangssituation (ohne Nullen von den Ignoranten und Schmarotzer)
end

  figure(2)
   image(64/Nstart*P);
   axis('equal');
   axis('off');
   
  figure(3)
  [Y,I]=sort(Pr);
    plot(100*Y,Ign_Null(I));
    grid
    title(['Rechnung'])
    xlabel('Summe Ingnoranten und Schmarotzer [%]')
    ylabel('Anzahl Nullen[%]')
    
    case 6      % Optimierter Automat one by one mit endlos-verknüpfter Matrix 
   
   Proz_Stoer=2;
   N_Stoer=floor(Proz_Stoer/100*Nz*Ns);
   x=unsort([1:Ns*Nz]);
   z_stoer=fix(x(1:N_Stoer)/Nz)+1;
   s_stoer=mod(x(1:N_Stoer),Nz)+1;
   
   N_Schmarotzer=1;
   N_Ignorant=N_Stoer-N_Schmarotzer;
   
   NsS=s_stoer(1:N_Schmarotzer);
   NzS=z_stoer(1:N_Schmarotzer);
   NsI=s_stoer(N_Schmarotzer+1:N_Stoer);
   NzI=z_stoer(N_Schmarotzer+1:N_Stoer);
   
   
   % Besetzung der Schmarotzer und Ignoranten -Matrix B
   B=zeros(Nz,Ns);
   
   for i=1:N_Ignorant 
       B(NzI(i),NsI(i))=30;
   end
   
   for i=1:N_Schmarotzer
      B(NzS(i),NsS(i))=50;
   end
    figure(1);                      % Images für Video abspeichern
    image(B);
	axis('equal');
	axis('off');
    title('Störung ');
    pause
   for i=1:N_iter     %  Anzahl der Durchläufe 
          
    d(i)=sum(sum(P.^2))/(Ns*Nz);   % Als Konvergenz-Kriterium wird ein Flächen-Moment benutzt
    
    figure(2);                      % Images für Video abspeichern
    image(64/Nstart*P);
	axis('equal');
	axis('off');
    title(['Konvergenz-Kriterium ' num2str(d(i))]);
    M0(:,i) = getframe;
    
    for z=1:Nz                                      % Ein Durchlauf über
        for s=1:Ns                                  % die Matrix
            r_pos=unsort([1 2 3 4 5 6 7 8]);        % Zufallsfolge für den Anfang vom verteilen
            for k=1:8                               % Schleife über die 8 Nachbarn
                vz(k)=z+zz(r_pos(k));                        % Indizes für den Nachbar
                vs(k)=s+ss(r_pos(k));      
                if vs(k)<1 vs(k)=Ns;  end                % Matrix endlos verknüpfen
                if vs(k)>Ns vs(k)=1;  end
                if vz(k)<1 vz(k)=Nz;  end
                if vz(k)>Nz vz(k)=1;  end
                
%                 if vs(k)<1 vs(k)=1;    end;                % Matrix mit Berandung
%                 if vs(k)>Ns vs(k)=Ns;  end;
%                 if vz(k)<1 vz(k)=1;    end;
%                 if vz(k)>Nz vz(k)=Nz;  end;
            end
            % Nach größtem Potentialgefälle sortieren
            for k=1:8
            Pot(k)=P(vz(k),vs(k))-P(z,s);   %Potentialgefälle
            end
            [cc pos]=sort(Pot);             % Reihenfolge der Größe des Pot.-Gefälles
            
            for k=1:8
                vzn(k)=vz(pos(k));          % Zuordnung nach Potentialgefälle
                vsn(k)=vs(pos(k));          % durch die vorherige unsort-function ist der Rest zufällig verteilt
            end
           
            vz=vzn; vs=vsn;
            for k=1:8
                if (P(z,s)>P(vz(k),vs(k)))               % Strategie 1a): Hat der Nachbar weniger 
                %if ((P(z,s)>P(vz,vs))&((P(z,s)>1))); % Strategie 1b): Hat der Nachbar weniger 
                                                      %                und die Zelle mehr als 1  
               %if P(z,s)>(P(vz,vs)+1);               % Strategie 1c): Nur wenn die Zelle nach 
                                                      %                dem Tausch eins mehr hat 
                   P(z,s)=P(z,s)-1;                   %                gibt die Zelle eins ab
                   P(vz(k),vs(k))=P(vz(k),vs(k))+1;           %                gibt die Zelle eins ab
                end
            end
        end 
    end
    
  end
  
%     figure(1)
%     R=1;                % Video wiederholen
%     while R ==1
%  	movie(M0,1,5)
%     close(1)
%     R=input('Video Wiederholen = 1')
%     end
%     
%     figure(2)
%     plot(d)  
%     grid
%     title('Konvergenz Kriterium d')
%     xlabel('Anzahl Durchläufe')
%     ylabel('[-]')
%     disp('Pause')
%     

   
    case 7      
    load obo1a1
    da1=d;
    load obo1b1
    db1=d;
    load obo1c1
    dc1=d;
    load ff1
    df1=d;
    figure(1)
    plot (v_csum(da1),da1,v_csum(db1),db1,v_csum(dc1),dc1,v_csum(df1),df1)
    legend('one by one a)', 'one by one b)', 'one by one c)','fifty-fifty')
    title('Konvergenz verschiedener Stategien Ausgansposition 100x100 Matrix Häufung 25x25 oben links bei begrenzter Matrix')
    xlabel('Anzahl Durchläufe');
    ylabel('Konvergenz d');
    
     load obo1a2
    da2=d;
    load obo1b2
    db2=d;
    
    figure(2)
    plot (v_csum(da1),da1,v_csum(da2),da2)
    legend('one by one a)begrenzt', 'one by one a) nicht begrenzt')
    title('Konvergenz verschiedener Stategien Ausgansposition 100x100 Matrix Häufung 25x25 oben links bei nicht begrenzter Matrix')
    xlabel('Anzahl Durchläufe');
    ylabel('Konvergenz d');
     figure(3)
    plot (v_csum(db1),db1,v_csum(db2),db2)
    legend('one by one b)begrenzt', 'one by one b) nicht begrenzt')
    title('Konvergenz verschiedener Stategien Ausgansposition 100x100 Matrix Häufung 25x25 oben links bei nicht begrenzter Matrix')
    xlabel('Anzahl Durchläufe');
    ylabel('Konvergenz d');
    
    
    case 8
    clear all
    close all
    disp('loading ...')
    load onebyone
    M1=M0;
    clear M0;
    load fiftyfifty
     disp('one by one ENTER')
    pause
    movie(M1,1,5)
    disp('fifty-fifty ENTER')
    pause
    movie(M0,1,5)
     %movie2avi(M0,'fifty_2','QUALITY',100)
     
   case 9  
Nz=41;                  % Anzahl Zeilen
Ns=41;                  % Anzahl Spalten
z_m=round(Nz/2);        % Mitte des Feldes
s_m=round(Ns/2);        % -"-
index_z=[Nz 1:Nz 1];    % Indirekte Adressierung - keine Grenzen
index_s=[Ns 1:Ns 1];
      
VP=zeros(Nz,Ns);        % alle Werte Null
VP_neu=zeros(Nz,Ns);    % Matrix um Werte bei der Zwischenrechnung
                        % zu speichern ohne die vorherigen Werte zu
                        % überschreiben.
                        
N_iter=300;              % Anzahl Iterationen

% Anfangsbedingung
% Die Idee ist in der Mitte eine Anhäuf zu auf (2*N_start+1)x(2*N_start+1)
% Zellen zu haben, sodass bei einer gleichmäßigen Verteilung die jede Zelle
% den Wert 1 hat.
 
N_start=5;                             % Seitenlänge=2*N_start+1 der Random-Anfangswerte
AnfangsWert=Ns*Nz/((2*N_start+1)^2);   % Startwert für den vorbesetzten Bereich 
VP(z_m+(-N_start:N_start),s_m+(-N_start:N_start))=AnfangsWert; 
                       
   figure 
   imagesc(VP);
   colorbar;
   title('Anfangsverteilung')
        figure 
        for i=1:N_iter  
            %figure 
            imagesc(VP);
           % H.CDataMapping= 'direct'; % 'scaled'
            %s=pcolor(flipud(SR));
            %s.LineStyle='none';
            %colormap([1 1 1 ;0 0 1]) 
            colorbar;
            axis('equal')
            axis('off')
             d(i)=sum(sum(VP.^2))/(Ns*Nz);   % Als Konvergenz-Kriterium wird ein Flächen-Moment benutzt
            title(['Verteilunsprozess Iterations: ' num2str(i) ' Summe= ' num2str(sum(VP,'all'))])
            pause(0.01)
            for z=1:Nz        % Zeilen
                for s=1:Ns    % Spalten
                    
                    VP_neu(z,s)=mean(VP(index_z(z+[0 1 2]),index_s(s+[0 1 2])),'all');
                    
                end
            end
           VP=VP_neu;   
        end 
        figure
        plot(d);
end

