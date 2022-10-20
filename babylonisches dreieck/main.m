close all;
clearvars;

DURCHLAUFE = 10;
a0 = 4;

a = zeros(1,DURCHLAUFE);

a(1)=a0;

for i=(1:DURCHLAUFE)
    if (i<100 && i>0)
        a(i+1)=(1/2)*(a(i)+(a0/a(i)));
    end
end

fprintf("Die Wurzel von %d ist: %d\n", a0, a(DURCHLAUFE))

y= wurzel_rekursiv_fun_01(DURCHLAUFE, a0);

fprintf("Die Wurzel (rekursion) von %d ist: %d\n", a0, y)

an = a0;
anMinusEins = 0;
i=1;
epsilon = 1;
abbruch = 10^(-7);
while epsilon > abbruch %sobald die änderung zwischen zwei berechnungen kleiner ist, breche ich ab
    an = (1/2)*(an+(a0/an));
    i=i+1;
    epsilon = abs((anMinusEins-an)/an); %die änderung kann negativ ist
    anMinusEins = an;
end

fprintf("Die Wurzel (ohne vektor, mit epsilon) von %d ist: %d (nach %d Durchläufen)\n", a0, an, i)
