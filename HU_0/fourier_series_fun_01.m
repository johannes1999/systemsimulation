function y = fourier_series_fun_01(a0,a,b,T,A,t)
    
    w0 = (2*pi)/T; %ausrechnen der Kreisfrequenz

    zwischenergebnis = zeros(1, length(t)); %speicher für das Ergebnis der Summenfunktion mit 0 initialisiert

    for i=1:length(a) %summenfunktion
        zwischenergebnis = zwischenergebnis+(a(i)*cos(i*w0*t)+b(i)*sin(i*w0*t));
    end
    
    y=(zwischenergebnis.*A)+a0/2; %multiplikation mit A und Addition mit a0/2
end