% test_Verteilungsfunktionen.m   	
%
% Beispiel zur Erzeugung von Zufallswerten mit unterschiedlichen
% Verteilungsfunktionen (H�ufigkeitsfunktionen)
% 		
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung strukturelle und
%           funktionale Systemsimulation SS 2018 erstellt.
%
% Datum:    2018-07-21
%
% �nderung: 2021-11-25 if durch switch ausgetauscht
%
% siehe auch: n_bins: Anzahl von Klassen in Abh�ngkeit der Anzahl Werte
%----------------------------------------------------------------------

clearvars;
close all;

% Ben�tigte Matlab Standard-functions f�r Toleranz-Rechnungen
% -----------------------------------------------------------
 n_s=1e6;                       % Anzahl Werte
 AnzKl = n_bins(n_s);	        % Anzahl Klassen
 
 f_standard_normal=randn(1,n_s);% Standard Normalverteilt
 f_uniform=rand(1,n_s);         % Rechteckverteilt Normalverteilt
 
 Verteilung=2; % 1: Standard-Normalverteilung
               % 2: Rechteckverteilung 
               % 3: Normalverteilung

 switch Verteilung    

     case 1 % Standard-Normalverteilung
         f=f_standard_normal;          
         typ_str='f_{standard normal}'; % wird f�r plot ben�tigt
         f_m=0;                         % Mittelwert. Wird nur f�r die Gau�-Kurve ben�tigt
         f_std=1;                       % Standardabweichung (Sigma)

     case 2 % Rechteckverteilung 
         f=f_uniform;      
         typ_str='f_{uniform}'; % wird f�r plot ben�tigt
         f_m=mean(f);           % Mittelwert. Wird nur f�r die Gau�-Kurve ben�tigt
         f_std=std(f);          % Standardabweichung (Sigma)

     case 3       % Normalverteilung
         f_m=10;                                % Mittelwert
         f_std=2;                               % Standardabweichung (Sigma)
         f=f_m*ones(1,n_s)+f_std*randn(1,n_s);  % Berechnung der Normalverteilung
                                                % aus der Standard-Normalverteilung 
         typ_str='f_{normal}';                  % wird f�r plot ben�tigt
 end
 
f_mean_ist=mean(f);         % Berechnung des Mittelwertes               
f_std_ist=std(f);           % Berechnung der Standardabweichung        
 
[Nabs,x_h] = hist(f,AnzKl); % Nabs(i) ist die Anzahl Werte in der Klasse
                            % x_h(i). Diese Darstellung nennt man absolute
                            % H�ufigkeit 
                            
 Nrel=Nabs/n_s;             % Teilt man die Werte pro Klasse durch die
                            % Anzahl der Werte erh�lt man die rel.H�ufigkeit
 Sum_abs=cumsum(Nabs);      % Summiert man die H�ufigkeit kumulativ,
 Sum_rel=cumsum(Nrel);      % so erh�lt man die Summenh�ufigkeit
 
 % Werten nur f�r die Darstellung der Gau�verteilung!
 x_min=min(f);
 x_max=max(f);
 x=linspace(x_min,x_max);
 f_gauss=p_gauss(x,f_std,f_m);        
 Sum_gauss=cumsum(f_gauss)*(x(2)-x(1));
 
 figure
 subplot(2,3,1)
    plot(f,'. k')
    grid;
    xlabel('Wert-Nr.')
    ylabel(typ_str);
    title('Werte');
subplot(2,3,2)
    bar(x_h, Nabs,1,'r')
    grid;
    xlabel(typ_str)
    ylabel('N_{abs} [-]')
    title('absolute H�ufigkeit')
 subplot(2,3,3) 
     plot(x_h,Sum_abs,'r')
    grid
    xlabel(typ_str)
    ylabel('N_{abs} [-]')
    title('abs. Summenh�ufigkeit')  
 subplot(2,3,5) 
    bar(x_h,100*Nrel/(x_h(2)-x_h(1)),1,'b');
    if ~(Verteilung==2)
        hold
        plot(x,100*f_gauss,'r -.','LineWidth',2)
    end
    grid;
    xlabel(typ_str)
    ylabel('N_{rel} [%]')
    title('relative H�ufigkeit') 
 subplot(2,3,6) 
    plot(x_h,100*Sum_rel,'b')
    if ~(Verteilung==2)
        hold
        plot(x,100*Sum_gauss,'r -.')
    end    
    grid
    xlabel(typ_str)
    ylabel('N_{rel} [%]')
    title(['rel. Summenh�ufigkeit x_m= ' num2str(f_mean_ist) ])    
 
