function vv=rnd_vect(ns,type,param,llim,usl)

% RND_VECT: Generate a random vector for use in Monte Carlo analysis
% ============================================================================
% vv=rnd_vect(ns,type,param,[lsl],[usl])
% ----------------------------------------------------------------------------
% vv    : Variable (vector)
% ns    : Number of simulations. For ns==1 the mean value respectively the
%         location parameter or the median value is returned.
% type  : Type of distribution (text)
%            type='delta'         : delta distribution (all the same value)
%            type='uniform'       : uniform distribution
%            type='discrete'      : uniform discrete distribution
%            type='normal'        : normal distribution
%            type='lognormal'     : lognormal distribution
%            type='large_extreme1': extreme value distr, largest value type I
%            type='large_extreme2': extreme value distr, largest value type II
%            type='large_extreme3': extreme value distr, largest value type III
%            type='small_extreme1': extreme value distr, smallest value type I
%            type='small_extreme2': extreme value distr, smallest value type II
%            type='small_extreme3': extreme value distr, smallest value type III
%            type='weibull'       : weibull distribution
% param : Parameters of the distribution (vector), depending on the type:
%            delta distribution:
%               param(1) = location parameter
%            uniform distribution:
%               param(1) = mean
%               param(2) = half interval width
%            discrete ditribution:
%               param(1) = lower side of interval
%               param(2) = upper side of interval
%            normal and lognormal distribution:
%               param(1) = mean
%               param(2) = spread (1 sigma !!)
%            large_extreme1 and small_extreme1 distributions:
%               param(1) = location parameter
%               param(2) = scale parameter
%            large_extreme2, small_extreme2,
%            large_extreme3, small_extreme3 and
%            weibull distributions:
%               param(1) = location parameter
%               param(2) = scale parameter
%               param(3) = shape parameter
% lsl   : Lower limit for a truncated distribution
%         (scalar/vector, default=no limit). No lower limit: use NaN or []
%         The old syntax is still supported (lsl is a vector of two scalars
%         and usl is not specified)
% usl   : Upper limit for a truncated distribution
%         (scalar/vector, default=no limit). No upper limit: use NaN or []
% ----------------------------------------------------------------------------
% Example: 1000 simulations, normal distribution, mean 10, spread 1,
%          no lower limit, upper limit 12.
%          x=rnd_vect(1000,'normal',[10 1],[],12);
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.4.a (MATLAB 5)     Date : October 8, 1998
% ============================================================================
%
%H. Rumpf 16-09-2011
%
% relpaced
%               finite    isfinite
%               isstr     ischar
% check ns
size_ns=size(ns);
if min(size_ns)~=1 || max(size_ns)~=1
  error('Parameter ns must be a scalar');
elseif ns<=0
  error('Parameter ns <= 0')
else
  vsize=[1,ns];       % size return vector
end

% Checking limits
if nargin>4
  % usl specified
  usl_exists=1;
  size_usl=size(usl);
  if max(size_usl)==0
    % usl=[]
    usl=NaN;
  elseif ~(size_usl(1)==1 && (size_usl(2)==1 || size_usl(2)==ns))
    error('Size of usl not correct')
  end
else
  % usl not specified
  usl_exists=0;
end

if nargin>3
  % llim exists
  size_llim=size(llim);
  if max(size_llim)>0
    % llim not empty

    % check size of llim. If llim is a vector containing two arguments
    % no usl may exist (compatibility to older versions of rnd_vect)
    if ~((min(size_llim)==1 && max(size_llim)==2 && usl_exists==0) || ...
         (size_llim(1)==1 && (size_llim(2)==1 || size_llim(2)==ns)))
      error('Size of lsl not correct')
    else
      if size_llim(1)==1 && size_llim(2)==2
        llim=llim';
      end
      if max(size_llim)==2
        % llim is a vector with two arguments
        lsl=llim(1,:); usl=llim(2,:);
      else
        % llim is a scalar or a vector 1 row ns columns
        lsl=llim;
        if usl_exists==0, usl=NaN; end
      end
    end
  else
    % llim is empty
    lsl=NaN;
    if usl_exists==0, usl=NaN; end
  end
