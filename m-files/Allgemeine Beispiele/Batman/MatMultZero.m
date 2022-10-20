
a1=[1 2 3];
b1=[4 5 6];
c1=[7 8 9];
L=[1 2 3];
Al=[ 10 30 50]*pi/180;
a2=L(1)*[cos(Al(1)); sin(Al(1));-(a1(1)*cos(Al(1))+a1(2)*sin(Al(1)))/a1(3)];
b2=L(2)*[cos(Al(2)); sin(Al(2));-(b1(1)*cos(Al(2))+b1(2)*sin(Al(2)))/b1(3)];
c2=L(3)*[cos(Al(3)); sin(Al(3));-(c1(1)*cos(Al(2))+c1(2)*sin(Al(2)))/c1(3)];
A=[a1; b1; c1]
B=[a2, b2, c2]
C=A*B