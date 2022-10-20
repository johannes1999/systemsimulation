%	function n_bins
%
%   calculate the number of bins of N values for a histogram
%
%	input	:	N       : number of values
%			                                        
%
%	output	:   n_bins	: number of bins (classes)
%
% 	exampl	:	n_bins(N)=5+round(N/20) max 200
%
% copyright:	Philips GmbH, Automotive Playback Modules, (c) 2006
% autor:	APM-DP,	Horst Rumpf
% date:		07-02-06
%           19-10-2007 max value changed from 1050 to 250
%
% see also:

function AnzKl = n_bins(N)
max_AnzKl=200;
  AnzKl =5+round(N/20);
    if AnzKl > max_AnzKl
        AnzKl=max_AnzKl;
    end