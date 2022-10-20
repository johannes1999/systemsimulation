function rparetm(yy,ytxt,ttxt,sort_opt,opt,x,tx,index)

% RPARETM: Generate Pareto diagram of response surface coef. (matrix version)
% ============================================================================
% rparetm(yy,[ytxt],[ttxt],[sort_opt],[opt],x,[tx],[index]);
% ----------------------------------------------------------------------------
% yy     : Output variable (vector)
% ytxt   : Description of the output variable yy (text)
% ttxt   : Title at the top of the plot (text)
% sort_opt: Sort option (default=0)
%          0 = do not sort the sensitivity results
%          1 = sort the sensitivity results (largest at the top)
%          >1= sort, but show only the 'sort_opt' most important
% opt    : Options
%          opt(1): Added text at the end of the title (default=1)
%          0 = none
%          1 = date & time
%          opt(2): Displaying regression coefficient (default=1)
%          0 = no display
%          1 = display
%          opt(3): Position of parameter description, possible values 1,2,3,4
%          Room for about 10*opt(3) characters (full screen) (default=1)
% x      : Input parameters (matrix: 1 row is 1 variable)
% tx     : Descriptions of the input parameters (matrix: 1 row is 1 descr.)
%          If tx is only one string, the number of the input parameter will
%          be appended to this string (default: display index number matrix).
%          If the first character behind the first quote of
%          a tx parameter is a #, the corresponding bar in the diagram
%          will be filled in the background colour (used to distinguish
%          between designable and non-designable parameters)
% index  : Index to define the input parameters for which the sensitivity
%          is calculated (vector, default=use all parameters)
%
% ----------------------------------------------------------------------------
% Example: rparetm(yy,'yname','Pareto resp.surf.',...
%                   1,[1,1,1],x,str2mat('l','b','h','x','E'),[1:3 5]);
% ----------------------------------------------------------------------------
% Copyright: Philips - CFT, Development Support        Version: 1.2e(29/04/1997)
% ============================================================================

% Settings for positions of text used by opt(3)
% first row of settings  : x position for tx;
% second row of settings : x coordinate for axis;
settings=[-0.35,-0.85,-1.5,-2.4;-0.05,-0.5,-1.1,-1.8]-1;

[nrow ncol]=size(x);      % get size of matrix x

if all(yy==yy(1))
  message('rparetm','parameter yy constant')
end

% if index not specified check all rows
if nargin<8
  index=1:nrow;
elseif length(index)<1 | length(index)>nrow
  index=1:nrow;
elseif any(index<1) | any(index>nrow)
  message('rparetm', ...
          ['One or more elements of index out of range.\n' ...
           'Default value is used.']);
  index=1:nrow;
end

% if no or empty or too short tx: only index numbers as text.
txt_opt=0;
if nargin<7
  % no text specified, index numbers as text.
  txt_opt=1;
  etxt='';
else
  [nrowt ncolt]=size(tx);   % get size of matrix tx
% *** Modification to extend check, original line:
%  if nrowt==1
% ***
  if nrowt~=nrow & nrowt==1
    % one text specified, will be extended with index number
    txt_opt=2;
    etxt=tx;
  elseif nrowt~=nrow | nrowt==0
    % number of rows text not equal number of rows matrix, only index numbers
    txt_opt=1;
    etxt='';
  end
end

% default no sorting
if length(sort_opt)==0,
  sort_opt=0;
end

% check size of opt, in case of error use default setting 1
% if opt is not complete, fill remaining part with 1
% length_opt is number of elements of option that are used
length_opt=3;
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

npar=length(index);
cvect=zeros(npar,4);
for k=1:npar,
  [cvect(k,1),cvect(k,2),cvect(k,3),cvect(k,4)]= ...
                      correlat(x(index(k),:),yy);
end

% *** Modification: Combine all parameters to find best linear model ***
% **********************************************************************
c=[ones(1,max(size(yy)));x]'\yy';
cvect(:,4)=c(2:length(c));
% **********************************************************************

if sort_opt>0,
  % because the correlation coefficient is NaN if yy or xx is a constant
  % vector, and because these values are sorted on top, the
  % values that are equal to NaN are set to 0 before sorting and
  % set back to NaN after sorting
  nan_index=find(isnan(cvect(:,1)));
  if length(nan_index)>0
    cvect(nan_index,1)=zeros(size(nan_index));
  end
  [cvect_sort index_sort]=sort(abs(cvect(:,1)));
  if length(nan_index)>0
    cvect(nan_index,1)=NaN*ones(size(nan_index));
  end

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

