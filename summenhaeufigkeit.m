close all;  % Alle plots schliessen
clearvars;  % workspace löschen.


N_klassen = 1000;
a = randn(1,N_klassen);
[N, x]=hist(a,N_klassen)

s = cumsum(N);

figure()
bar(x, N)
