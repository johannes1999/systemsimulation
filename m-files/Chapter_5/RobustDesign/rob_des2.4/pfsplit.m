function [vpass,vfail,ipass,ifail] = pfsplit(XoperatorY,vv)

% PFSPLIT: Split vector or matrix in passes and fails (for internal usage)
% ============================================================================
% [vpass,vfail,ipass,ifail] = pfsplit(XoperatorY,vv)
% ----------------------------------------------------------------------------
% vpass     : In this vector/matrix all elements of vv where XoperatorY is
%             true are returned
% vfail     : In this vector/matrix all elements of vv where XoperatorY is
%             false are returned
% ipass     : In this vector/matrix the index of all elements of vv where
%             XoperatorY is true is returned
% ifail     : In this vector/matrix the index of all elements of vv where
%             XoperatorY is false is returned
% XoperatorY: logical element by element operation e.g. x > y
% vv        : input (matrix or vector).
% ----------------------------------------------------------------------------
% Example: get all values from vector x where y>0
%          x=[-3 -2 -1 0 1 2 3]; y=[3 2 1 0 -1 -2 -3];
%          vpass=pfsplit(y>0, x); results in vpass=[-3 -2 -1]
%          [vpass,vfail,ipass,ifail]=pfsplit(y>0, x);
%          results in vpass=[-3 -2 -1], vfail=[0 1 2 3],
%                     ipass=[1 2 3], ifail=[4 5 6 7]
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
% Version  : 2.3 (MATLAB 4)     Date : January 11, 1996
% ============================================================================

% Not documented feature to skip the warning.
% if SKIP_PFSPLIT_WARNING==0 or [] the warning is displayed
% else the warning is NOT displayed.
global SKIP_PFSPLIT_WARNING

if SKIP_PFSPLIT_WARNING==0 | length(SKIP_PFSPLIT_WARNING)==0
  message('pfsplit', 'Function pfsplit effects vectorsizes !')
end

% size checking
size_op=size(XoperatorY);
size_vv=size(vv);

if any(size_vv~=size_op)
  error('size(vv) not equal size(XoperatorY)')
end

% find index for true elements
ipass=find(XoperatorY);
if length(ipass)>0
  vpass=vv(ipass);      % return true elements
else
  vpass=[];
end

if nargout>1
  % find index for false elements
  ifail=find(XoperatorY==0);
  if length(ifail)>0
    vfail=vv(ifail);    % return false elements
  else
    vfail=[];
  end
end

% ============================================================================

