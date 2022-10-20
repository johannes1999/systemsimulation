% For loop example.
function [sum] = ForLoop(n)

% Calculate sum = 1 + 2 + 3 + ... + n.
sum = 0;
for i = 1:n
    sum = sum + i;
end