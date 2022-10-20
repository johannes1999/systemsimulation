% function my_FFT
%
% fft-Berechnung zusammengefasst
% Diese Funktion ist dafür gedacht, sich aus einem Zeitsignal Y(t)das 
% Amplituden-Spektrum in einem sinnvollen Bereich darzustellen. 
%
% Input:    t:  Zeitvektor
%           Y:  Signal
%           option: 1: Spektrum darstellen
%           Titel:  Titel für den plot
%           xlimits: [fmin fmax] Bereich für die Frequenzachse
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    29-05-2019
%
% Änderung: 8.10.2019 Titel für option 1 zugefügt
%
% siehe auch: 
%--------------------------------------------------------------------------
function [f_spektrum, F]=my_FFT(t,Y,option,Titel,xlimits)
  
limits_on_off=1;  
  
  if nargin < 5
      limits_on_off=0;
      if nargin < 4
      Titel='Spectrum';
        if  nargin < 3  
            option= 0;
        end
      end
  end
  
  Ts=t(2)-t(1);       % Abtastzeit                          
  T_max=max(t);       % Signaldauer                                         [s]
  N=length(t);        % Länge des Zeitvektors
  N2=floor(N/2);      % halbe Länge des Zeitvektors
          
  f_spektrum=1/T_max*(0:N2-1);  % Frequenzachse für das Frequenzspektrum    [Hz]
  F_komplett=Ts*abs(fft(Y));    % Spektrum in einem Schritt
  F=F_komplett(1:N2);      
  
if option==1
    semilogx(f_spektrum,20*log10(F)); 
    grid; xlabel('f [Hz]'); ylabel('20*log(F)');  
    set(gca,'ylim',[min(20*log10(F)) max(20*log10(F))]);
    if limits_on_off==1
     set(gca,'xlim',xlimits);
    end 
    title(Titel);
end    