 function [t, t_rmsxy, t_peak, t_rms_peak]=t_rms(vv,sample_frequency,N,P)
%
%  M-file:	t_rms.m	
%
%  description: Time-RMS
%               Calculation of rms values for time segments with overlapping
%               
%               
%               
%  input:	    vv              :   vector with data
%               sample_frequency:   samplingrate [Hz]   
%               N               :   Number of time segments
%               P               :   overlap (0..0.8)
%				
%
%  output:	    t               : Vector with values of middle point of time segments [s]	
%               Nbins           : Number of bins for histogram    
%               t_rmsxy         : Histograms of time segments 
%               t_peak          : Max value of time segments
%               t_rms_peak      : quotient of  peak to rms values  
%
%  example:     
%
%
%
%  copyright:	Philips GmbH, Automotive Playback Modules, (c) 2006
%  author:	    APM-DP; Horst Rumpf
%  version:	    (MATLAB 6.0)
%  date:	    15.02.2006
%	
%

% Umwandlung in Spaltenvektor
[c r]=size(vv);
if r >1 
    vv=vv';
end

if P >0.9 
    P=0.9;
end

dt=1/sample_frequency;          % sampling time

NN      =length(vv);            % Number of values
Nslot   =floor(NN/N);           % Number of values per time segment
Ncalc	=floor(Nslot*(1+P));    % Number of values for the calculation with overlapping

for i=1:N
    Nstart  =1+(i-1)*Nslot;     % start point of the segment
    Nend    =Nstart+Ncalc;      % end point of the segment
    if Nend > NN
        Nend=NN;
    end
  
    t_rmsxy(i)   =rms(vv(Nstart:Nend),dt);      % calculation of the rms value of the segment 
    t_peak(i)    =max(abs(vv(Nstart:Nend)));    % calculation of the max value of the segment 
    t_rms_peak(i)=t_peak(i)/t_rmsxy(i) ;        % calculation of the qutient of peak to rms of the segment 
end

t=dt*floor(linspace(floor(Nslot/2),NN-floor(Nslot/2),N));% time position number of the segments
