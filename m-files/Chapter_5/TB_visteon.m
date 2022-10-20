%Alternative mögliche Erzeugung eines "Einheitsbursts" aus dem dann das Visteon 
%Triangle burst Profil zusammengesetzt wird. 

clear all;
close all;

grms=10;			%maximale Amplitude eines "Pulspäckchens" grms [grms]

tp=0.21;		%Pausezeit zwischen 2 "Pulspäckchen" tp [s]

y=[0, 1, 0, -1, 0, 2, 0, -2, 0, 3, 0, -3, 0, 4, 0, -4, 0, 3, 0,-3, 0, 2, 0, -2, 0, 1, 0, -1, 0];
y=grms.*y;
t=0:1/(length(y)-1):1; %erzeugt Vektor t mit derselben Anzahl von Spalten wie der Vektor y

%Schleife zum Erzeugen einer Matrix ta, die genausoviele Zeilen enthält,
%wie Werte für die Frequenz f eingegeben werden und soviele Spalten wie derVector y. 
%Werte in der letzten Spalte von ta sind Kehrwerte der eingegebenen Frequenzen 1/f
io=0;
for f=[10, 18.2, 11.1, 20.1, 12.2, 22.2, 13.5, 24.6, 14.9, 27.1, 16.5, 30, ...
       10, 18.2, 11.1, 20.1, 12.2, 22.2, 13.5, 24.6, 14.9, 27.1, 16.5, 30];
   io=io+1;
   ta(io,:)=7*(t./f);  %hier *7 weil ein "Pulspäckchen" aus 7 Pulsen besteht
end
%ta(:,end);

%Berechnen der Anfangszeiten tax für die einzelnen "Pulspäckchen"
ta1=ta(1,:);
ta2=(ta(1,end)+ta(2,:)+tp);
ta3=(ta2(1,end)+ta(3,:)+tp);
ta4=(ta3(1,end)+ta(4,:)+tp);
ta5=(ta4(1,end)+ta(5,:)+tp);
ta6=(ta5(1,end)+ta(6,:)+tp);
ta7=(ta6(1,end)+ta(7,:)+tp);
ta8=(ta7(1,end)+ta(8,:)+tp);
ta9=(ta8(1,end)+ta(9,:)+tp);
ta10=(ta9(1,end)+ta(10,:)+tp);
ta11=(ta10(1,end)+ta(11,:)+tp);
ta12=(ta11(1,end)+ta(12,:)+tp);
ta13=(ta12(1,end)+ta(13,:)+tp);
ta14=(ta13(1,end)+ta(14,:)+tp);
ta15=(ta14(1,end)+ta(15,:)+tp);
ta16=(ta15(1,end)+ta(16,:)+tp);
ta17=(ta16(1,end)+ta(17,:)+tp);
ta18=(ta17(1,end)+ta(18,:)+tp);
ta19=(ta18(1,end)+ta(19,:)+tp);
ta20=(ta19(1,end)+ta(20,:)+tp);
ta21=(ta20(1,end)+ta(21,:)+tp);
ta22=(ta21(1,end)+ta(22,:)+tp);
ta23=(ta22(1,end)+ta(23,:)+tp);
ta24=(ta23(1,end)+ta(24,:)+tp);


t=[ta1, ta2, ta3, ta4, ta5, ta6, ta7, ta8, ta9, ta10, ta11, ta12, ... 
      ta13, ta14, ta15, ta16, ta17, ta18, ta19, ta20, ta21, ta22, ta23, ta24];

triangle_burst=[y, y, y, y, y, y, y, y, y, y, y, y, ...
                y, y, y, y, y, y, y, y, y, y, y, y ];


%t = [t, 2*t(end)];
%triangle_burst = [triangle_burst, 0];

figure(1)
plot(t, triangle_burst)

title('Visteon triangle burst profile'),xlabel('t'),ylabel('grms') 


%FFT des triangle burst profiles 
m = 4096										
ts = linspace(min(t), max(t), m); 	%erzeugt vector ts der länge m. (m äquidistante stützstellen)  
fs=1/(ts(2)-ts(1))						%erzeugt eine "sample-frequenz" fs=1/delta ts
ys= interp1(t,triangle_burst,ts); 	%lineare interpolation 

ya=fft(ys);
P=ya.*conj(ya) / (m*m);
ff=fs*(0:m/2-1) /m;

figure (11)
semilogy(ff,P(1:m/2),'b')
title('Leistungsdichtespektrum')
xlabel('f in Hz')
grid