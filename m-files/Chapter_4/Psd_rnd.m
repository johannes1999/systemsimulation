function [t,Y,hz,P] = Psd_rnd(Dfr,DPSD,nofp,notp,te)
%
%  PSD_RND generates random time sequence with the given 
%  PSD (Power Spectral Density) Profile (Dfr, DPSD)
%
%	description:	[t,Y,hz,P] = PSD_RND(Dfr,DPSD,nofp,notp,te);
%			 
%	input:		PSD Profile: DPSD(Dfr)
%               Dfr :   Frequency point of PSD Profile    [Hz]
%               DPSD:   DSP Values of PSD Profile         [g²/Hz]  
%               nofp:   number of frequency points. Interpolations 
%                       of PSD Profile (typical: 400) 
%			    notp:   number of equidistant time points (2000)
%			    te:     stop time (starting time to = 0)
%
%	output:		t: equidistant time vector with notp elements
%			    Y: generated random diplacement vector with given 
%                  PSD Profile (Dfr, DPSD)
%               g_rms: RMS value of the profile

%	example:	Dfr	    = [10,20,40,800,1000]
%               DPSD	= [ 0.01,0.025,0.025,0.0005,0.0005]
%
%
%               [t,Y] = PSD_RND(Dfr,DPSD,400,2000,1.0);
%
%	result:		t = [0 0.0005 0.0010, .....] (2000 elements)
%			    Y = [-1.8637 0.2299 0.9304 1.8984 2.7287 5.4557 3.3166 ....]
%
%	copyright:	Philips PRLE, Meindert Norg (1997)
%			    Philips GmbH, Automotive Playback Modules, 10-1997
%	author:		APM-IP, Kees Wouters
%	version:	0.0.2 (MATLAB 4.0)
%	date:		10-1997
%               6.03.2006 Name changed and adapted for general profiles Horst Rumpf
%               27.04.2009 comments added and not used calculations deleted
%
%	See also:	test_PSD


% frequency and time vector
hz	= linspace(min(Dfr),max(Dfr),nofp);	    % frequency vector      [Hz]
w	= 2*pi*hz;			                    % Angular frequency     [1/s]
dhz	= hz(2)-hz(1);			                % frequency steps       [Hz]
t	= linspace(0,te,notp);		            % time vector           [s]


% interpolation
P	= exp(interp1(log(Dfr),log(DPSD),log(hz)));             % Profile with exponential interpolation
                                                            % Reason for exp. interpol.:
                                                            % The PSD profils normaly defined as lines in a logarithm 
                                                            % coordination system
Y	= 0;

for i=1:nofp
  Y	= Y + sqrt(2*P(i)*dhz) * cos(w(i)*t + rand(1)*2*pi)';   % Time Signal Remark: Faktor 2 at sqrt(2*P(i)) rms-> amplitude
 % Y	= Y + Dreieck( sqrt(2*P(i)*dhz),2*pi/w(i),rand(1)*2*pi,t);
end

