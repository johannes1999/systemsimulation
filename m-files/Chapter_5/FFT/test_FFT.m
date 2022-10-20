%% m-file test_FFT
%
% Beispiele für die Nutzung der FFT und für die eigene DFT (diskrete
% Fourier Transformation)
%
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-16
%
% Änderung: 2020-06-03 fall=2 
%           2021-11-21 fall=6 zugefügt und if durch switch ersetzt
%                      Daten aus Excel-File laden entfernt.      
%
% siehe auch: DFT.m
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen

fall=5;  % 1: Rechenzeit Vergleich eigene DFT und FFT
         % 2: FFT von verschiedenen Funktionen 
         % 3: Zeitspektrum der linearen Sweep-Funktion
         % 4: Zweites Beispiel Zeitspektrum Audio Signal
         % 5: Beispiel mit Messdaten. Schwingungen Biegebalken
         % 6: Beispiel nichtlinearer Dämpfer Hausübung 2
         
% Verschiedene Testfunktionen
%----------------------------
fs=44100;           % Abtastfrequenz                        [Hz]
                    % höchste Frequenz im Signal ist fs/2
Ts=1/fs;            % Abtastzeit                            [s]
T=0.2;              % Signaldauer                           [s]
fmin=1/T;           % kleinste Frequenz im Signal           [Hz]
t=0:Ts:T;           % Zeitvektor                            [s]
N=length(t);        % Länge des Zeitvektors
N2=floor(N/2);      % halbe Länge des Zeitvektors
f=100;              % Frequenz                              [Hz]
w1=2*pi*f;          % Kreisfrequenzen                       [1/s]

y1=sin(w1*t)+2*sin(2*w1*t)+3*sin(5*w1*t);   % Addition von Sin-Schwingungen
y2= sin(10*w1*t).*sin(w1*t);                % Amplitudenmodulation
y3=sin(t.*w1+0.3*cos(5*w1*t));              % Phasenmodulation
y4=Puls_fkt(t,0,T/10,1);
% Power Density Mode
Dfr	    = [100,200,400,8000,10000];
DPSD	= [ 0.01,0.025,0.025,0.0005,0.0005];
[t_psd,A_psd] = Psd_rnd(Dfr,DPSD,400,N,T);
y5=A_psd';

