close all;
clearvars;

dx = 0.001;
x=0:dx:2*pi;
y=cos(x);



%integrieren
int_y = cumsum(y*dx);
int2_y = diff(int_y)/dx;

plot(x,y, 'g')
hold on;
plot(x,int_y, 'b');
hold on;
plot(x(1:end-1),int2_y, 'r');

%y = fibonacci_fun_01(8)



