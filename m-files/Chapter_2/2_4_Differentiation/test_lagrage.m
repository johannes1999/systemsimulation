clearvars

xi=linspace(0,6,5);

yi=sin(xi);%xi.*exp(xi)./(log(1+xi)+sqrt(xi)).^(1/3);
x=linspace(-0.5,8,100);
y=lagrange(x,xi,yi);
p=polyfit(xi,yi,length(xi));
y_p=polyval(p,x);
figure
plot(xi,yi,'+',x,y,'b',x,y_p,'r-.')
ylim([-2,2])