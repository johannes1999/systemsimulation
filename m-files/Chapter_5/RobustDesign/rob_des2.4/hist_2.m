function hist_2(vv1,bins1,vv2,bins2,ptype);

% HIST_2: Plot a combined histogram for two parameters (for internal usage)
% ============================================================================
% hist_2(vv1,bins1,vv2,bins2,[ptype]);
% ----------------------------------------------------------------------------
% vv1   : Parameter 1 (vector)
% bins1 : Number of bins in histogram for parameter 1
% vv2   : Parameter 2 (vector)
% bins2 : Number of bins in histogram for parameter 2
% ptype : Plot type (default=no plot)
%         0 = absolute histograms
%         1 = absolute diagram
%         2 = joint probability density histograms (Pfail + Ppass=1)
%         3 = joint probability density diagrams (Pfail + Ppass=1)
%         4 = probability density histograms (Pfail=1, Ppass=1)
%         5 = probability density diagrams (Pfail=1, Ppass=1)
%         6 = joint probability density histograms (logarithmic)
%         7 = joint probability density diagrams (logarithmic)
% ----------------------------------------------------------------------------
% Copyright: Reliability of Mech. Equipment - Eindhoven University Technology
%            Based on software originally developed by:
%             Quality Engineering - Philips Consumer Electronics
%             Reliability of Mech. Equipment - Eindhoven University Technology
%             Mech. Reliability - Philips Centre for Manufacturing Technology
% Version  : 2.4 (MATLAB 5)     Date : April 29, 1997
% ============================================================================

if nargin==4,
elseif ptype==0,

  [a1,x1]=hist(vv1,bins1);
  [a2,x2]=hist(vv2,bins2);

  % needed to shift stairs results to the right
  dx1=(x1(2)-x1(1))/2;
  dx2=(x2(2)-x2(1))/2;

  [aa1,xx1]=stairs(x1,a1);
  % add one extra point at the right hand side
  aa1(length(aa1)+1)=aa1(length(aa1))+(x1(2)-x1(1));
  xx1(length(xx1)+1)=xx1(length(xx1));

  [aa2,xx2]=stairs(x2,a2);
  % add one extra point at the right hand side
  aa2(length(aa2)+1)=aa2(length(aa2))+(x2(2)-x2(1));
  xx2(length(xx2)+1)=xx2(length(xx2));

  plot(x1+dx1,a1,'ro',aa1,xx1,'r--',x2+dx2,a2,'g+',aa2,xx2,'g-');

elseif ptype==1,

  [a1,x1]=hist(vv1,bins1);
  [a2,x2]=hist(vv2,bins2);

  plot(x1,a1,'ro',x1,a1,'r--',x2,a2,'g+',x2,a2,'g-');

elseif ptype==2,

  [a1,x1]=pdfun(vv1,bins1);
  [a2,x2]=pdfun(vv2,bins2);

  % joint scaling
  a1c=a1*length(vv1)./(length(vv1)+length(vv2));
  a2c=a2*length(vv2)./(length(vv1)+length(vv2));

  [aa1c,xx1c]=stairs(x1,a1c);
  % needed to shift stairs results to the right
  dx1=(x1(2)-x1(1))/2;
  dx2=(x2(2)-x2(1))/2;

  % add one extra point at the right hand side
  aa1c(length(aa1c)+1)=aa1c(length(aa1c))+(x1(2)-x1(1));
  xx1c(length(xx1c)+1)=xx1c(length(xx1c));

  [aa2c,xx2c]=stairs(x2,a2c);
  % add one extra point at the right hand side
  aa2c(length(aa2c)+1)=aa2c(length(aa2c))+(x2(2)-x2(1));
  xx2c(length(xx2c)+1)=xx2c(length(xx2c));

  plot(x1+dx1,a1c,'ro',aa1c,xx1c,'r--',x2+dx2,a2c,'g+',aa2c,xx2c,'g-');

elseif ptype==3,

  [a1,x1]=pdfun(vv1,bins1);
  [a2,x2]=pdfun(vv2,bins2);

  % joint scaling
  a1c=a1*length(vv1)./(length(vv1)+length(vv2));
  a2c=a2*length(vv2)./(length(vv1)+length(vv2));

  plot(x1,a1c,'ro',x1,a1c,'r--',x2,a2c,'g+',x2,a2c,'g-');

elseif ptype==4,

  [a1,x1]=pdfun(vv1,bins1);
  [a2,x2]=pdfun(vv2,bins2);

  % needed to shift stairs results to the right
  dx1=(x1(2)-x1(1))/2;
  dx2=(x2(2)-x2(1))/2;

  [aa1s,xx1s]=stairs(x1,a1);
  % add one extra point at the right hand side
  aa1s(length(aa1s)+1)=aa1s(length(aa1s))+(x1(2)-x1(1));
  xx1s(length(xx1s)+1)=xx1s(length(xx1s));

  [aa2s,xx2s]=stairs(x2,a2);
  % add one extra point at the right hand side
  aa2s(length(aa2s)+1)=aa2s(length(aa2s))+(x2(2)-x2(1));
  xx2s(length(xx2s)+1)=xx2s(length(xx2s));

  plot(x1+dx1,a1,'ro',aa1s,xx1s,'r--',x2+dx2,a2,'g+',aa2s,xx2s,'g-');

elseif ptype==5,

  [a1,x1]=pdfun(vv1,bins1);
  [a2,x2]=pdfun(vv2,bins2);

  plot(x1,a1,'ro',x1,a1,'r--',x2,a2,'g+',x2,a2,'g-');

elseif ptype==6,

  [a1,x1]=pdfun(vv1,bins1);
  [a2,x2]=pdfun(vv2,bins2);

  % needed to shift stairs results to the right
  dx1=(x1(2)-x1(1))/2;
  dx2=(x2(2)-x2(1))/2;

  % joint scaling
  a1c=a1*length(vv1)./(length(vv1)+length(vv2));
  a2c=a2*length(vv2)./(length(vv1)+length(vv2));

  [aa1c,xx1c]=stairs(x1,a1c);
  % add one extra point at the right hand side
  aa1c(length(aa1c)+1)=aa1c(length(aa1c))+(x1(2)-x1(1));
  xx1c(length(xx1c)+1)=xx1c(length(xx1c));

  [aa2c,xx2c]=stairs(x2,a2c);
  % add one extra point at the right hand side
  aa2c(length(aa2c)+1)=aa2c(length(aa2c))+(x2(2)-x2(1));
  xx2c(length(xx2c)+1)=xx2c(length(xx2c));

  semilogy(x1+dx1,a1c,'ro',aa1c,xx1c,'r--',x2+dx2,a2c,'g+',aa2c,xx2c,'g-');

elseif ptype==7,

  [a1,x1]=pdfun(vv1,bins1);
  [a2,x2]=pdfun(vv2,bins2);

  % joint scaling
  a1c=a1*length(vv1)./(length(vv1)+length(vv2));
  a2c=a2*length(vv2)./(length(vv1)+length(vv2));

  semilogy(x1,a1c,'ro',x1,a1c,'r--',x2,a2c,'g+',x2,a2c,'g-');

end

% ============================================================================

