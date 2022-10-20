% test_LP_DGL_Dirichlet enthält Beispiele für die Berechnung der Laplace  
% Gleichung mit Dirichlet Randwert Problem  mit dem Differenzen-Verfahren.
% 
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%           Die Beispiel 1 und 3 wurden dem Skript Numerische Lösung 
%           partieller Differentialgleichungen; Klaus Betzler; 
%           Uni Osnabrueck entnommen.
%           
% Datum:    2017-07-01
%
% Änderung: 2019-06_07 Kommentare zugefügt
%
% siehe auch: Kanal_Plot.m
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen. 

Fall=3;     % 1: Beispiel Wärmeverteilung (siehe Klaus Betzler Uni Osnabrueck)
            % 2: Potentialverteilung auf rechteckigem Kanal
            % 3: Berechnung einer Dreielektrodenanordnung 

if Fall==1
%% 1: Beispiel Wärmeverteilung
%=============================

% Exakte Lösung als Vergleichswerte
%----------------------------------
    a=20;
    b=20;
    Nx=20;
    X=linspace(0,a,Nx);
    Y=linspace(0,b,Nx);
    [x, y]=meshgrid(X,Y);
    T_exakt=zeros(size(x));
    for n=1:2:7
        T_exakt=T_exakt+1/n^3*sinh(n*pi*y/a)./sinh(n*pi*b/a).*sin(n*pi*x/a);
    end
    T_exakt=2/max(max(T_exakt))*T_exakt;
    figure
     mesh(T_exakt);
     colormap(jet(255));
     xlabel('x'); ylabel('y'); zlabel('T_{(x,y)}')
     title('Temperaturverteilung. Exakte Lösung')

% Lösung mit Iteration
%---------------------

Nx=30;                  % Gitter. Anzahl x-Punkte
Ny=20;                  %         Anzahl y-Punkte

T=zeros(Ny,Nx);         % Temperatur auf Null setzten
x=linspace(-1,1,Nx);    % Randwerte auf einer Seite
T(end,:)=2*(1-x.^2);    % mit quadratischer Temperaturverteilung

K=2:Nx-1;               % Indices für die inneren Werte
J=2:Ny-1;    

figure
  mesh(T);
  colormap(jet(255));
  xlabel('x'); ylabel('y'); zlabel('T_{(x,y)}')
  title('Temperaturverteilung. Randwerte')
  
N_Iteration=100;    % Anzahl Iterationen
    for n=1:N_Iteration
        T(J,K)=0.25*(T(J,K+1)+T(J,K-1)+T(J+1,K)+T(J-1,K));
    end
    
figure
  mesh(T);
  colormap(jet(255));
  xlabel('x'); ylabel('y'); zlabel('T_{(x,y)}')
  title('Temperaturverteilung. Iteration Lösung')
  
% Lösung mit einem Gleichungssystem
%----------------------------------

% Randwerte setzen
G=NaN(Ny,Nx);            
G(1,:)=0;
G(:,[1,end])=0;
x=linspace(-1,1,Nx);
G(end,:)=2*(1-x.^2);

% Zellen-Indizierung aufbauen
j=(1:Ny*Nx)';
k=j;
s=ones(size(j));
[u, v]=find(isnan(G));
index=(v-1)*Ny+u;

for h=[-1,1,-Ny,Ny]
    j=[j; index];
    k=[k; index+h];
    s=[s;-0.25*ones(size(index))];
end

% Randwerte (bzw. Vorgabewerte) in Vektorform

G(isnan(G))=0;      % Nichtvorbesetzte Werte =0
R=G(:);             % Werte in Vektor-Form

% (Sparse-) Matrix aufbauen 
L=sparse(j,k,s);

% Gleichungssystem Lösen
y=L\R;
% Lösung in Vektor-Form
T=reshape(y,Ny,Nx);

figure
  mesh(T);
  colormap(jet(255));
  xlabel('x'); ylabel('y'); zlabel('T_{(x,y)}')
  title('Temperaturverteilung. Lösung mit Gleichungssystem')

elseif Fall==2    
%% 2: Potentialverteilung auf rechteckigem Kanal
%==============================================
   
    Nx=50;               % Gitter. Anzahl x-Punkte
    Ny=50;               %         Anzahl y-Punkte
    % x, y-Werte
    x1=linspace(0,4,Nx);
    y1=linspace(0,4,Ny);
    [xg, yg]=meshgrid(x1,y1); 
    
    G=NaN(Nx,Ny);       % Matrix mit Randwerten
                        % Diese Matrix wird auch für die Lösung mit
                        % einem Gleichungssystem benötigt
                        % Die nicht vorgegebenen Werte sind auf NaN gesetzt
    G(1,:)=0;           % Unterer Rand 0 V                    
    G(end,:)=10;        % Oberer Rand 10 V
    G(:,1)=-5;          % Seitenwand links -5 V
    G(:,end)=-5;        % Seitenwand rechts -5 V
    
    figure                  % Anfangszustand darstellen
    mesh(G);
    colormap(jet(255));
    xlabel('x'); ylabel('y'); zlabel('V_{(x,y)}')
    title('Randwerte')
    V=G;                
    V(isnan(G))=0;      % V ist die Ausgangssituation. Alle Werte ausser
                        % den Randwerten sind auf Null gesetzt
                        
    % Berechnung mit Iteration
    %-------------------------
    
    N_Iterations=1000;      % Anzahl Iterationen
    figure                  % Anfangszustand darstellen
    mesh(xg,yg,V);
    colormap(jet(255));
    xlabel('x'); ylabel('y'); zlabel('V_{(x,y)}')
    title('Potentialverteilung. Iteration Anfangswerte')
    
    J=2:size(V,1)-1;        % Indices für die inneren Werte
    K=2:size(V,2)-1;
    
    for n=1:N_Iterations
        V(J,K)=0.25*(V(J,K+1)+V(J,K-1)+V(J+1,K)+V(J-1,K));
        if mod(n, floor(N_Iterations/5))==0 % jede 5-te Iteration darstellen
            figure
            mesh(xg,yg,V);
            colormap(jet(255));
            xlabel('x'); ylabel('y'); zlabel('V_{(x,y)}')
            title(['Potentialverteilung. Lösung mit Iteration N= ' num2str(n)])
        end 
    end
    
