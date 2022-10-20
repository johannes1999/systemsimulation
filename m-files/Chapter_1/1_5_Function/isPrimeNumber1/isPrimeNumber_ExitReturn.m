function [result] = isPrimeNumber(number)
% function [result] = isPrimeNumber(number)
%   This function determines whether 'number' is a prime 
%   number or not. In case of a prime number the value 1
%   (true) is returned in 'result' otherwise 0 (false) is 
%   returned.
%   A number is prime number when it is only divisible by 
%   1 or itself.

i = 2;
result = 0;
while(i < number)
    if (rem(number, i) == 0)
        % Given number is divisible by 'i',
        % i.e. not a prime number.
        return;
    end
    i = i + 1;
end

% Number is a prime number.
result = 1;