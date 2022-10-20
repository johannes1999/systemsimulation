% Print intermediate values.
a = 2;
b = 4;
c = 3;

D = sqrt(b^2 - 4*a*c)

disp(D);

fprintf('a = %f, b = %f, c = %f, D = (%f,%f)\n', a, b, c, real(D), imag(D));

x1 = (-b - D) / (2*a)
x2 = (-b + D) / (2*a)