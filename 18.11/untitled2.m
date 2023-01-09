close all;  % Alle plots schliessen
clearvars;  % workspace löschen.



a = randn(1,1000);
b = randn(1,1000);
c=a.*b;

[N,x] = hist(c, 1000);


figure()
subplot(2,2,1)
hist(a, 1000)
subplot(2,2,2)
hist(b, 1000)
subplot(2,2,3)
hist(c, 1000);
subplot(2,2,4)
bar(x, N);

cumsum(x)