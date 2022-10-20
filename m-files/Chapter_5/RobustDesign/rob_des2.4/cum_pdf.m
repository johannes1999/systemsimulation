function [no,xo] = cum_pdf(vv,bins)

% CUM_PDF: Calculate and/or plot the cumulative probability function
% ============================================================================
% [cpf,xb]=cum_pdf(vv,[bins]);
% ----------------------------------------------------------------------------
% vv    : Variable (vector)
% bins  : Number of bins or vector specifying bins (default=10)
% ----------------------------------------------------------------------------
% cum_pdf(vv) plots a cumulative probability function with
% 10 equally spaced bins between the minimum and maximum values in vv.
% cum_pdf(vv,bins), where bins is a scalar, uses bins bins.
% cum_pdf(vv,bins), where bins is a vector, plots a cumulative probability
% function using the bins specified in bins.
% [cpf,xb] = cum_pdf(...) does not draw a graph, but returns vectors
% cpf and xb such that plot(xb,cpf) plots the cumulative probability
% function.
% ----------------------------------------------------------------------------
% Example: cum_pdf(vv,40); (graph) or [cpf,xb]=cum_pdf(vv,40); (calculation)
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.3 (MATLAB 4)     Date : January 11, 1996
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
  bins=miny-binwidth/2+binwidth*[1:bins];
end

% sort input into bins
nb = max(size(bins));
nn = zeros(nb,n);
for i=1:nb
  nn(i,:) = sum(vv <= bins(i));
end

% scale to cum_pdf (meaning cum_pdf(inf)=1)
ns=nn./length(vv);

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