switch fall
        
    case 1
    %% 1: Rechenzeit Vergleich eigene DFT und FFT
    %-------------------------------------------
      tic;
      A_dft=DFT(y1);         % Diskrete Fourier Transformierte (komplex)
      t_dft=toc;             % Rechenzeit 
      F1=Ts*abs(A_dft);      % Betragsbildung und Multiplikation mit T/N
      f_spektrum=1/T*(1:N);  % Frequenzachse für das Frequenzspektrum    [Hz]
      tic;
      A_fft=fft(y1);         % Fast Fourier Transformierte (komplex)
      t_fft=toc;             % Rechenzeit 
      F_fft=Ts*abs(A_fft);   % Betragsbildung und Multiplikation mit T/N
      
      figure 
      subplot(2,2,1)
        plot(t,y1);
        grid; xlabel('t [s]'); ylabel('y_1')
      subplot(2,2,2)
        semilogx(f_spektrum(1:N2),F1(1:N2));
        grid; xlabel('f [Hz]'); ylabel('F_{DFT}');
        title(['Rechenzeit DFT t= ' num2str(t_dft) ' s'])
     subplot(2,2,3)
        plot(t,y1);
        grid; xlabel('t [s]'); ylabel('y_1')
      subplot(2,2,4)
        semilogx(f_spektrum(1:N2),F_fft(1:N2));
        grid; xlabel('f [Hz]'); ylabel('F_{FFT}');
        title(['Rechenzeit FFT t= ' num2str(t_fft) ' s']) 

    case 2
    %% FFT von verschiedenen Funktionen 
    
     f_spektrum=1/T*(1:N);  % Frequenzachse für das Frequenzspektrum    [Hz]
     F1=Ts*abs(fft(y1));    % Spektrum in einem Schritt
     F2=Ts*abs(fft(y2));
     F3=Ts*abs(fft(y3));
     F4=Ts*abs(fft(y4));
     F5=Ts*abs(fft(y5));
     
     figure; 
     subplot(3,2,1)
       plot(t,y1,'r'); 
       grid; xlabel('t [s]'); ylabel('y_1')
     subplot(3,2,2)
       semilogx(f_spektrum(1:N2),F1(1:N2)); 
       grid; xlabel('f [Hz]'); ylabel('F_1');
     subplot(3,2,3)
       plot(t,y2,'r'); 
       grid; xlabel('t [s]'); ylabel('y_2')
     subplot(3,2,4)
       semilogx(f_spektrum(1:N2),F2(1:N2)); 
       grid; xlabel('f [Hz]'); ylabel('F_2');
     subplot(3,2,5)
       plot(t,y3,'r'); 
       grid; xlabel('t [s]'); ylabel('y_3')
     subplot(3,2,6)
       semilogx(f_spektrum(1:N2),F3(1:N2)); 
       grid; xlabel('f [Hz]'); ylabel('F_3');
     
    figure; 
     subplot(2,2,1)
       plot(t,y4,'r'); 
       grid; xlabel('t [s]'); ylabel('y_4')
     subplot(2,2,2)
       semilogx(f_spektrum(1:N2),F4(1:N2)); 
       grid; xlabel('f [Hz]'); ylabel('F_4');
     subplot(2,2,3)
       plot(t,y5,'r'); 
       grid; xlabel('t [s]'); ylabel('y_5')
     subplot(2,2,4)
       semilogx(f_spektrum(1:N2),F5(1:N2)); 
       hold
       semilogx(Dfr,4*DPSD); 
       grid; xlabel('f [Hz]'); ylabel('F_5');
     
     
    case 3
    %% Zeitspektrum der linearen Sweep-Funktion
    
    f0=100;     % kleinste Frequenz     [Hz]
    f1=1000;    % größte Frequenz       [Hz]
    [y_sweep,f_sweep] = lin_sweep(t,f0,f1,min(t),max(t));
    
     % Zeitspektrum
     P_over=0.01;                                           % Überlappung bei P_over=1 ist die Überlappung =0
     [tspektrum,fspektrum,Ux]=tfft(y_sweep,fs,P_over,f0);   % Zeitspektrum 
    
    figure(1)
    subplot(2,1,1)
      plot(t,y_sweep);
      grid; xlabel('t [s]'); ylabel('y_{Sweep}')
    subplot(2,1,2)
      surf(fspektrum,tspektrum,Ux);
      view([90 90]);
      shading interp;colormap(jet(255)); 
      set(gca,'xscale','lin','yscale','lin','xlim',[f0 f1],...
          'ylim',[min(tspektrum) max(tspektrum)]);
      xlabel('f_{spektrum}  [Hz]');   ylabel('t [s]');
      title('Time FFT')
            
    case 4
    %% Zweites Beispiel Zeitspektrum Audio Signal
    %--------------------------------------------
    
       load handel; %   Fs: sample frequency [Hz] 
                    %   y : time values
      
        sound(y,Fs);   % Soundwiedergabe
        fmin=10;       % Kleinste Frequenz,die bei der FFT berechnet werden soll
        fmax=Fs/2;
        P_over=0.5;     % Überlappung bei P_over=1 ist die Überlappung =0
        
        N=length(y);
        t=linspace(0,N/Fs,N);
      
        [t1,f,Ux]=tfft(y,Fs,P_over,fmin);               % Zeitspektrum 
        U=log(Ux);
        U(U<6.5)=6.5;
        figure
            subplot(2,1,1)
            plot(t,y);
            xlabel('t [s]')
            ylabel('y_{Audio} [-]')
            grid;
        subplot(2,1,2)
            surf(f,t1,U);
            view([90 90]);
            set(gca,'xscale','lin','yscale','lin','ylim',[min(t1) max(t1)],'xlim',[min(f) max(f)]);
            shading interp; colormap(jet(255)); 
            xlabel('f  [Hz]');   ylabel('t [s]'); 
            title('Time FFT')
            
    case 5   
    %% Beispiel mit Messdaten
    
     data_path='C:\Users\Horst\Documents\01_Vorlesungen\01_Studium Plus\07_System_Simulation\05_Matlab_work\Chapter_5\FFT\';
     mat_File='Biegebalken_Daten.mat';
     f_p_mat=[data_path mat_File]; % Pfad mit Dateiname
     load(f_p_mat,'Ts1','s1','Ts2','s2');
   
     
     %% Erster Datensatz auswerten
     %----------------------------
     
     N1=length(s1);             % Anzahl Messwerte
     N1_2=floor(N1/2);          % halbe Länge des Zeitvektors
     
     t1=0:Ts1:(N1-1)*Ts1;       % Zeitvektor    [s]
     T1=max(t1);                % Signaldauer   [s]
     f1_spektrum=1/T1*(1:N1);   % Frequenzachse für das Frequenzspektrum    [Hz]
     F1=Ts1*abs(fft(s1));       % Spektrum 
     
     figure; 
     subplot(2,1,1)
       plot(t1,s1,'b'); 
       grid; xlabel('t [s]'); ylabel('s_1 [mm]')
       title('Biegebalken 1')
     subplot(2,1,2)
       semilogx(f1_spektrum(1:N1_2),F1(1:N1_2)); 
       grid; xlabel('f [Hz]'); ylabel('F_1 [mm/Hz²]');
       
    %% Zweiter Datensatz auswerten
    %-----------------------------
     
     N2=length(s2);             % Anzahl Messwerte
     N2_2=floor(N2/2);          % halbe Länge des Zeitvektors
     
     t2=0:Ts2:(N2-1)*Ts2;       % Zeitvektor    [s]
     T2=max(t2);                % Signaldauer   [s]
     f2_spektrum=1/T2*(1:N2);   % Frequenzachse für das Frequenzspektrum    [Hz]
     F2=Ts2*abs(fft(s2));       % Spektrum 
     
     figure; 
     subplot(2,1,1)
       plot(t2,s2,'b'); 
       grid; xlabel('t [s]'); ylabel('s_2 [mm]')
       title('Biegebalken 2')
     subplot(2,1,2)
       semilogx(f2_spektrum(1:N2_2),F2(1:N2_2)); 
       grid; xlabel('f [Hz]'); ylabel('F_2 [mm/Hz²]');
    %% Wegschneiden der oberen Frequenzen im zweiten Datensatz
    
    f_cut=20;   % ab f_cut[Hz] werden die Frequenzen weggeschnitten 
                % das Spektrum ist in diesem Bereich 0
    
    % N_f_cut ist  zugehöriger Position
    [Wert, N_f_cut]=min(abs(f2_spektrum-f_cut)); 
    
     FFT_2=fft(s2);                     % FFT zweites Signal
     figure; plot(abs(FFT_2))
     FFT_2(N_f_cut:N2-(N_f_cut-2))=0;   % Symmetrische Wegschneiden
     figure; plot(abs(FFT_2))
     s2_cut=ifft(FFT_2);                % inverse FFT = Zeitsignal 
     F2_cut=Ts2*abs(fft(s2_cut));       % Spektrum ohne die hohen Frequenzen
     
     figure; 
     subplot(2,1,1)
       plot(t2,s2,'b',t2,s2_cut,'r'); 
       grid; xlabel('t [s]'); ylabel('s_2 [mm]')
       title('Biegebalken 2 "gefiltert" ')
      subplot(2,1,2)
       semilogx(f2_spektrum(1:N2_2),F2(1:N2_2),'b',...
                f2_spektrum(1:N2_2),F2_cut(1:N2_2),'r'); 
       grid; xlabel('f [Hz]'); ylabel('F_2 [mm/Hz²]');  
 case 6
    %% Beispiel nichtlinearer Dämpfer Hausübung 2
    %--------------------------------------------
       data_path='C:\Users\Horst\Documents\01_Vorlesungen\01_Studium Plus\07_System_Simulation\05_Matlab_work\Chapter_5\FFT\';
       mat_File='NichtlinearerDaempfer_Daten.mat';
       f_p_mat=[data_path mat_File]; % Pfad mit Dateiname
       load(f_p_mat,'t', 'v');
                    %   t: Zeit-Vektor                          [t] 
                    %   v: Geschwindigkeit für 4 Dämpfungsraten [m/s]
       for i=1:4
           figure
           subplot(2,1,1)
            plot(t,v(i,:),'b')
            grid
            title(['Dämpfungsrate ' num2str(i)])
            xlabel('t [s]')
            ylabel('v [m/s]')
           subplot(2,1,2)
            my_FFT(t,v(i,:),1,'')
       end
end