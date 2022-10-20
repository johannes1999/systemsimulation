function [el,cog]=passfail(xx,yy,lsl,usl,ptype,xtxt,ytxt,ttxt,opt,pl_index)

% PASSFAIL: Calculate statistical sensitivity of input x to output y
% ============================================================================
% [el,cog]=passfail(xx,yy,[lsl],[usl],[ptype],[xtxt],[ytxt],[ttxt], ...
%                   [opt],[pl_index])
% ----------------------------------------------------------------------------
% el   : statistical sensitivity
% cog  : centre of gravity
% xx   : Input parameter (vector)
% yy   : Output variable (vector)
% lsl  : Lower specification limit (scalar/vector)
% usl  : Upper specification limit (scalar/vector)
% ptype: Plot option (default=0)
%        0 = no plot
%        1 = Pass/Fail histograms
%        2 = Pass/Fail diagrams
%        3 = Pass/Fail diagrams and scatterplot
%        4 = Pass/Fail scatterplots
%        5 = Pass/Fail diagrams (logarithmic)
% xtxt : Description for input parameter xx (text)
% ytxt : Description for output variable yy (text)
% ttxt : Title at the top of the plot (text)
% opt  : Option for added text at the end of the title (default=1)
%        0 = none
%        1 = date & time
% pl_index: index numbers for scatterplots (default=1)
%
% This function accepts multiple output matrix variables. For more
% details see reference manual.
% ----------------------------------------------------------------------------
% Example: [el,cog]=passfail(xx,yy,[],[],3,'xname','yname','title',1);
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.3 (MATLAB 4)     Date : January 11, 1996
% ============================================================================

global pf_;
global check_limit_;

% check input
% Determine number of output functions (ny) and length (nsize)
[ny nsize]=size(yy);

% check size of yy
if nsize==1
  error('yy must be a row vector or a matrix with number of samples columns')
end

if nargin<5,
  ptype=0;
elseif length(ptype)==0,
  ptype=0;
end

if nargin<6,
  xtxt='';
elseif length(xtxt)==0
  xtxt='';
end

% ytxt_opt=0: no y label in plots
% ytxt_opt=1: only index numbers
% ytxt_opt=2: one ytext, index numbers appended
% ytxt_opt=3: ytxt as specified in matrix
if nargin<7
  % ytxt not specified
  if ny>1
    ytxt_opt=1;
    eytxt='';
  else
    ytxt_opt=0;
  end
else
  % ytxt specified
  [nrowyt ncolyt]=size(ytxt);   % get size of matrix ytxt
  if ny==1
    if nrowyt==1
      ytxt_opt=3;
      eytxt=ytxt;
    else
      ytxt_opt=0;
    end
  else
    if nrowyt==1
      % one y text specified, index number appended
      ytxt_opt=2;
      eytxt=ytxt;
    elseif nrowyt~=ny | nrowyt==0
      % only index numbers
      ytxt_opt=1;
      eytxt='';
    else
      % matrix used
      ytxt_opt=3;
      eytxt=ytxt;
    end
  end
end

if nargin<8,
  ttxt='';
elseif length(ttxt)==0
  ttxt='';
end

if nargin<9
  opt=1;
elseif length(opt)==0
  opt=1;
end

if nargin<10
  pl_index=1:ny;
elseif length(pl_index)==0
  pl_index=1:ny;
elseif any(pl_index<1) | any(pl_index>ny)
  message('passfail', ...
          ['One or more elements of pl_index out of range.\n' ...
           'Default value is used.']);
  pl_index=1:ny;
end

% check for constant xx
% if xx is constant el=0 and cog=0 and no plots are made
if all(xx==xx(1)),
  el=0.0;
  cog=0.0;
  break;
end