else
  % both llim and usl are not specified
  lsl=NaN; usl=NaN;
end

if (~all(isnan(lsl))) && (~all(isnan(usl)))
  % both arguments are values
  if any(lsl>=usl)
    error('Lower limit >= upper limit')
  end
end

% Checking param
param_size=size(param);
if min(param_size)~=1
  error('Parameter param must be a vector')
end
length_param=max(param_size);

if ~ischar(type)
  error('Parameter type must be a string (including quotes)')
elseif strcmp(type, 'delta')==1
  % ========== DELTA DISTRIBUTION ==========
  % default values for limits
  index=find(isnan(lsl));
  if (~isempty(index)), lsl(index)=-inf.*ones(size(index)); end
  index=find(isnan(usl));
  if (~isempty(index)), usl(index)=+inf.*ones(size(index)); end

  if length_param~=1
    error([type,' distr. has one parameter'])
  elseif ns==1
    vv=param(1);     % return value
  else
    if ~isnan(param(1)) && (any(lsl>param(1)) || any(usl<param(1)))
      error([type, ' distr. no values contained within interval'])
    end
    vv=param(1).*ones(vsize);
  end
elseif strcmp(type, 'uniform')==1
  % ========== UNIFORM DISTRIBUTION ==========
  % default values for limits
  index=find(isnan(lsl));
  if (~isempty(index)), lsl(index)=-inf.*ones(size(index)); end
  index=find(isnan(usl));
  if (~isempty(index)), usl(index)=+inf.*ones(size(index)); end

  if length_param~=2
    error([type,' distr. has two parameters'])
  elseif param(2)<0
    error([type,' distr. half interval width < 0'])
  elseif ns==1
    vv=param(1);     % return mean value
  else
    if any(lsl>param(1)+param(2)) || any(usl<param(1)-param(2))
      error([type, ' distr. no values contained within interval'])
    end
    left=max(lsl, param(1)-param(2));
    right=min(usl, param(1)+param(2));
    middle=(left+right)./2;
    width=right-left;
    vv=middle.*ones(vsize) + width.*(rand(vsize) - 0.5);
  end
elseif strcmp(type, 'discrete')==1
  % ========== DISCRETE DISTRIBUTION ==========
  % default values for limits
  index=find(isnan(lsl));
  if (~isempty(index)), lsl(index)=-inf.*ones(size(index)); end
  index=find(isnan(usl));
  if (~isempty(index)), usl(index)=+inf.*ones(size(index)); end

  if length_param~=2
    error([type ' distr. has two parameters'])
  elseif param(2)<param(1)
    error([type,' distr. lower side interval > upper side interval'])
  elseif ns==1
    vv=round((param(1)+param(2))./2);     % return round(middle)
    message('rnd_vect', ...
            [type ' distr. Result is round((param(1)+param(2))./2).'])
  else
    if any(lsl>param(2)) || any(usl<param(1))
      error([type, ' distr. no values contained within interval'])
    end
    leftlimit=max(lsl, param(1));
    rightlimit=min(usl, param(2));
    if any(floor(leftlimit)==floor(rightlimit)) && ...
       any(floor(leftlimit)~=leftlimit) && any(floor(rightlimit)~=rightlimit)
      % inside interval no discrete number and no side discrete
      error([type,' no discrete numbers contained within interval'])
    end

    left=ceil(leftlimit)-0.5;
    right=floor(rightlimit)+0.5;
    middle=(left+right)./2;
    width=right-left;

    vv=round(middle.*ones(vsize) + width.*(rand(vsize) - 0.5));
  end
