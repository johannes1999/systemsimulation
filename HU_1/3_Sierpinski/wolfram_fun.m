function [y] = wolfram_fun(regel,raum,zeit)
    y = zeros(zeit, raum);
    yTmp = zeros(1, raum);
    rule_bits = bitget(regel, 1:8) %convert from integer to bit array (8-Bit)

    %prepare first line
    %yTmp(floor((raum + 1) / 2)) = 1;
    yTmp = randi([0 1],1,raum);

    %first row
    y(1, :) = yTmp;

    %for loop over time, beginning at 2
    for i = 2:zeit
        %check for every cell, the cell before itself, right neighbor and left neighbor in a
        %for-loop. skip first and last cell, because they only have one
        %neighbour
        for w = 2:(raum-1)
            %calculate decimal from bits. bin2dec will also work, but i
            %wanted to try this;
            condition = 0;
            condition = condition + y(i-1, w-1) * 4; %most significant bit
            condition = condition + y(i-1, w) * 2;
            condition = condition + y(i-1, w+1) * 1; %least significant bit

            condition = condition + 1; %just to make it usable for adressing vectors

            %apply rule according to condition
            yTmp(w) = rule_bits(condition);

        end

        %apply changes
        y(i, :) = yTmp;
    end
end