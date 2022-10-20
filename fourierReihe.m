clearvars
clc

N=20;
n=1:N

bn=1./n

bn = bn(1:end-1)
n = n(2:end)

%jeder zweite wert bis zum ende ist 0
%bn(2:2:end)=0

%oder plot(n,bn,'*')
figure; stem(n,bn,'*');grid

x=0:0.01:4*pi;
erg = 0;
for i=n
    fprintf("%d\n",bn(i-1))
    %erg = bn(i-1) * cos((i-1)*)
end