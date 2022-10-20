function vv=r_vect(mu,sigma,type,vsize,lsl,usl);

% R_VECT: Generate a random vector for use in Monte Carlo analysis
% ============================================================================
% vv=r_vect(mu,sigma,type,vsize,[lsl],[usl]);
% ----------------------------------------------------------------------------
%
% *** WARNING: This function is replaced by RND_VECT,
%     and will disappear in future versions of the Robust Design toolbox
%
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.3 (MATLAB 4)     Date : January 11, 1996
% ============================================================================

% Not documented feature to skip the warning.
% if SKIP_RVECT_WARNING==0 or [] the warning is displayed
% else the warning is NOT displayed.
global SKIP_RVECT_WARNING

if length(vsize)==1
  ns=vsize;
else
  ns=length(vsize);
end

if nargin<5,
  lsl=NaN;
elseif length(lsl)==0,
  lsl=NaN;
end
if nargin<6,
  usl=NaN;
elseif length(usl)==0,
  usl=NaN;
end

if SKIP_RVECT_WARNING==0 | length(SKIP_RVECT_WARNING)==0
  message('r_vect', ...
          ['Function r_vect is replaced by function rnd_vect and\n' ...
           'will disappear in future versions of the ROB_DES' ...
           ' toolbox.\nPlease use function rnd_vect instead.'])
end

if strcmp(type,'discrete')==1
  vv=rnd_vect(ns, type, [mu-sigma;mu+sigma], lsl, usl);
else
  vv=rnd_vect(ns, type, [mu;sigma], lsl, usl);
end

% ============================================================================

