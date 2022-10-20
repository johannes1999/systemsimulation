function hist_txt(vv,bins,vtxt,ttxt,opt)

% HIST_TXT: Plot a relative frequency histogram with title, xlabel & ylabel
% ============================================================================
% hist_txt(vv,[bins],[vtxt],[ttxt],[opt]);
% ----------------------------------------------------------------------------
% vv    : Variable (vector)
% bins  : Number of bins (default=10)
% vtxt  : Description for variable vv
% ttxt  : Title (text)
% opt   : Option for added text at the end of the title (default=3)
%         0 = none
%         1 = date & time
%         2 = number of simulations
%         3 = both
% ----------------------------------------------------------------------------
% Example: hist_txt(vv,40,'xlabel','title',3);
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.4 (MATLAB 5)     Date : April 29, 1979
% ============================================================================

if nargin<2   % check bins
  bins=10;
elseif length(bins)==0,
  bins=10;
end

if nargin<4   % check ttxt
  ttxt='';
elseif length(ttxt)==0,
  ttxt='';
end

if nargin<5   % check opt, set to default
  opt=3;
elseif length(opt)==0,
  opt=3;
end

[n xb]=hist(vv, bins);  % calculate histogram

% scale to relative frequency
ns=n./length(vv);
[xxx yyy]=bar_v4(xb,ns);   % calculate bars

fighandle=gcf;    % get handle for current figure
% get for the current figure the value for option Color (=backgroundcolor)
backcol=get(fighandle, 'Color');
if norm(backcol)>=0.87
  plcolor1='k';   % used for axis, grid
  plcolor2='c';   % used for bars
else
  plcolor1='w';   % used for axis, grid
  plcolor2='y';   % used for bars
end

% plot(xxx,yyy,plcolor2);     % this is the old version
% fill rectangles and set the color of the edges around the filled part
% from the default value black to plcolor2
fill(xxx,yyy,plcolor2,'EdgeColor',plcolor2);
hold_state=ishold;  % check if hold is on
hold on
% redraw horizontal axis in plcolor1 (because it is plotted in plcolor2 now)
axy = axis;
plot([axy(1) axy(2)],[0 0],[plcolor1 '-'])

if hold_state==0  % if hold was off before switching it on, switch hold off
  hold off;
end

% if necessary plot vtxt
if nargin>=3,
  if length(vtxt)>0,
    xlabel(vtxt);
  end;
end;

ylabel('Relative frequency');

if opt>=1 & opt<=3
  disp_text=' ';
  if opt==1 | opt==3
    disp_text=[disp_text  time_str ' '];
  end
  if opt==2 | opt==3
    disp_text=[disp_text 'n=' int2str(length(vv))];
  end
else
  disp_text='';
end

ttxt=[ttxt disp_text];
if length(ttxt)>0,
  title(ttxt);
end

figure(fighandle); % show result

% ============================================================================

