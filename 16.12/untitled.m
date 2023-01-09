close all;  % Alle plots schliessen
clearvars;  % workspace löschen

a=3;
b=2;
c=1;
Nx=40;
Ny=40;

x_axis = linspace(-a,a,40);
y_axis = linspace(-b,b,40);

[x, y] = meshgrid(x_axis, x_axis);

%z=sqrt((c^2*(1-(x/a)^2)-(y/b).^2));
%z(image(z)~=0)=NaN;
        r = sqrt(x.^2 +y.^2);
        z = sin(r)./r;
        z(6:10,6:36)=NaN;

figure;
surf(x,y,z,'FaceAlpha',0.8);
hold
surf(x,y,-z,'FaceAlpha',0.8);
xlabel('x'); ylabel('y');zlabel('z');