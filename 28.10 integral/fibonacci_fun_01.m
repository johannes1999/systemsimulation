% gibt die unterliegende ebene als vektor (array) zurück
function y = fibonacci_fun_01(x)
    y=0;
    if(x<=1 || x==2)
        y=1;
    else
        y=fibonacci_fun_01(x-2)+fibonacci_fun_01(x-1);
    end
end