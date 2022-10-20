 function []=xs_hist_c(vv,bins,vtxt,ttxt,dtxt,c,opt)
%
%  M-file:	xs_hist_c.m	function
%  []=xs_hist_c(vv,bins,vtxt,ttxt,dtxt,c,opt)
%
%  description: add some information to histogram
%
%               
%  input:	     vv    : Variable (vector)
%                bins  : Number of bins 
%                vtxt  : Description for variable vv
%                ttxt  : Title
%                dtxt  : Dimension of variable vv
%                   c  : color example 'b' for blue
%                  opt : Option
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

fill(xxx,yyy,c,'EdgeColor',c);
grid;
if opt==0
 xlabel([vtxt, ' ', dtxt]);
elseif opt==1   
xlabel([vtxt, ' x= ', num2str(m,3), '  3*S= ', num2str(s3,3), ' ', dtxt]);
end

ylabel('rel. frequency [-]')
title(ttxt);
axis tight;
  
hold on

y=[0 max(ns)]; 
if opt==0
 
plot([m m],1.1*y,'k -.');
elseif opt==1   
% 3-Sigma lines      
plot([m m],1.1*y,'k -.',[m m]-s3,1.1*y,'r -.',[m m]+s3,1.1*y,'r -.');

end  