elseif strcmp(type, 'normal')==1
  % ========== NORMAL DISTRIBUTION ==========
  % default values for limits
  index=find(isnan(lsl));
  if (~isempty(index)), lsl(index)=-inf.*ones(size(index)); end%(~isempty(index))
  index=find(isnan(usl));
  if (~isempty(index)), usl(index)=+inf.*ones(size(index)); end

  if length_param~=2
    error([type,' distr. has two parameters'])
  elseif param(2)<=0
    % spread <= 0
    if param(2)==0
      % spread==0 return vector filled with mean
      if any(lsl>param(1)) || any(usl<param(1))
        error([type,' distr. spread=0, ' ...
                    'lower limit > mean or upper limit < mean'])
      end
    else
      error([type,' distr. spread < 0'])
    end
  end

  if ns==1
    vv=param(1);     % return mean value
  else
    vv=param(1).*ones(vsize) + param(2).*randn(vsize);
    if any(isfinite(lsl)) || any(isfinite(usl))
      % if not truncated skip selection part

      sindx=find((vv < lsl) | (vv > usl));
      while (~isempty(sindx))
        vv(sindx)=param(1).*ones(size(sindx))+param(2).*randn(size(sindx));
        sindx=find((vv < lsl) | (vv > usl));
      end
    end
  end
elseif strcmp(type, 'lognormal')==1
  % ========== LOGNORMAL DISTRIBUTION ==========
  % default values for limits
  index=find(isnan(lsl));
  if (~isempty(index)), lsl(index)=zeros(size(index)); end
  index=find(isnan(usl));
  if (~isempty(index)), usl(index)=+inf.*ones(size(index)); end

  if length_param~=2
    error([type,' distr. has two parameters'])
  elseif param(2)<=0
    if param(2)==0
      % spread==0 return vector filled with exp(mean)
      if any(lsl>exp(param(1))) || any(usl<exp(param(1)))
        error([type,' distr. spread=0, ' ...
                    'lower limit > exp(mean) or upper limit < exp(mean)'])
      end
    else
      error([type,' distr. spread < 0'])
    end
  elseif any(lsl<0) || any(usl<=0)
    error([type,' distr. upper or lower limit <= 0'])
  end

  if ns==1
    vv=exp(param(1));       % return median
    message('rnd_vect', ...
            [type ' distr. Result is median.'])
  else
    vv=exp(param(1) + param(2).*randn(vsize));
    if any(isfinite(lsl)) || any(isfinite(usl))
      % if truncated do selection part

      sindx=find((vv < lsl) | (vv > usl));
      while (~isempty(sindx))
        vv(sindx)=exp(param(1) + param(2).*randn(size(sindx)));
        sindx=find((vv < lsl) | (vv >usl));
      end
    end
  end
elseif strcmp(type, 'large_extreme1')==1
  % ========== LARGE EXTREME VALUE TYPE I DISTRIBUTION ==========
  % default values for limits
  index=find(isnan(lsl));
  if (~isempty(index)), lsl(index)=-inf.*ones(size(index)); end
  index=find(isnan(usl));
  if (~isempty(index)), usl(index)=+inf.*ones(size(index)); end

  if length_param~=2
    error([type,' distr. has two parameters'])
  elseif param(2)<=0
    error([type,' distr. scale parameter <= 0'])
  elseif ns==1
    vv=param(1);       % return location parameter
    message('rnd_vect', ...
            [type ' distr. Result is location parameter.'])
  else
    C1=zeros(size(lsl));            % assume all(lsl==-inf)
    index=find(isfinite(lsl));      % find lsl ~= -inf
    if ~isempty(index)
      C1(index)=exp(-exp(-(lsl(index)-param(1))./param(2)));
    end

    C2=ones(size(usl));             % assume all(usl==+inf)
    index=find(isfinite(usl));      % find usl ~= +inf
    if ~isempty(index)
      C2=exp(-exp(-(usl(index)-param(1))./param(2)));
    end

    vv=param(1)-param(2).*log(log(ones(vsize)./(C1+(C2-C1).*rand(vsize))));
  end