% Set default values for acceptance limits
% if lsl and usl: check_limit_=0;
% if no lsl: check_limit_=1;
% if no usl: check_limit_=2;
% if no lsl and no usl: check_limit_=3;
check_limit_=0;
if nargin<3,
  lsl=-inf*ones(ny,1);            % lsl=min(yy')'; old version
  check_limit_=1;
elseif length(lsl)==0,
  lsl=-inf*ones(ny,1);            % lsl=min(yy')'; old version
  check_limit_=1;
end
if nargin<4,
  usl=inf*ones(ny,1);             % usl=max(yy')'+1; old version
  check_limit_=check_limit_+2;
elseif length(usl)==0,
  usl=inf*ones(ny,1);             % usl=max(yy')'+1; old version
  check_limit_=check_limit_+2;
end

% Check number and size acceptance limits
[n1 n2]=size(lsl);
if n1~=ny, error('Number of lower limits lsl not correct'); end
if n2~=1 & n2~=nsize, error('Length of lower limit lsl not correct'); end
[n1 n2]=size(usl);
if n1~=ny, error('Number of upper limits usl not correct'); end
if n2~=1 & n2~=nsize, error('Length of upper limit usl not correct'); end

% check for constant output variables
for iy=1:ny
  if all(yy(iy,:)==yy(iy,1)),
    error(['Parameter yy(' int2str(iy) ',:) constant']);
  end
end

% Interpret NaN to skip output functions without lower or upper limit
index=find(isnan(lsl));
if length(index)>0, lsl(index)=-inf*ones(size(index)); end
index=find(isnan(usl));
if length(index)>0, usl(index)=inf*ones(size(index)); end

% ----------------------------------------------------------------------------

% Create text strings for a combined find (pass/fail) on all output functions
for iy=1:ny
   yptxt=sprintf('(yy(%d,:)>=lsl(%d,:))&(yy(%d,:)<=usl(%d,:))',iy,iy,iy,iy);
   yftxt=sprintf('(yy(%d,:)< lsl(%d,:))|(yy(%d,:)> usl(%d,:))',iy,iy,iy,iy);
   if iy==1
      ptxt=yptxt;
      ftxt=yftxt;
   else
      ptxt=[ptxt '&' yptxt];
      ftxt=[ftxt '|' yftxt];
   end
end

% ----------------------------------------------------------------------------

% Find output within all limits (pass), outside any limit (fail)
ypass=eval(['find(' ptxt ')']);
yfail=eval(['find(' ftxt ')']);

% Check for situations where only passes or fails exist
if length(ypass)==0,
  pf_=1;
  usl=mean(yy')';
  lsl=-inf*ones(ny,1);                % lsl=min(yy')'; old version
  ypass=eval(['find(' ptxt ')']);
  yfail=eval(['find(' ftxt ')']);
elseif length(yfail)==0,
  pf_=-1;
  usl=mean(yy')';
  lsl=-inf*ones(ny,1);                % lsl=min(yy')'; old version
  ypass=eval(['find(' ptxt ')']);
  yfail=eval(['find(' ftxt ')']);
else
  pf_=0;
end

nbins=max(4,sqrt(nsize));             % calculate number of bins
% nbins=max(4,nsize/25);                % calculate number of bins (old)
dx=(max(xx)-min(xx))/nbins;           % calculate delta for bin width
xbin=min(xx):dx:max(xx);              % calculate bin set

% Calculate pass and fail histograms
[hxpass,i]=hist(xx(ypass),xbin);      % calculate histogram/distr. passes
[hxfail,i]=hist(xx(yfail),xbin);      % calculate histogram/distr. fails

% Calculate Elias coefficient
el=sum(abs(hxpass./length(ypass)-hxfail./length(yfail)));

% In case of high Elias coefficient: increase step accuracy
if (el>1) & (pf_==0) & (sum(hxpass)>50),
  passlarger=find(hxpass>hxfail);
  llim=passlarger(1);
  hlim=max(passlarger);
  if llim==1,
    crosslow=xbin(1);
  else      % estimate lower crossing pass-fail diagram
    crosslow=(xbin(llim-1).*(hxpass(llim)-hxfail(llim))+...
                   xbin(llim).*(hxfail(llim-1)-hxpass(llim-1)));
    crosslow=crosslow./(hxpass(llim)-hxfail(llim)+...
                   hxfail(llim-1)-hxpass(llim-1));
  end
  if hlim==max(size(hxpass));
    crosshigh=xbin(hlim);
  else      % estimate upper crossing pass-fail diagram
    crosshigh=(xbin(hlim).*(hxpass(hlim+1)-hxfail(hlim+1))+...
                   xbin(hlim+1).*(hxfail(hlim)-hxpass(hlim)));
    crosshigh=crosshigh./(hxpass(hlim+1)-hxfail(hlim+1)+...
                   hxfail(hlim)-hxpass(hlim));
  end
  binsize=(crosshigh-crosslow)/(hlim-llim);
  dbin=crosslow-(floor(crosslow/binsize)*binsize);
  xmin=floor(min(xx)/binsize)*binsize;
  xmax=ceil(max(xx)/binsize)*binsize;
  xbin=xmin+dbin-0.5*binsize:binsize:xmax+dbin;

  % Re-calculate pass and fail histograms
  [hxpass,i]=hist(xx(ypass),xbin);  % calculate histogram/distr. passes
  [hxfail,i]=hist(xx(yfail),xbin);  % calculate histogram/distr. fails

  % Re-calculate Elias coefficient
  el=sum(abs(hxpass./length(ypass)-hxfail./length(yfail)));
end

% Calculate Centre of Gravity
cog=mean(xx(ypass))-mean(xx(yfail));

% ----------------------------------------------------------------------------

% if no plot parameter defined or value is 0: do not plot
if ptype==0 | ptype > 5,
else
  clf

  if pf_==1
    ftxt='(No Passes)';
  elseif pf_==-1
    ftxt='(No Failures)';
  else
    ftxt='';
  end

  if check_limit_==3
    ftxt='(No Limits)';
  end

  if length(xtxt)>0
    xtext=['Statistical sensitivity for ' xtxt ' ' ftxt ': ' sprintf('%3.2f',el)];
  else
    xtext=['Statistical sensitivity ' ftxt ': ' sprintf('%3.2f',el)];
  end
  if cog>0,
    xtext=[xtext '  Increase: ' sprintf('%-6.2G',cog)];
  else
    xtext=[xtext '  Decrease: ' sprintf('%-6.2G',-cog)];
  end

  if opt==1     % append time and date ?
    ttxt=[ttxt ' ' time_str];
  end
  if ptype==1   % Histograms ?
    hist_2(xx(yfail),xbin,xx(ypass),xbin,4);  % dual stairs histogram
    xlabel(xtext);
    ylabel('pdf passes/fails')
    title(ttxt);
  elseif ptype==2   % Diagrams ?
    hist_2(xx(yfail),xbin,xx(ypass),xbin,5);  % dual line histogram
    xlabel(xtext);
    ylabel('pdf passes/fails')
    title(ttxt);
  elseif ptype==3 | ptype==4   % Diagram with scatterplots or scatterplots ?
    Limit_LineType=str2mat('b--','b:');  % linetype fixed/distributed limits
    npl=length(pl_index);
    hold_state=ishold;
    % calculate number of columns/rows for subplot
    if ptype==3,
      nplc=npl; nplr=2; % 1 row, npl columns scatterplots, 1 row diagram
    else
      nplc=ceil(sqrt(npl)); nplr=ceil(npl/nplc);
    end
    % calculate minimum and maximum xx values for usage in axis command
    minxx=min(xx); maxxx=max(xx);
    % plot scatterplots
    for kpl=1:npl
      subplot(nplr,nplc,kpl)
      ipl=pl_index(kpl);
      plot(xx(yfail),yy(ipl,yfail),'ro',xx(ypass),yy(ipl,ypass),'g+')
      % calculate minimum and maximum yy values for usage in axis command
      minyp=min(yy(ipl,:)); maxyp=max(yy(ipl,:));
      % next lines are needed to plot lsl, usl
      hold on
      pl_lsl=mean(lsl(ipl,:));
      pl_usl=mean(usl(ipl,:));
      if finite(pl_lsl)
        plot([minxx maxxx],[pl_lsl pl_lsl], ...
              Limit_LineType(any(lsl(ipl,:)~=lsl(ipl,1))+1,:))
      end
      if finite(pl_usl)
        plot([minxx maxxx],[pl_usl pl_usl], ...
               Limit_LineType(any(usl(ipl,:)~=usl(ipl,1))+1,:))
      end
      axis([minxx,maxxx,minyp,maxyp]);
      hold off
      xlabel(xtxt)
      if ytxt_opt>0
        if ytxt_opt==3
          % ytxt specified as matrix
          ylabel(eytxt(ipl,:));
        else
          % ytxt is not specified or one ytxt, ytxt+indexnumbers
          ylabel([eytxt int2str(ipl)]);
        end
      end
    end
    if hold_state==0, hold off; else hold on; end
    if ptype==3       % scatterplot & diagram ?
      % plot diagram
      subplot(2,1,2)
      hist_2(xx(yfail),xbin,xx(ypass),xbin,5);
      v=axis;
      axis([minxx,maxxx,v(3),v(4)]);
      ylabel('pdf passes/fails')
      xlabel(xtext);
    end
    % the following lines are a difficult way to get the title on top
    % Warning. function title in Matlab4.0 differs from that in Matlab4.2
    tcol=get(gcf,'defaulttextcolor'); % necessary in order to set text color
    set(axes,'Visible','off');        % generate new axes, set invisible
    title(ttxt);                      % set title for the new axes
    set(get(gca,'title'),'Visible','On','Color',tcol); % set title properties
  elseif ptype==5   % Logarithmic density functions ?
    hist_2(xx(yfail),xbin,xx(ypass),xbin,6);  % dual histogram
    xlabel(xtext);
    ylabel('pdf passes/fails')
    title(ttxt);
  end
  figure(gcf); % show result
end

% ============================================================================

