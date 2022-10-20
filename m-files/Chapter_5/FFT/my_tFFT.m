% Function my_tFFT
%
% Wasserfall fft-Berechnung zusammengefasst
% Diese Funktion ist dafür gedacht, sich aus einem Zeitsignal Y(t)das 
% Amplituden-Spektrum in einem sinnvollen Bereich darzustellen. 
% 
% input:	    wavedata        Mess-Daten
%               fs              Abtastfrequenz                                                [Hz]
%               P_over          0: Keine Überlappung 
%                                  D.h. die Zeitbereiche für die Berechnung
%                                  der FFT überlappen sich nicht !!! % 
%                               1: Maximale Überlappung.
%                                  Der kleinste Wert für P_over ist abhängig von
%                               der Abtastfrequenz und der kleinsten zu
%                               berechnenden Frequn fmin:
%                               P_over_min=fmin/(2*fs). Das kommt daher, 
%                               dass für die nächste FFT mind. ein Punkt 
%                               vorgerückt werden muss.
%                    
%               fmin            : ist die kleinste Frequenz in einem FFT-Abschnitt              [Hz]
%               fmin            : ist die kleinste Frequenz in einem FFT-Abschnitt              [Hz]
%				
%
%  output:	    t               : Zeitwerte passend zu den FFT Abschnitten                      [s]	
%               f               : frequency vector (FFT)                                        [Hz]    
%               Ux              : Matrix of  amplitude values over time and frequency
%
% !!! Diese function muss überarbeitet werden. tfft als lokale function 
% einbinden und die Überlapplung in Prozent einführen!!!
%	
% Autor:	Horst Rumpf
%
%          
%
% Datum:    03-06-2019
%
% Änderung: 03-06-2020 Änderungsvorschläge zugefügt!
%
% siehe auch: tfft.m
%--------------------------------------------------------------------------
function [t, f, Ux, f_r, Ux_r ]=my_tFFT(t,Y,P_over,fmin,fmax,option,Titel)

% Vektor in Zeilenvektor ändern
[~, r]=size(Y);
if r >1 
    Y=Y';
end

N=length(Y); % Anzahl Werte

Ts=t(2)-t(1);    % Abtastzeit                          
fs=1/Ts;         % Abtastfrequenz                        [Hz]
                 % höchste Frequenz im Signal ist fs/2
T_max=max(t);    % Signaldauer                           [s]

  if nargin < 7                 % Kein Titel
     Titel= ' ';
      if nargin < 6             % Keine Option kein plot
         option=0;
         if nargin < 5          % Keine Vorgabe für die max. darzustelllende
            fmax=fs/2;          % Frequenz im Signal           [Hz]    
            if nargin < 4  
               fmin=4/T_max;    % Es sollen mindestens in zwei Abschnitten           
               if nargin < 3    % die fft berechnet werden. Dann muss ohne 
                  P_over=0;     % Überlappung (P_over=0) mit 4/Tmax anstatt mit 2/Tmax gerechnet werden
               end
            end
         end 
      end
  end
 
  % fmin Niedrigste Frequenz im Spekturm
  %--------------------------------------
  if fmin<4/T_max               % Vorgegebene min. Frequenz passt 
      fmin=4/T_max;             % nicht zur Meßzeit
  elseif fmin>=2*fs             % Grober Eingabefehler!
      fmin=fs/10;       
  end    
  
  % Benötigte Anzahl Punkte für fmin
  %---------------------------------
  Nfft=floor(2*fs/fmin);    
   
  
  % Überlappung
  %------------
  
  if P_over > 1                 % Eingabefehler 
      P_over=1;                 % für P_over abfangen
  elseif P_over<0            
      P_over=0;    
  end    
  
  % Überlappung in Anzahl Stützstellen
  %-----------------------------------
  dN=1+floor((Nfft-1)*P_over); % dN=1 und Nfft
  
  % Anzahl der zu berechnenden FFT's
  %----------------------------------
  m_ffts= floor((N-Nfft)/dN);   
  
  % Frequenzvektor
  %---------------
  f	= (0:Nfft/2-1)*fs/Nfft;        % Frequenzwerte


  
t	=[];
Ux	=[];
N0	= 1;    % Startposition für die FFTs

for	m=1:m_ffts
	x	= Y(N0:N0+Nfft-1)';         % Signal-Ausschnitt
	x	= x-mean(x);				% skip DC
   	t	= [t N0/fs];                % Zeitvektor
	Uxt	= Ts*abs(fft(x));           % Spektrum des m-ten Signal-Ausschnittes
	Ux 	= [Ux ; Uxt(1:Nfft/2)];     
   
   	N0	= N0+dN;                    % Nächster Startwert
end
  
  %[t, f, Ux]=tfft(Y,fs,P_over,fmin);
  
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  


NN=floor(1/log(2)*log(2*fs/fmin)); % Um die kleinste Frequenz fmin  mit zwei Abtastwerten darzustellen
                                   % benötigte man 2*samplingrate/fmin Werte.  
Nfft	=floor(2^NN);              % Die FFT ist aus 2^NN Werte optimiert deswegen Nfft=2^NN

%W	= ((blackman(Nfft)').^2);
W=      Nfft.^2;% Ohne blackman!
                                           
dN	= floor(P_over*Nfft);          % Anzahl der Werte für die Zeit-Abschnitte in denen das Spektrum dargestellt wird
if dN<1
    dN=1;
end    

M	= floor((N-Nfft)/dN);          % Anzahl der zu berechnenden FFT's
f	= (0:Nfft/2-1)*fs/Nfft;        % Frequenzwerte

t	=[];
Ux	=[];
N0	= 1;

for	m=1:M
	x	= Y(N0:N0+Nfft-1)';
	x	= x-mean(x);				% skip DC
   	t	= [t N0/fs];
   
	Uxt	= 2*abs(fft(x.*W))/Nfft;
	Ux 	= [Ux ; Uxt(1:Nfft/2)];
   
   	N0	= N0+dN;      
end
%%%%%%%%%%%%%%%%%%%%%%%
  

  if fmax > max(f)
      fmax=max(f);
  end    
     
   [~, Nf]=min(abs(f-fmax));
   f_r=f(1:Nf);
   Ux_r=Ux(:,1:Nf);
  
if option==1
        surf(f_r,t,20*log(Ux_r));
        view([90 90]);
        shading flat ; % alternativ shading interp
        colormap(jet); % 
        set(gca,'xscale','lin','yscale','lin','ylim',[min(t) max(t)],'xlim',[min(f_r) max(f_r)]);
         xlabel('f  [Hz]');   ylabel('t [s]'); grid;
        title(Titel ) ;% ' Sum:'  num2str(sum(sum(Ux_r)))]
end    