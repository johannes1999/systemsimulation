function [no,xo]=pdfun(vv,bins)

% PDFUN: Calculate and/or plot a probability density function
% ============================================================================
% [pd,xb]=pdfun(vv,[bins]);
% ----------------------------------------------------------------------------
% vv   : Distribution values (vector)
% bins : Number of bins or vector specifying bins (default=10)
% ----------------------------------------------------------------------------
% pdfun(vv) plots a probability density function with 10 equally spaced
% bins between the minimum and maximum values in vv, showing the distribution
% of the elements in vector vv.
% pdfun(vv,bins), where bins is a scalar, uses bins bins.
% pdfun(vv,bins), where bins is a vector, draws a probability density function
% using the bins specified in bins.
% [pd,xb] = pdfun(...) does not draw a graph, but returns vectors
% pd and xb such that plot(xb,pd) is the probability density function.
% ----------------------------------------------------------------------------
% Example: pdfun(vv,40) (for graph) or [pd,xb]=pdfun(vv,40) (for calculation)
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.4 (MATLAB 5)     Date : April 29, 1997
% ============================================================================

% checking input
if nargin == 0
  error('Requires one or two input arguments.')
end
if nargin == 1
  bins = 10;
end
if min(size(vv))==1, vv = vv(:); end
if isstr(bins) | isstr(vv)
  error('Input arguments must be numeric.')
end
[m,n] = size(vv);
if max(size(bins)) == 1
  % bins is scalar, generate bins equidistant bins between min(vv) and max(vv)
  miny = min(min(vv));
  maxy = max(max(vv));
  binwidth = (maxy - miny) ./ bins;
  % calculate limits of the bins
  xx = miny + binwidth*[0:bins];
  xx(length(xx)) = maxy;
  % middle of the bins
  bins = xx(1:length(xx)-1) + binwidth/2;
else
  % bins is a vector giving the middle of the bins
  xx = bins(:)';
  miny = min(min(vv));
  maxy = max(max(vv));
  binwidth = [diff(xx) 0];
  % calculate limits of the bins
  xx = [xx(1)-binwidth(1)/2 xx+binwidth/2];
  xx(1) = miny;
  xx(length(xx)) = maxy;
end

% sort input into bins
nbin = max(size(xx));
nn = zeros(nbin,n);
for i=1:nbin
  nn(i,:) = sum(vv <= xx(i));
end
nn = nn(2:nbin,:) - nn(1:nbin-1,:);

% scale to pdf (meaning integral -inf to inf from pdf =1)
ns=nn./(length(vv)*diff(xx'));

if nargout == 0
  plot(bins,ns,'y-',bins,ns,'y*');
else
  if min(size(vv))==1, % Return row vectors if possible.
    no = ns';
    xo = bins;
  else
    no = ns;
    xo = bins';
  end
end

% ============================================================================

