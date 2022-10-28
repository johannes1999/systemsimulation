% gibt die unterliegende ebene als vektor (array) zurück
function y = galton_rekursiv_fun_01(kugeln)
    breiteEinwurf = length(kugeln);
    auffang = zeros(1, breiteEinwurf+1); %die nächste ebene fängt die kugeln auf

    for i=(1:breiteEinwurf)
        fprintf("i: %d\n",i)
        while kugeln(i) ~= 0
            random = rand(1,1);
            kugeln(i) = kugeln(i)-1; %eine kugel fällt raus
            if(random>0.5) %kugel fällt nach rechts
                auffang(i+1) = auffang(i+1)+1;
            else %kugel fällt nach links
                auffang(i) = auffang(i)+1;
            end
        end
    end
    y = auffang;
end