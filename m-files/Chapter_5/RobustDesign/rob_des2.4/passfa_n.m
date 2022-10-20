function [el,cog]=passfa_n(xx,yy,lsl,usl,ptype,xtxt,ytxt,ttxt,opt)

% PASSFA_N: Calculate statistical sensitivity of input x to output y
% ============================================================================
% [el,cog]=passfa_n(xx,yy,[lsl],[usl],[ptype],[xtxt],[ytxt],[ttxt],[opt])
% ----------------------------------------------------------------------------
%
% *** WARNING: This function is replaced by PASSFAIL,
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

if nargin<3, lsl =[]; end
if nargin<4, usl =[]; end
if nargin<5, ptype=[]; end
if nargin<6, xtxt=[]; end
if nargin<7, ytxt=[]; end
if nargin<8, ttxt=[]; end
if nargin<9, opt =[]; end

% Not documented feature to skip the warning.
% if SKIP_PASSFA_WARNING==0 or [] the warning is displayed
% else the warning is NOT displayed.
global SKIP_PASSFA_WARNING

if SKIP_PASSFA_WARNING==0 | length(SKIP_PASSFA_WARNING)==0
  message('passfa_n', ...
          ['Function passfa_n is replaced by function passfail\n' ...
           'and will disappear in future versions of the ROB_DES' ...
           ' toolbox.\nPlease use function passfail instead.'])
end

[el,cog]=passfail(xx,yy,lsl,usl,ptype,xtxt,ytxt,ttxt,opt);

% ============================================================================

