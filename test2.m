clc
clearvars
x=0:0.01:2*pi;
y=sin(x);
y2=cos(x);
y3=exp(-x).*y; %e^(-x)*sin(x)
figure
subplot(2,1,1)
plot(x,y,'b',x,y2,'r')
grid
xlabel('t [s]')
ylabel('y [-]')
title('sin cos')
subplot(2,1,2)
plot(x,y,'b',x,y3,'r')
grid
xlabel('t [s]')
ylabel('y [-]')
title('sin e^(-x)*sin')