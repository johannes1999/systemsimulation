function vv = where(XoperatorY,v_true,v_false)

% WHERE: Apply if .. then .. else .. construction to matrices and vectors.
% ============================================================================
% vv = where(XoperatorY,v_true,v_false)
% ----------------------------------------------------------------------------
% vv        : output (matrix or vector). Becomes v_true at all elements where
%             XoperatorY is true and v_false at all other elements.
% XoperatorY: logical element by element operation e.g. x > y
% v_true    : return value (matrix, vector or scalar) for elements where
%             XoperatorY is true.
% v_false   : return value (matrix, vector or scalar) for elements where
%             XoperatorY is false.
% ----------------------------------------------------------------------------
% Example: find maximum from vector x and vector y (if x>y then x else y)
%          x=[-3 -2 -1 0 1 2 3]; y=[3 2 1 0 -1 -2 -3];
%          v=where(x>y, x, y); results in v=[3 2 1 0 1 2 3]
%          limit x to values >= 0 (if x<0 then x=0)
%          v=where(x<0, 0, x); results in v=[0 0 0 0 1 2 3]
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.3 (MATLAB 4)     Date : January 11, 1996
% ============================================================================

% size checking
size_op=size(XoperatorY);
size_vt=size(v_true);
size_vf=size(v_false);

% boolean for v_true is scalar
scalar_vt=(max(size_vt)==1);

% if v_true not a scalar and size(v_true) ~= size(XoperatorY)
if ~scalar_vt & any(size_vt~=size_op)
  error('v_true not a scalar or size(v_true) not equal size(XoperatorY)')
end

% if v_false not a scalar and size(v_false) ~= size(XoperatorY)
if length(v_false)>1 & any(size_vf~=size_op)
  error('v_false not a scalar or size(v_false) not equal size(XoperatorY)')
end

% first assume all elements are false (independent of size of v_false)
vv=v_false.*ones(size_op);

% find index for true elements
index=find(XoperatorY);
if length(index)>0
  if scalar_vt
    vv(index)=v_true.*ones(size(index));
  else
    vv(index)=v_true(index);
  end
end
% ============================================================================

