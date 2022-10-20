clc
clearvars

for i=randi(10,10)
    fprintf("%d",i)
    if(i==0)
        fprintf(" Zero\n")
    elseif((i > 1) && (i < 5))
        fprintf(" greater than 1, but smaller than 5\n")
    else
        fprintf("\n")
    end
end
