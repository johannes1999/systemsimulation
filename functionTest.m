%Lösung einer Quadratischen Gleichung
%[x1, x2]=functionTest(a,b,c)

function [x1, x2]=functionTest(a,b,c)

%a=2;
%b=4;
%c=3;

D = sqrt(b^2-4*a*c);

x1=(-b-D)/(2*a);
x2=(-b+D)/(2*a);

end