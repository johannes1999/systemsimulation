function [yl,cl]=yield(yy,lsl,usl,conf)

% YIELD: Calculate the yield
% ============================================================================
% [yl,cl]=yield(yy,[lsl],[usl],[conf]);
% ----------------------------------------------------------------------------
% yl  : Yield value
% cl  : Uncertainty yield (half width confidence interval as defined by conf)
% ----------------------------------------------------------------------------
% yy  : Output variable (vector)
% lsl : Lower specification limit (scalar or vector). Default min(yy).
% usl : Upper specification limit (scalar or vector). Default max(yy).
% conf: Confidence (0 < conf < 1) (scalar). Default 0.95 for 95%
%
% This function accepts multiple output matrix variables. For more
% details see reference manual.
% ----------------------------------------------------------------------------
% Example: [yl,cl]=yield(yy,0,[],0.90);
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.3 (MATLAB 4)     Date : January 11, 1996
% ============================================================================

% Determine number of output functions (ny) and length (nsize)
[ny nsize]=size(yy);

% Set default values for acceptance limits
if nargin<2, lsl=min(yy')'; elseif length(lsl)==0, lsl=min(yy')'; end
if nargin<3, usl=max(yy')'; elseif length(usl)==0, usl=max(yy')'; end
if nargin<4, conf=0.95; elseif length(conf)==0, conf=0.95; end

% Check number and size acceptance limits
[n1 n2]=size(lsl);
if n1~=ny, error('Number of lower limits lsl not correct'); end
if n2~=1 & n2~=nsize, error('Length of lower limit lsl not correct'); end
[n1 n2]=size(usl);
if n1~=ny, error('Number of upper limits usl not correct'); end
if n2~=1 & n2~=nsize, error('Length of upper limit usl not correct'); end

% Interpret NaN to skip output functions without lower or upper limit
for iy=1:ny
  index=find(isnan(lsl(iy,:))==1);
  if length(index)>0, lsl(iy,index)=min(yy(iy,:))*ones(size(index)); end
  index=find(isnan(usl(iy,:))==1);
  if length(index)>0, usl(iy,index)=max(yy(iy,:))*ones(size(index)); end
end

% ----------------------------------------------------------------------------

% Create text string for a combined find on all output functions
ftxt='(yy(1,:)>=lsl(1,:))&(yy(1,:)<=usl(1,:))';
for iy=2:ny
   ftxt=[ftxt '&' sprintf('(yy(%d,:)>=lsl(%d,:))&(yy(%d,:)<=usl(%d,:))', ...
                          iy,iy,iy,iy)];
end

% Find number of output results within acceptance limits
npass=length(eval(['find(' ftxt ')']));

% ----------------------------------------------------------------------------

% Calculate yield and spread
yl=npass/nsize;

if (nargout>1)
  z=sqrt(2).*erfinv(conf);      % L/sigma factor
  cl=z.*sqrt((yl.*(1-yl))/nsize);

  if nsize.*yl.*(1-yl)<6    % check if assumption for cl is correct
    message('yield', ...)
            ['The algorithm for the confidence interval is not correct\n' ...
             'in this case.'])
  end
end

% ============================================================================