[xxb,yyb]=bar_v4(1:nplot,cvect(index_sort(start_plot:end_plot),1));

fighandle=gcf;    % get handle for current figure
% get for the current figure the value for option Color (=backgroundcolor)
backcol=get(fighandle, 'Color');
if norm(backcol)>=0.87
  plcolor1='k';   % used for axis, grid
  plcolor2='c';   % used for bars
  plcolor3='w';   % used for bars #
  plcolor4='r';   % used for bars confidence intervals
else
  plcolor1='w';   % used for axis, grid
  plcolor2='y';   % used for bars
  plcolor3='k';   % used for bars #
  plcolor4='r';   % used for bars confidence intervals
end

% plot grid
line_type=[plcolor1 ':'];
plot([-0.5 -0.5],[0.5 nplot+0.5],line_type,...
     [0.0 0.0],[0.5 nplot+0.5],line_type,...
     [0.5 0.5],[0.5 nplot+0.5],line_type);

hold_state=ishold;
hold on;

% fill bars, plot text tx
x_text=settings(1,opt(3));
for k=1:nplot
  pl_index=5*(k-1)+2:5*(k-1)+5;

  if txt_opt==0
    % tx specified as matrix
    pl_text=tx(index(index_sort(start_plot+k-1)),:);
  else
    % tx is not specified or one tx, tx (if existing)+indexnumbers
    pl_text=[etxt int2str(index(index_sort(start_plot+k-1)))];
  end

  % calculate postition confidence interval and plot
  cor=cvect(index_sort(start_plot+k-1),:);
  conf_int_x=[cor(2), cor(3), cor(3), cor(2), cor(2)];
  
  % initialisation of help variable to avoid plotting of value NaN
  noplot=0;
  if isnan(cor(1))
    noplot=1;
  else
    conf_dy=0.2;     % half bar height/2
    conf_int_y=[xxb(pl_index(1))+conf_dy; xxb(pl_index(2))+conf_dy; ...
                xxb(pl_index(3))-conf_dy; xxb(pl_index(4))-conf_dy; ...
                xxb(pl_index(1))+conf_dy];
  end

  barcolor=plcolor2;
  if length(pl_text)>0
    if pl_text(1)~='#'    % designable
      if noplot==0
        fill(yyb(pl_index),xxb(pl_index),barcolor,'EdgeColor',plcolor2);
        confbar_color=plcolor4;
        fill(conf_int_x, conf_int_y, confbar_color,'EdgeColor',plcolor4)
      end
      text(x_text,k, pl_text);
    else                  % non designable
      if noplot==0
        barcolor=plcolor3;
        fill(yyb(pl_index),xxb(pl_index),barcolor,'EdgeColor',plcolor2);
        confbar_color=plcolor3;
        fill(conf_int_x, conf_int_y, confbar_color,'EdgeColor',plcolor4)
      end
      text(x_text,k, pl_text(2:length(pl_text)));
    end
  end
  if opt(2)==1 
    text(1.05,k,sprintf('%6.3G',cor(4))); % print Response Surface coefficient
  end
end

% plot axis
line_type=[plcolor1 '-'];
plot([-1 1 1 -1 -1],[0.5 0.5 nplot+0.5 nplot+0.5 0.5],line_type);

% for nplot=20 vertical position 0.0, for nplot=2 postion 0.45
yt=0.5-nplot/40;
text(-1.0,yt,'-1.0','HorizontalAlignment','center');
text(-0.5,yt,'-0.5','HorizontalAlignment','center');
text(0   ,yt,'0'   ,'HorizontalAlignment','center');
text(0.5 ,yt,'0.5' ,'HorizontalAlignment','center');
text(1.0 ,yt,'1.0' ,'HorizontalAlignment','center');

if opt(2)==1     % printing Response Surface coefficient
  text(1.05,nplot+0.5+nplot/40,'Resp.Surf.coef.');
end

axis off
x_axis=settings(2,opt(3));
if opt(2)==1
  % axis x-value 1.3 because of text at right hand side
  axis([x_axis 1.3 0+0.5 nplot+0.5]);
else
  % no printing regression coefficient
  axis([x_axis 1.05 0+0.5 nplot+0.5]);
end

xlabel(['Correlation coefficient ' ytxt]);
set(get(gca,'XLabel'),'Visible','on') % needed in MATLAB 4.2

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

figure(fighandle) % show result

% ============================================================================

