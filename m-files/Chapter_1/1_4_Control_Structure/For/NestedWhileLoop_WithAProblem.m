% The nested while loop with a problem.

coin_values  = [2.00, 1.00, 0.50, 0.20, 0.10, 0.05, 0.02, 0.01]; % In Euro.
coin_change = zeros(size(coin_values));

change = 4.92; % In Euro.

coin_index = 1;
while(change > 0)
    while(coin_values(coin_index) <= change)
        change = change - coin_values(coin_index);
        coin_change(coin_index) = coin_change(coin_index) + 1;
    end
    coin_index = coin_index + 1;
end

coin_values
coin_change