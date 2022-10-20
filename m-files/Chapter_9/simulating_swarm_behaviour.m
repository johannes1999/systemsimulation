%Simulating swarm/flock behaviour

%%
clc;
clear;

N=400;                  %number of elements
T=10;                   %time step

X=5;                    %size of the spread
V=5;

x=X*randn(3,N);         %initial position
v=V*randn(3,N);         %velocity

c1=0.3;                 %quantifier
c2=3;
c3=5;


a1=zeros(3,N);
a2=zeros(3,N);
a3=zeros(3,N);

plot3(x(1,:),x(2,:),x(3,:),'k+','Markersize',.5);
xlim manual
ylim manual
zlim manual

xlim([-10 10])
ylim([-10 10])
zlim([-10 10])
axis equal
grid on
drawnow;

%%

for delta=0:.5:T

for n=1:N
    for m=1:N
        if m~=n
            r=x(:,m)-x(:,n);                            %Abstandsvektor
            vr=v(:,m)-v(:,n);                           %relative Geschwindigkeit
            rmag=sqrt(r(1,1)^2+2+r(2,1)^2+r(3,1)^2);    %Länge des Abstandsvektors
            
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

plot3(x(1,:),x(2,:),x(3,:),'k+','Markersize',.5);
xlim([-10 10])
ylim([-10 10])
zlim([-10 10])
axis equal
drawnow;

end