elseif strcmp(type, 'large_extreme2')==1
  % ========== LARGE EXTREME VALUE TYPE II DISTRIBUTION ==========
  % default values for limits
  index=find(isnan(lsl));
  if (~isempty(index)), lsl(index)=param(1).*ones(size(index)); end
  index=find(isnan(usl));
  if (~isempty(index)), usl(index)=+inf.*ones(size(index)); end

  if length_param~=3
    error([type,' distr. has three parameters'])
  elseif param(2)<=0
    error([type,' distr. scale parameter <= 0'])
  elseif param(3)<=0
    error([type,' distr. shape parameter <= 0'])
  elseif any(lsl<param(1)) || any(usl<param(1))
    error([type,' distr. upper or lower limit < location parameter'])
  elseif ns==1
    vv=param(1);       % return location parameter
    message('rnd_vect', ...
            [type ' distr. Result is location parameter'])
  else
    C1=zeros(size(lsl));          % assume all(lsl==param(1))
    index=find(lsl~=param(1));    % find lsl ~= param(1)
    if ~isempty(index)
      C1(index)=exp(-((lsl(index)-param(1))./param(2)).^(-param(3)));
    end

    C2=ones(size(usl));           % assume all(usl==+inf))
    index=find(isfinite(usl));      % find usl ~= +inf
    if ~isempty(index)
      C2= exp(-((usl(index)-param(1))./param(2)).^(-param(3)));
    end

    vv=param(1)+param(2).* ...
         (log(ones(vsize)./(C1+(C2-C1).*rand(vsize)))).^(-1./param(3));
  end
elseif strcmp(type, 'large_extreme3')==1
  % ========== LARGE EXTREME VALUE TYPE III DISTRIBUTION ==========
  % default values for limits
  index=find(isnan(lsl));
  if (~isempty(index)), lsl(index)=-inf.*ones(size(index)); end
  index=find(isnan(usl));
  if (~isempty(index)), usl(index)=param(1).*ones(size(index)); end

  if length_param~=3
    error([type,' distr. has three parameters'])
  elseif param(2)<=0
    error([type,' distr. scale parameter <= 0'])
  elseif param(3)<=0
    error([type,' distr. shape parameter <= 0'])
  elseif any(lsl>param(1)) || any(usl>param(1))
    error([type,' distr. upper or lower limit > location parameter'])
  elseif ns==1
    vv=param(1);       % return location parameter
    message('rnd_vect', ...
            [type ' distr. Result is location parameter.'])
  else
    C1=zeros(size(lsl));          % assume all(lsl==-inf)
    index=find(isfinite(lsl));      % find lsl ~= -inf
    if ~isempty(index)
      C1(index)=exp(-(-(lsl(index)-param(1))./param(2)).^param(3));
    end

    C2=ones(size(usl));           % assume all(usl = param(1))
    index=find(usl~=param(1));    % find usl ~= param(1)
    if ~isempty(index)
      C2=exp(-(-(usl(index)-param(1))./param(2)).^param(3));
    end

    vv=param(1)-param(2).* ...
         (log(ones(vsize)./(C1+(C2-C1).*rand(vsize)))).^(1./param(3));
  end
elseif strcmp(type, 'small_extreme1')==1
  % ========== SMALL EXTREME VALUE TYPE I DISTRIBUTION ==========
  % default values for limits
  index=find(isnan(lsl));
  if (~isempty(index)), lsl(index)=-inf.*ones(size(index)); end
  index=find(isnan(usl));
  if (~isempty(index)), usl(index)=+inf.*ones(size(index)); end

  if length_param~=2
    error([type,' distr. has two parameters'])
  elseif param(2)<=0
    error([type,' distr. scale parameter <= 0'])
  elseif ns==1
    vv=param(1);       % return location parameter
    message('rnd_vect', ...
            [type ' distr. Result is location parameter.'])
  else
    C1=ones(size(lsl));             % assume all(lsl==-inf)
    index=find(isfinite(lsl));      % find lsl ~= -inf
    if ~isempty(index)
      C1(index)=exp(-exp((lsl(index)-param(1))./param(2)));
    end

    C2=zeros(size(usl));            % assume all(usl==+inf)
    index=find(isfinite(usl));      % find usl ~= inf
    if ~isempty(index)
      C2=exp(-exp((usl(index)-param(1))./param(2)));
    end

    vv=param(1)+param(2).*log(log(ones(vsize)./(C1-(C1-C2).*rand(vsize))));
  end
