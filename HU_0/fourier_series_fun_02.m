function y = fourier_series_fun_02(a0,a,b,T,A,t,opt)
    %%% input vorbereiten
    inputs = nargin();
    if(inputs == 6) %no opt
        opt = -1;
    elseif(inputs < 6) %error
         opt = -2;
    end
    %%%
    
    w0 = (2*pi)/T; %ausrechnen der Kreisfrequenz
    zwischenergebnis = zeros(1, length(t)); %speicher für das Ergebnis der Summenfunktion mit 0 initialisiert

    switch opt
        case -2 %not enough params
            y = 0;
        case 0 %normal operation; no plot in func
        case -1 %normal operation
            for i=1:length(a) %summenfunktion
                zwischenergebnis = zwischenergebnis+(a(i)*cos(i*w0*t)+b(i)*sin(i*w0*t));
            end
            y=(zwischenergebnis.*A)+a0/2; %multiplikation mit A und Addition mit a0/2
        case 1 %funktionswerte darstellen
            for i=1:length(a) %summenfunktion
                zwischenergebnis = zwischenergebnis+(a(i)*cos(i*w0*t)+b(i)*sin(i*w0*t));
            end
            y=(zwischenergebnis.*A)+a0/2; %multiplikation mit A und Addition mit a0/2
            plot(t,y,'r')
        case 2 %plot jedes anteils
            for i=1:length(a) %summenfunktion
                hold on;
                neuerAnteil = (a(i)*cos(i*w0*t)+b(i)*sin(i*w0*t));
                zwischenergebnis = zwischenergebnis+neuerAnteil;
                plot(t,(neuerAnteil.*A)+a0/2, 'Color', [(1/length(a))*i, 0, 0]) %neue harmonische mit A und a0/2
            end
            y=(zwischenergebnis.*A)+a0/2; %multiplikation mit A und Addition mit a0/2
        case 3 %plot nach jeden addieren
            for i=1:length(a) %summenfunktion
                hold on;
                zwischenergebnis = zwischenergebnis+(a(i)*cos(i*w0*t)+b(i)*sin(i*w0*t));
                plot(t,(zwischenergebnis.*A)+a0/2, 'Color', [0, (1/length(a))*i, 0]) %neue funktionswerte mit A und a0/2
            end
            y=(zwischenergebnis.*A)+a0/2; %multiplikation mit A und Addition mit a0/2
    end

end