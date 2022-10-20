function y = wurzel_rekursiv_fun_01(count, a0)
    if(count > 0)
        if(count == 1)
            y=a0;
        else
            count = count-1;
            an = wurzel_rekursiv_fun_01(count, a0);
            y=(1/2)*(an+(a0/an));
        end
    end
    
end