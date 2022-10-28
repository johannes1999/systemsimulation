close all;
clearvars;

BREITE = 100

if(mod(BREITE, 2)==0) % die unterste ebene muss immer ungerade sein
    BREITE = BREITE + 1 %ich mache sie einfach eins breiter
end

decision = rand(1,1);

kugel = 10000

while BREITE > 0
    y = galton_rekursiv_fun_01(kugel);
    kugel = y
    BREITE = BREITE - 1;
end


bar((1:length(y)),y,'b')


