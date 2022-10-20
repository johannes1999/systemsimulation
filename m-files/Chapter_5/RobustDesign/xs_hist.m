 function []=xs_hist(vv,bins,vtxt,ttxt,dtxt)
%
%  M-file:	xs_hist.m	function []=xs_hist(vv,bins,vtxt,ttxt,dtxt)
%
%  description: add some information to histogram
%
%               
%  input:	     vv    : Variable (vector)
%                bins  : Number of bins 
%                vtxt  : Description for variable vv
%                ttxt  : Title
%                dtxt  : Dimension of variable vv
% 
%  output:	   
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
  m=mean(vv); s3=3*std(vv);
  
 %hist(vv,bins); 
 
[n, xb]=hist(vv, bins);  % calculate histogram

% scale to relative frequency
ns=n./length(vv);
[xxx, yyy]=bar_v4(xb,ns);   % calculate bars

fill(xxx,yyy,'b','EdgeColor','b'); grid; 
xlabel([vtxt, ' x= ', num2str(m,3), '  3*S= ', num2str(s3,3), ' ', dtxt]);
ylabel('rel. frequency [-]')
title(ttxt);
axis tight;
  
hold on

% 3-Sigma lines
y=[0 max(ns)];    
plot([m m],y,'r -.',[m m]-s3,y,'r -.',[m m]+s3,y,'r -.');
  