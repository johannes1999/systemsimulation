function [binomial_nk] = binomial_recursive(n, k)
% function [binomial_nk] = binomial(n, k)
%   Calculates the binomial coefficient of 'n' over 'k'.

binomial_nk = factorial(n) / ( factorial(n - k) * factorial(k) );


% Sub-function that calculates the factorial of 'n'.
function [factorial_n] = factorial(n)

if n == 1
    factorial_n = 1;
else
    factorial_n = n * factorial(n - 1);
end