% Berechnung mit einem Gleichungssystem
%--------------------------------------

% Randwerte siehe Matrix G

% Werte zuordnen
j=(1:Ny*Nx)';
k=j;
s=ones(size(j));
[u, v]=find(isnan(G));
index=(v-1)*Ny+u;
for h=[-1,1,-Ny,Ny] % h nimmt die Werte -1,1 usw. an
    j=[j; index];
    k=[k; index+h];
    s=[s;-0.25*ones(size(index))];
end

% Gleichungssystem A*x=r aufstellen
A=sparse(j,k,s);
G(isnan(G))=0;
r=G(:);
x=A\r;              % Gleichungssystem lösen
V2=reshape(x,Ny,Nx);   % Lösungsvektor in eine Matrix umwandeln

figure
 mesh(xg,yg,V2);
 colormap(jet(255));
 xlabel('x')
 ylabel('y')
 zlabel('V_{(x,y)}')
 title('Potentialverteilung. Lösung mit Gleichungssystem')

% Berechnung von Hand siehe Skript
%---------------------------------
    Ny=5;               % Gitter. Anzahl y-Punkte
    Nx=5;               %         Anzahl x-Punkte
    x1=linspace(0,4,Nx);
    y1=linspace(0,4,Ny);
    [xg, yg]=meshgrid(x1,y1);
    V=zeros(Ny,Nx);                
    V(1,:)=0;      % Unterer Rand
    V(Ny,:)=10;     % Oberer Rand
    V(1:Ny,1)=-5;   % Seitenwand links
    V(1:Ny,Nx)=-5;   % Seitenwand rechts
    
    % Ergebnisse mit Gauss-Verfahren
    V(2,2)=-1.78571; V(2,3)=-0.89286; V(2,4)=-1.78571;
    V(3,2)=-1.25;    V(3,3)=0;        V(3,4)=-1.25;
    V(4,2)=1.7857;   V(4,3)=3.39286;  V(4,4)=1.78571;
    % Zum Überlagern mit der Exakten Lösung
     hold
     plot3(xg,yg,V,'* r');
     xlabel('x')
     ylabel('y')
     zlabel('V_{(x,y)}')

 figure
 mesh(xg,yg,V);
 colormap(jet(255));
 xlabel('x')
 ylabel('y')
 zlabel('V_{(x,y)}')
 title('Potentialverteilung. Lösung mit Gleichungssystem Skript')        
 
elseif Fall==3
% 3: Berechnung einer Dreielektrodenanordnung 
%============================================
 nIterations=1000;
 s=6;
 xm=8*s-1;
 ym=6*s-1;
 G=NaN(ym,xm);
 G([1,end],:)=0;
 G(:,[1,end])=0;
 G(s,2*s:6*s)=0;
 G(2*s,[2*s:3*s,5*s:6*s])=-4;
 G(4*s,2*s:6*s)=6;
  figure                  % Anfangszustand darstellen
    mesh(G);
    colormap(jet(255));
    xlabel('x'); ylabel('y'); zlabel('V_{(x,y)}')
    title('Randwerte')
 % Berechnung mit Iteration
 %-------------------------
 V=G;
 V(isnan(G))=0;
 J=2:size(V,1)-1;
 K=2:size(V,2)-1;
 for n=1:nIterations
    V(J,K)=0.25*(V(J,K+1)+V(J,K-1)+V(J+1,K)+V(J-1,K));
    V(~isnan(G))=G(~isnan(G));
 end
figure
  meshc(V)
  colormap(jet(255));
  xlabel('x'); ylabel('y'); zlabel('V_{(x,y)}')
  title('Potentialverteilung. Lösung mit Iteration')
  
% Berechnung mit einem Gleichungssystem
%--------------------------------------

% Randwerte siehe Matrix G

% Werte zuordnen
Nx=xm;
Ny=ym;
j=(1:Ny*Nx)';
k=j;
s=ones(size(j));
[u, v]=find(isnan(G));
index=(v-1)*Ny+u;
for h=[-1,1,-Ny,Ny]
    j=[j; index];
    k=[k; index+h];
    s=[s;-0.25*ones(size(index))];
end
G(isnan(G))=0;

% Gleichungssystem A*x=r aufstellen
A=sparse(j,k,s);
r=G(:);

x=A\r;              % Gleichungssytem lösen

V=reshape(x,Ny,Nx);   % Lösungsvektor in eine Matrix umwandeln

figure
  meshc(V)
  hold
  contour3(V,'k')
  colormap(jet(255));
  xlabel('x'); ylabel('y'); zlabel('V_{(x,y)}')
  title('Potentialverteilung. Lösung mit Gleichungssystem')
  
% Äquipotential-Linien und E=grad(V) 
%-----------------------------------
[Ex, Ey]=gradient(V); % Elektrisches Feld E=grad(V)
figure
  contour(V,10);% ,'ShowText','on')
  hold
  quiver(Ex, Ey)
  xlabel('x'); ylabel('y');
  title('Äquipotential-Linien V_{(x,y)}=const und E=grad(V)')
end