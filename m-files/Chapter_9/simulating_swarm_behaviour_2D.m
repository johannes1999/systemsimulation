%Simulating swarm/flock behaviour 2D

%%
close all;
clear;

N=5;                    % number of elements
delta=0.1;              % time steps
T=50;                   % time

X=20;                   % size of the spread
V=5;

x=X*randn(2,N);         %initial position
v=V*randn(2,N);         %velocity

c1=5;                 %quantifier
c2=0.25;
c3=5;


a1=zeros(2,N);
a2=zeros(2,N);
a3=zeros(2,N);

plot(x(1,:),x(2,:),'k+','Markersize',5);
axis('equal')
xlim (5*[-100, 100])
ylim(5*[-100, 100])
grid on

%%

for t=0:delta:T

for n=1:N
    for m=1:N
        if m~=n
            r=x(:,m)-x(:,n);                            %Abstandsvektor
            vr=v(:,m)-v(:,n);                           %relative Geschwindigkeit
            rmag=sqrt(r(1,1)^2+2+r(2,1)^2);             %Länge des Abstandsvektors
            
            a1(:,n)=a1(:,n)-c1*r/rmag^2;                %Separation
            a2(:,n)=a2(:,n)+c2*r;                       %Cohesion
            a3(:,n)=a3(:,n)+c3*vr;                      %Alignment
        end
    end
end

a=a1+a2+a3;

v_new=v+a*delta;
x_new=x+v_new*delta;
v=v_new;
x=x_new;

plot(x(1,:),x(2,:),'k+','Markersize',5);
axis('equal')
xlim([-100 100])
ylim([-100 100])
grid on
drawnow;
%pause(0.5);
end