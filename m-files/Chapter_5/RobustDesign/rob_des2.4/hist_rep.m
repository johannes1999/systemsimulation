function hist_rep(vv,bins,vtxt,ttxt,opt,ctxt1,ctxt2,ctxt3,ctxt4,ctxt5)

% HIST_REP: Plot a histogram with statistical information and comment lines
% ============================================================================
% hist_rep(vv,[bins],[vtxt],[ttxt],[opt],...
%          [ctxt1],[ctxt2],[ctxt3],[ctxt4],[ctxt5]);
% ----------------------------------------------------------------------------
% vv    : Variable (vector)
% bins  : Number of bins (default=10)
% vtxt  : Description for variable vv (text)
% ttxt  : Title (text)
% opt   : Option for added text below the comments (default=3)
%         0 = none
%         1 = date & time
%         2 = number of simulations
%         3 = both
% ctxt1 : Comment line 1 (text, max. 30 characters)
% ...
% ctxt5 : Comment line 5 (text, max. 30 characters)
% ----------------------------------------------------------------------------
% The function hist_rep generates a relative frequency histogram including
% results like mean, standard deviation, minimum and maximum (to be used
% in reports). In this function it is possible to add up to 5 lines comment.
% Attention: this function uses the subplot command, so it can not be used in
% combination with a subplot command.
% ----------------------------------------------------------------------------
% Example: hist_rep(vv,40,'xlabel','title',3,...
%                   'first comment','second comment','','','fifth comment');
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.3 (MATLAB 4)     Date : January 11, 1996
% ============================================================================

clf
% Check existance of variables for function hist_txt.m,
% eventually set to default
if nargin<2
  bins=[];
end

if nargin<3
  vtxt='';
elseif length(vtxt)==0,
  vtxt='';
end

if nargin<4
  ttxt=[];
elseif length(ttxt)==0
  ttxt='';
end

% check opt, eventually set to default
if nargin<5
  opt=3;
elseif length(opt)==0,
  opt=3;
end

subplot(221);
% plotting the text part
xstartt=-3;           % horizontal offset for text
xstartn=26;           % horizontal offset for numbers (mean etc.)
hstart=12;            % vertical offset
nchar=30;             % maximum number of characters in comment
format_str='%-6.3G';  % format used for printing mean etc.

text(xstartt,hstart,'Mean value');
text(xstartn,hstart,[': ' sprintf(format_str,mean(vv))]);
text(xstartt,hstart-1,'Standard deviation');
text(xstartn,hstart-1,[': ' sprintf(format_str,std(vv))]);
text(xstartt,hstart-2,'3*standard deviation');
text(xstartn,hstart-2,[': ' sprintf(format_str,3*std(vv))]);
text(xstartt,hstart-3,'6*standard deviation');
text(xstartn,hstart-3,[': ' sprintf(format_str,6*std(vv))]);

text(xstartt,hstart-4 ,'Minimum value');
text(xstartn,hstart-4,[': ' sprintf(format_str,min(vv))]);
text(xstartt,hstart-5 ,'Maximum value');
text(xstartn,hstart-5,[': ' sprintf(format_str,max(vv))]);

% printing the commentlines, check existence of variables ctxti
for k=1:5
  if nargin>=k+5
    varname=['ctxt' int2str(k)];
    pl_text=eval(varname);
    len=length(pl_text);
    if len>0
      text(xstartt,hstart-6-k,pl_text(1:min(len,nchar)));
    end
  end
end

% printing date and time and number of samples
if opt>=1 & opt<=3
  disp_text='';
  if opt==1 | opt==3
    disp_text=[disp_text time_str ' '];
  end
  if opt==2 | opt==3
    disp_text=[disp_text 'n=' int2str(length(vv))];
  end
  text(xstartt,hstart-13,disp_text);
end

axis('off')
axis([0 40 0 12]); % fixed axes (for subplot(221))

% print histogram using function hist_txt.m
subplot(222)
hist_txt(vv,bins,vtxt,ttxt,0)

subplot(111)  % set subplot to normal

% ============================================================================

