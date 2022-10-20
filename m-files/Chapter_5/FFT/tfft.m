 function [t, f, Ux]=tfft(wavedata,fs,P_over,fmin)
%
%  m-file:	tfft.m	
%
%  description: Time-Spectrum
%              
%
%               Using Blackman-Filter from Signalprocessing Toolbox
%               
%               
%  input:	    wavedata        Mess-Daten
%               fs              Abtastfrequenz                                                [Hz]
%               P_over          Wenn P_over=1 ist die Überlappung gleich Null
%                               D.h. die Zeitbereiche für die Berechnung
%                               der FFT überlappen sich nicht !!! Der
%                               kleinste Wert für P_over ist abhängig von
%                               der Abtastfrequenz und der kleinsten zu
%                               berechnenden Frequn fmin:
%                               P_over_min=fmin/(2*fs). Das kommt daher, 
%                               dass für die nächste FFT mind. ein Punkt 
%                               vorgerückt werden muss.
%                    
%               fmin            : ist die kleinste Frequenz in einem FFT-Abschnitt              [Hz]
%				
%
%  output:	    t               : Zeitwerte passend zu den FFT Abschnitten                      [s]	
%               f               : frequency vector (FFT)                                        [Hz]    
%               Ux              : Matrix of  amplitude values over time and frequency
%
%
%  author: Markus Nein, Horst Rumpf
%  version:	0.0.1 (MATLAB 4.0)
%  date:	
%       2000-09-06 comments changed from German to English
%       2004-01-22 NN changed to fmin 
%       2019-11-13 Kommentare geändert und einige Fehleingabemöglichkeiten abgefangen
%
%  see: my_tFFT (fängt Fehleingaben ab und beinhaltet optionen für die
%       Darstellung



% change to colum vector
[c, r]=size(wavedata);
if r >1 
    wavedata=wavedata';
end
N	= length(wavedata); % Anzahl Werte

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
	x	= wavedata(N0:N0+Nfft-1)';
	x	= x-mean(x);				% skip DC
   	t	= [t N0/fs];
   
	Uxt	= 2*abs(fft(x.*W))/Nfft;
	Ux 	= [Ux ; Uxt(1:Nfft/2)];
   
   	N0	= N0+dN;      
end
