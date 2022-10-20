function [binomial_nk] = binomial(n, k)
% function [binomial_nk] = binomial(n, k)
%   Calculates the binomial coefficient of 'n' over 'k'.

binomial_nk = fact(n) / ( fact(n - k) * fact(k) );


% Sub-function that calculates the factorial of 'n'.
function [factorial_n] = fact(n)

factorial_n = 1;
for i = 1:n
    factorial_n = factorial_n * i;
end