function [el,cog,ind] = pfpareto(yy,ytxt,lsl,usl,ttxt,sort_opt,opt,...
                  x1, tx1, x2, tx2, x3, tx3, x4, tx4, x5, tx5, ...
                  x6, tx6, x7, tx7, x8, tx8, x9, tx9, x10,tx10,...
                  x11,tx11,x12,tx12,x13,tx13,x14,tx14,x15,tx15,...
                  x16,tx16,x17,tx17,x18,tx18,x19,tx19,x20,tx20)

% PFPARETO: Calculate and plot a Pareto diagram of statistical sensitivities
% ============================================================================
% [el,cog,ind] = pfpareto(yy,[ytxt],[lsl],[usl],[ttxt],[sort_opt],[opt],...
%                x1,tx1,...,x20,tx20)
% ----------------------------------------------------------------------------
% el     : calculated statistical sensitivities sorted according to sort_opt
% cog    : calculated centre of gravity sorted according to sort_opt
% ind    : index into matrix x and tx sorted according to sort_opt
%
% yy     : Output variable (vector)
% ytxt   : Description of the output variable yy (text)
% lsl    : Lower specification limit
% usl    : Upper specification limit
% ttxt   : Title at the top of the plot (text)
% sort_opt: Sort option (default=0)
%          0 = do not sort the sensitivity results
%          1 = sort the sensitivity results (largest at the top)
%          >1= sort, but show only the 'sort_opt' most important
% opt    : Options
%          opt(1): Added text at the end of the title (default=1)
%          0 = none
%          1 = date & time
%          opt(2): Display centre of gravity results (default=1)
%          0 = no display
%          1 = display if lsl or usl or both are specified
%          2 = display always
%          opt(3): Position of parameter description, possible values 1,2,3,4
%          Room for about 10*opt(3) characters (full screen) (default=1)
%          opt(4): Displaying text no limits, no passes, no fails (default=1)
%          0 = no display
%          1 = display
% x1     : Input parameter 1 (vector)
% tx1    : Description of parameter 1 (text)
% ...
% x20    : Input parameter 20 (vector)
% tx20   : Description of parameter 20 (text)
% If the first character of a tx parameter is a # the corresponding bar
% in the diagram will be filled in the background colour (used to
% distinguish between designable and non-designable parameters)
%
% This function accepts multiple output matrix variables. For more
% details see reference manual.
% ----------------------------------------------------------------------------
% Example: pfpareto(yy,'yname',[],[],'Pareto stat. sensitivities',1, ...
%                   [1,1,1,1],x1,'x1name',x2,'#x2name',x3,'x3name');
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.4.1 (MATLAB 5)     Date : July 10, 1997
% ============================================================================

global pf_;
global check_limit_;

% Settings for positions of text used by opt(3)
% first row of settings  : x position for tx;
% second row of settings : x coordinate for axis;
settings=[-0.35,-0.85,-1.5,-2.4;-0.05,-0.5,-1.1,-1.8];

% check input
if length(sort_opt)==0
  sort_opt=0;
end

% check size of opt, in case of error use default setting 1
% if opt is not complete, fill remaining part with 1
% length_opt is number of elements of option that are used
length_opt=4;
size_opt=size(opt);
if min(size_opt)>1
  opt=ones(1, length_opt);
elseif max(size_opt)<length_opt
  if size_opt(1)==1
    opt=[opt, ones(1,length_opt-max(size_opt))];
  else
    opt=[opt; ones(length_opt-max(size_opt),1)];
  end
end

% limit opt(3) between 1 and 4
opt(3)=min(round(opt(3)),4); opt(3)=max(opt(3),1);