elseif strcmp(type, 'small_extreme2')==1
  % ========== SMALL EXTREME VALUE TYPE II DISTRIBUTION ==========
  % default values for limits
  index=find(isnan(lsl));
  if (~isempty(index)), lsl(index)=-inf.*ones(size(index)); end
  index=find(isnan(usl));
  if (~isempty(index)), usl(index)=param(1).*ones(size(index)); end

  if length_param~=3
    error([type,' distr. has three parameters'])
  elseif param(2)<=0
    error([type,' distr. scale parameter <= 0'])
  elseif param(3)<=0
    error([type,' distr. shape parameter <= 0'])
  elseif any(lsl>param(1)) || any(usl>param(1))
    error([type,' distr. upper or lower limit > location parameter'])
  elseif ns==1
    vv=param(1);       % return location parameter
    message('rnd_vect', ...
            [type ' distr. Result is location parameter'])
  else
    C1=-ones(size(lsl));          % assume all(lsl==-inf)
    index=find(isfinite(lsl));      % find lsl ~= inf
    if ~isempty(index)
      C1(index)=-exp(-((-(lsl(index)-param(1))./param(2)).^(-param(3))));
    end

    C2=zeros(size(usl));          % assume all(usl==param(1))
    index=find(usl~=param(1),1);    % find usl ~= param(1)
    if ~isempty(index)
      C2= -exp(-((-(usl-param(1))./param(2)).^(-param(3))));
    end

    vv=param(1)-param(2).* ...
         (log(-1.*ones(vsize)./(C1+(C2-C1).*rand(vsize)))).^(-1./param(3));
  end
elseif strcmp(type, 'small_extreme3')==1 || strcmp(type, 'weibull')==1
  % ========== WEIBULL - SMALL EXTREME VALUE TYPE III DISTRIBUTION ==========
  % default values for limits
  index=find(isnan(lsl));
  if (~isempty(index)), lsl(index)=param(1).*ones(size(index)); end
  index=find(isnan(usl));
  if (~isempty(index)), usl(index)=+inf.*ones(size(index)); end

  if length_param~=3
    error([type,' distr. has three parameters'])
  elseif param(2)<=0
    error([type,' distr. scale parameter <= 0'])
  elseif param(3)<=0
    error([type,' distr. shape parameter <= 0'])
  elseif any(lsl<param(1)) || any(usl<param(1))
    error([type,' distr. upper or lower limit < location parameter'])
  elseif ns==1
    vv=param(1);       % return location parameter
    message('rnd_vect', ...
            [type ' distr. Result is location parameter.'])
  else
    C1=ones(size(lsl));           % assume all(lsl==param(1))
    index=find(lsl~=param(1));    % find lsl ~= param(1)
    if ~isempty(index)
      C1(index)=exp(-((lsl(index)-param(1))./param(2)).^param(3));
    end

    C2=zeros(size(usl));          % assume all(usl = +inf)
    index=find(isfinite(usl));      % find usl ~= +inf
    if ~isempty(index)
      C2=exp(-((usl(index)-param(1))./param(2)).^param(3));
    end

    vv=param(1)+param(2).* ...
         (log(ones(vsize)./(C1-(C1-C2).*rand(vsize)))).^(1./param(3));
  end
else
  error(['Type "',type,'" not implemented']);
end

% ============================================================================

