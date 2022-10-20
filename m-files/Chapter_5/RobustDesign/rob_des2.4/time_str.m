function tstr=time_str()

% TIME_STR: Return the actual date and time in a string (for internal usage)
% ============================================================================
% tstr=time_str()
% ----------------------------------------------------------------------------
% tstr: String containing the actual date and time (format= 'yymmdd hh:mm')
% ----------------------------------------------------------------------------
% Example: tstr=time_str;
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.3 (MATLAB 4)     Date : January 11, 1996
% ============================================================================

t=clock;                                           % get actual time
year=rem(t(1),100);                                % throw away century part
tstr=sprintf('%02.0f%02.0f%02.0f',year,t(2),t(3)); % make string of date part
tstr=[tstr sprintf(' %02.0f:%02.0f',t(4),t(5))];   % make string of time part

% ============================================================================

