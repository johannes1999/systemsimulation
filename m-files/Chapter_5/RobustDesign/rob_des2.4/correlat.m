function [R,Rmin,Rmax,a]=correlat(xx,yy,conf)

% CORRELAT: Calculate correlation coeficient and confidence interval
% ============================================================================
% [R,Rmin,Rmax,a]=correlat(xx,yy,[conf])
% ----------------------------------------------------------------------------
% R    : correlation coefficient
% Rmin : lower limit of confidence interval correlation coefficient
% Rmax : upper limit of confidence interval correlation coefficient
% a    : regression coefficient (nominal sensitivity or a in yy=a*xx+b)
% ----------------------------------------------------------------------------
% xx   : Variable (vector)
% yy   : Variable (vector)
% conf : confidence (0 < conf < 1) (scalar). Default 0.95 for 95%
% ----------------------------------------------------------------------------
% Example: [R,Rmin,Rmax,a]=correlat(xx,yy,0.99);
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
% Version  : 2.3 (MATLAB 4)     Date : January 11, 1996
% ============================================================================

% setting default value conf
if nargin<3
  conf=0.95;
elseif length(conf)<1
  conf=0.95;
end

% size checking input
size_xx=size(xx);
size_yy=size(yy);
if any(size_xx~=size_yy)
  error('xx and yy must be the same size')
end

ns=max(size_xx);
% error checking
if ns<=1
  error('Cannot calculate correlation of two scalars')
end


rmat=corrcoef(yy,xx);     % calculate correlation matrix

R=rmat(1,2);

if ns<25
  % algorithm confidence interval can not be used for ns<25
  if nargout>1, Rmin=NaN; end
  if nargout>2, Rmax=NaN; end
  if nargout>3
    % calculate regression coefficient
    a=(sum(xx.*yy) - sum(xx)*sum(yy)/length(xx)) ./ ...
      (sum(xx.^2) - (sum(xx).^2)/length(xx));
  end
else
  if nargout>1
    % calculate confidence interval

    h1=0.5*log((1+R)./(1-R));
    h2=sqrt(2).*erfinv(conf)./sqrt(ns-3);
    Rmin=tanh(h1-h2);

    if nargout>2
      Rmax=tanh(h1+h2);

      if nargout>3
        % calculate regression coefficient
        a=(sum(xx.*yy) - sum(xx)*sum(yy)/length(xx)) ./ ...
          (sum(xx.^2) - (sum(xx).^2)/length(xx));
      end
    end
  end
end
