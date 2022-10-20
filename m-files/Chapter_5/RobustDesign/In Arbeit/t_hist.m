 function [t, x_bins, t_Histxy, t_Mean, t_Std]=t_Hist(vv,sample_frequency,N,P)
%
%  M-file:	t_Hist.m	
%
%  description: Time-Histogramm
%
%               Calculation of histograms for time segments with overlapping
%               The meaning of time in this case is only the interpretation 
%               of the data in the vector as a chronologic sequence. If ist not a 
%               time interpretation behind the valuses sample_frequency should be 1.
%               
%  input:	    vv:             vector with data
%               
%               N :             Number of time segments
%               P :             overlap (0..0.8)
%				
%
%  output:	    t               : Vector with middle number (position) of time segments [-]	
%               Nbins           : Number of bins for histogram    
%               t_Histxy        : Histograms of time segments 
%               t_Mean          : Mean value of time segments
%               t_Std           : Standard deviation of time segments
%
%  example:     
%
%
%
%  copyright:	Philips GmbH, Automotive Playback Modules, (c) 2006
%  author:	APM-DP; Horst Rumpf
%  version:	0.0.1 (MATLAB 4.0)
%  date:	15.02.2006
%

% Umwandlung in Spaltenvektor
[c r]=size(vv);
if r >1 
    vv=vv';
end

dt=1/sample_frequency;          % sampling time

NN      =length(vv);                                    % Number of values
Nslot   =floor(NN/N);                                   % Number of values per time segment

Ncalc	=floor(Nslot*(1+P));                            % Number of values for the calculation with overlapping
Nbins	= n_bins(Ncalc);                                % Number of bins for the calculation of the histograms

x_bins  =linspace(min(vv),max(vv),Nbins);               % Axis-vector for all histograms

for i=1:N
    Nstart  =1+(i-1)*Nslot;                             % start point of the segment
    Nend    =Nstart+Ncalc;                              % end point of the segment
    if Nend > NN
        Nend=NN;
    end
    t_Histxy(i,:)=hist(vv(Nstart:Nend),x_bins);         % calculation of the histogram of the segment    
    t_Mean(i)    =mean(vv(Nstart:Nend));                % calculation of the mean value of the segment    
    t_Std(i)     =std(vv(Nstart:Nend));                 % calculation of the standard deviation of the segment    
end
t=dt*floor(linspace(floor(Nslot/2),NN-floor(Nslot/2),N));  % position number of the segments