npar=(nargin-7);
if (round(npar/2)*2)==npar
  npar=npar/2;
  elvect=zeros(npar,1);
  cogvect=zeros(npar,1);
  for k=1:npar
    [elvect(k), cogvect(k)]=passfail(eval(['x' int2str(k)]),yy,lsl,usl);
  end

  if sort_opt>0
    [elvect_sort, index_sort]=sort(elvect);
    if sort_opt>1
      start_plot=max(1, npar-sort_opt+1);    % show sort_opt most important
      nplot=min(npar, sort_opt);
      end_plot=start_plot+nplot-1;
    else
      start_plot=1;     % show all
      nplot=npar;
      end_plot=npar;
    end
  else
    index_sort=1:npar;  % do not sort
    start_plot=1;       % show all
    nplot=npar;
    end_plot=npar;
  end

  [xxb,yyb]=bar_v4(1:nplot,elvect(index_sort(start_plot:end_plot),1));

  fighandle=gcf;    % get handle for current figure
  % get for the current figure the value for option Color (=backgroundcolor)
  backcol=get(fighandle, 'Color');
  if norm(backcol)>=0.87
    plcolor1='k';   % used for axis, grid
    plcolor2='c';   % used for bars
    plcolor3='w';   % used for bars #
  else
    plcolor1='w';   % used for axis, grid
    plcolor2='y';   % used for bars
    plcolor3='k';   % used for bars #
  end

  % plot grid
  line_type=[plcolor1 ':'];
  plot([0.5 0.5],[0.5 nplot+0.5],line_type,...
       [1.0 1.0],[0.5 nplot+0.5],line_type,...
       [1.5 1.5],[0.5 nplot+0.5],line_type);

  hold_state=ishold;
  hold on;

  % fill bars, plot text tx
  x_text=settings(1,opt(3));
  for k=1:nplot
    pl_index=5*(k-1)+2:5*(k-1)+5;
    var_name=['tx' int2str(index_sort(start_plot+k-1))];
    pl_text=eval(var_name);
    barcolor=plcolor2;
    if length(pl_text)>0
      % fill is in both branches of if statement because text must be printed on
      % top of filling
      if pl_text(1)~='#'    % designable
        fill(yyb(pl_index),xxb(pl_index),barcolor,'EdgeColor',plcolor2);
        text(x_text,k, pl_text);
      else                  % non designable
        barcolor=plcolor3;
        fill(yyb(pl_index),xxb(pl_index),barcolor,'EdgeColor',plcolor2);
        text(x_text,k, pl_text(2:length(pl_text)));
      end
    end
  end

  % plot axis
  line_type=[plcolor1 '-'];
  plot([0 2.05 2.05 0 0],[0.5 0.5 nplot+0.5 nplot+0.5 0.5],line_type);

  % for nplot=20 vertical position 0.0, for nplot=2 position 0.45
  yt=0.5-nplot/40;
  text(0,yt,'0 Low');
  text(0.5,yt,'0.5 Medium');
  text(1,yt,'1 High');
  text(1.5,yt,'1.5 Dominant');

  axis off
  x_axis=settings(2,opt(3));
  if opt(2)==0 || (opt(2)==1 && length(lsl)==0 && length(usl)==0)
    axis([x_axis 2.05 0+0.5 nplot+0.5]);
  else
    % plot modify part
    % for nplot=20 vertical position 21, for nplot=2 position 2.55
    text(2.1,nplot+0.5+nplot/40,'Modify');
    for k=1:nplot
      text(2.1,k,sprintf('%-6.2G',cogvect(index_sort(start_plot+k-1))));
    end
    axis([x_axis 2.3 0+0.5 nplot+0.5]);
  end

  if opt(4)==1
    if pf_==1
      ftxt='(No Passes) ';
    elseif pf_==-1
      ftxt='(No Failures) ';
    else
      ftxt='';
    end

    if check_limit_==3
      ftxt='(No Limits) ';
    end
    xlabel(['Statistical sensitivity ',ftxt,ytxt]);
    set(get(gca,'XLabel'),'Visible','on') % needed in MATLAB 4.2
  else
    xlabel(['Statistical sensitivity ',ytxt]);
    set(get(gca,'XLabel'),'Visible','on') % needed in MATLAB 4.2
  end

  if opt(1)==1   % append date and time using function time_str
    ttxt=[ttxt ' ' time_str];
  end
  if length(ttxt)>0
    title(ttxt);
    % The next line is needed because otherwise the title is plotted
    % on white on a white background
    set(get(gca,'title'),'color',plcolor1);
  end

  if hold_state==0
    hold off;
  end

  % return output parameters
  if nargout>0
    el=elvect(index_sort(end_plot:-1:start_plot));
  end
  if nargout>1
    cog=cogvect(index_sort(end_plot:-1:start_plot));
  end
  if nargout>2
    ind=index_sort(end_plot:-1:start_plot);
  end

  figure(fighandle);        % show result
else
  error('Number of x parameters does not equal number of tx parameters');
end

% ============================================================================

