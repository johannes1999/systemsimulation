function message(ftxt, mtxt)

% MESSAGE: display a warning message (for internal usage)
% ============================================================================
% message(ftxt, [mtxt])
% ----------------------------------------------------------------------------
% ftxt : Name of calling function (text)
% mtxt : Message (text)
% ----------------------------------------------------------------------------
% Example: message('passfail', 'Parameter xx constant');
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.3 (MATLAB 4)     Date : January 11, 1996
% ============================================================================

fprintf(2,['\nWARNING: function ' ftxt '.\n'])
if nargin>1
  if length(mtxt)>0
    fprintf(2,mtxt)
  end
end
fprintf(2,'\n\n')
% ============================================================================

