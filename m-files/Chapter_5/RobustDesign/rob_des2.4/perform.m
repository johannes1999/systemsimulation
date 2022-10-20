function [Cp,Cpk]=perform(yy,target,lsl,usl)

% PERFORM : Calculate capability indicators Cp and Cpk
% ============================================================================
% [Cp,Cpk]=perform(yy,[target],[lsl],[usl]);
% ----------------------------------------------------------------------------
% Cp    : Short-term capability ratio, Cp=(usl-lsl)/(6*STD(yy))
% Cpk   : Mid-term capability ratio, Cpk=Cp*{1-2*|target-MEAN(yy)|/(usl-lsl)}
% yy    : Output variable (vector)
% target: Target value (scalar) for output variable yy (default=MEAN(yy)).
% lsl   : Lower specification limit (scalar).
% usl   : Upper specification limit (scalar).
%
% This function accepts multiple output matrix variables. For more
% details see reference manual.
% ----------------------------------------------------------------------------
% Example: [Cp,Cpk]=perform(yy,1,[],3);
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.3 (MATLAB 4)     Date : February 1, 1996
% ============================================================================


% get size information
size_yy=size(yy);
vsize=[size_yy(1),1];       % size output vectors

mu=mean(yy')';
sigma=std(yy')';

% default for target is mean
if nargin<2
  target=mu;
elseif length(target)==0
  target=mu;
end

% default settings for lsl and usl are NaN
if nargin<3
  lsl=NaN*ones(vsize);
elseif length(lsl)==0
  lsl=NaN*ones(vsize);
end
if nargin<4
  usl=NaN*ones(vsize);
elseif length(usl)==0
  usl=NaN*ones(vsize);
end

size_t=size(target);
size_lsl=size(lsl);
size_usl=size(usl);

% size checking
if size_t(1)~=size_yy(1)
  error('Number of targets not correct')
end
if size_lsl(2)~=1
  error('Length of lower limits not correct')
elseif size_lsl(1)~=size_yy(1)
  error('Number of lower limits not correct')
end
if size_usl(2)~=1
  error('Length of upper limits not correct')
elseif size_usl(1)~=size_yy(1)
  error('Number of upper limits not correct')
end

index=find(isnan(target));
if length(index)>0
  target(index)=mu(index);
end

% initialisation assume no lsl and no usl
Cp=zeros(vsize);
Cpk=zeros(vsize);

% only lsl
index=find(~isnan(lsl) & isnan(usl));
if length(index)>0
  % next line is changed due to bug october 10, 1995
  Cp(index)=(mu(index) - lsl(index))./(3*sigma(index));
  % next line is changed due to bug february 1, 1996
  Cpk(index)=(target(index) - lsl(index))./(3*sigma(index)).* ...
             (1 - abs(target(index) - mu(index))./ ...
             (target(index) - lsl(index)));
end

% only usl
index=find(isnan(lsl) & ~isnan(usl));
if length(index)>0
  % next line is changed due to bug october 10, 1995
  Cp(index)=(usl(index) - mu(index))./(3*sigma(index));
  % next line is changed due to bug february 1, 1996
  Cpk(index)=(usl(index) - target(index))./(3*sigma(index)).* ...
             (1 - abs(target(index) - mu(index))./ ...
             (usl(index) - target(index)));
end

% both lsl and usl
index=find(~isnan(lsl) & ~isnan(usl));
if length(index)>0
  Cp(index)=(usl(index) - lsl(index))./(6*sigma(index));
  Cpk(index)=Cp(index).* ...
             (1 - abs(target(index) - mu(index))./ ...
             ((usl(index) - lsl(index))/2));
end
% ============================================================================

