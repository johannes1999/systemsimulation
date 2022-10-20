% test_RobustDesign.m   	
%
% Zeigt einige Bespiele bezüglich der Robust Design Methode 
% Siehe SysSim Kapitel 5 
% 		
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-05
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------

clearvars;
close all;

Example=2;  % 1: Häufigkeitsfunktion und Summenhäufigkeitsfunktion
            % 2: Beispiel rnd_vect Spannungsteiler 
            %    und Herleitung statistische Sensitivität
            % 3: Verteilungen bei verschiedenen Berechungen
            % 4: Verteilungen der rnd_vect function
            % 5: Summe von Rechteck Verteilungen
            % 6: Wie findet man die notwendige Werte-Anzahl?
            % 7: Korrelationsmatix Spannungsteiler
            
switch Example     
    
    case 1  
    %% 1: Häufigkeitsfunktion und Summenhäufigkeitsfunktion
    % -----------------------------------------------------
        n_s=1e4;                       % Anzahl Werte
        AnzKl = n_bins(n_s);	       % Anzahl Klassen
        U_m=10;                        % Mittelwert
        U_std=1;                       % Standardabweichung (Sigma)
        U=rnd_vect(n_s,'normal',[U_m U_std],[],[]);  % Spannungswerte normalvertteilt [V] 
 
        [Nabs,U_h] = hist(U,AnzKl); % Nabs(i) ist die Anzahl Werte in der Klasse
                                    % U_h(i). Diese Darstellung nennt man absolute
                                    % Häufigkeit 
                            
        Nrel=Nabs/n_s;              % Teilt man die Werte pro Klasse durch die
                                    % Anzahl der Werte erhält man die rel.Häufigkeit
        S_abs=cumsum(Nabs);         % Summiert man die Häufigkeit kumulativ,
        S_rel=cumsum(Nrel);         % so erhält man die Summenhäufigkeit
  
        figure
            plot(U,'* b')
            xlabel('Wert-Nr.')
            ylabel('U [V]');
            title('Werte')
        figure
        subplot(2,2,1)
            bar(U_h, Nabs,1,'r')
            grid;
            xlabel('U [V]')
            ylabel('N_{abs} [-]')
            title('absolute Häufigkeit')
        subplot(2,2,2) 
            plot(U_h,S_abs,'r')
            grid
            xlabel('U [V]')
            ylabel('N_{abs} [-]')
            title('abs. Summenhäufigkeit')  
        subplot(2,2,3) 
            bar(U_h,100*Nrel,1,'b')
            grid;
            xlabel('U [V]')
            ylabel('N_{rel} [%]')
            title('relative Häufigkeit') 
        subplot(2,2,4) 
            plot(U_h,100*S_rel,'b')
            grid
            xlabel('U [V]')
            ylabel('N_{rel} [%]')
            title('rel. Summenhäufigkeit')    

    case 2  
    %% 2: Beispiel rnd_vect Spannungsteiler
    %-------------------------------------
        n_s=1e5;                        % Anzahl Werte
        AnzKl = n_bins(n_s);            % Anzahl Klassen
        nSigma=3;                       % Die Toleranzwerte entsprechen n*Sigama

        distribution='normal';          % Umschalten durch auskommentieren
        %distribution='uniform';

        % R1
        %---
        R1nom=5000;                     % R1 nominal    [Ohm]
        R1_tol=5/100;                  % Toleranz      [1/100]
        R1std=R1nom*R1_tol/nSigma;      % R1 nominal    [Ohm]

        % R2
        %---
        R2nom=15000;                     % R2 nominal   [Ohm]
        R2_tol=5/100;                    % Toleranz     [1/100]
        R2std=R2nom*R2_tol/nSigma;       % R2 nominal   [Ohm]

        % U0
        %---
        U0nom=10;                       % U0 nominal  [V]
        U0_tol=10/100;                  % Toleranz    [1/100]
        U0std=U0nom*U0_tol/nSigma;      % U0 nominal  [V]

        switch distribution % Verschieden verteilungsarten
            case 'normal'
            R1=rnd_vect(n_s,'normal',[R1nom R1std],[],[]);
            R2=rnd_vect(n_s,'normal',[R2nom R2std],[],[]);
            U0=rnd_vect(n_s,'normal',[U0nom U0std],[],[]);
            case 'uniform'
            R1=rnd_vect(n_s,'uniform',[R1nom R1nom*R1_tol],[],[]);
            R2=rnd_vect(n_s,'uniform',[R2nom R2nom*R2_tol],[],[]);
            U0=rnd_vect(n_s,'uniform',[U0nom U0nom*U0_tol],[],[]);
        end

        U1=R1./(R1+R2).*U0; % Ausgangsspannung

        figure % Systemparameter, Ein- und Ausgangsgröße
        subplot(2,2,1);
            xs_hist_c(R1*1e-3,AnzKl,'R_1','System Parameter R_1','[kOhm]','b',1)
        subplot(2,2,2);
            xs_hist_c(R2*1e-3,AnzKl,'R_2','System Parameter R_2','[kOhm]','b',1)
        subplot(2,2,3);
            xs_hist_c(U0,AnzKl,'U_0','Eingangsgröße U_0','[V]','r',1)
        subplot(2,2,4);
            xs_hist_c(U1,AnzKl,'U_1','Ausgangsgröße U_1','[V]','g',1)       

        figure
        pfpareto(U1,' ',[],[],'U_1 ',0,0,R1,'R_1',R2,'R_2',U0,'U_0');

% Sensitivität 
%-------------
   % Partielle Ableitungen
   dU1_dR1=R2nom/(R1nom+R2nom)^2;
   dU1_dR2=-R1nom/(R1nom+R2nom)^2;
   dU1_dU0=R1nom/(R1nom+R2nom);
   
   U1nom=R1nom/(R1nom+R2nom)*U0nom; % Nominalwert der Ausgangsspannung [V]
   %Relative Fehler
   DR1=dU1_dR1*R1nom*R1_tol/U1nom;
   DR2=dU1_dR2*R2nom*R2_tol/U1nom;
   DU0=dU1_dU0*U0nom*U0_tol/U1nom;
   % Mittlerer relative Fehler
   Frel=sqrt(DR1^2+DR2^2+DU0^2);
   
% Statistische Sensitivität
%--------------------------
figure % Ausgangsgröße über den jeweiligen Parameter
 subplot(2,2,1);
    plot(R1/1000,U1,'b .'); grid;
    xlabel('R_1 [kOhm]'); ylabel('U_1 [V]')
 subplot(2,2,2);
    plot(R2/1000,U1,'b .'); grid;
    xlabel('R_2 [kOhm]'); ylabel('U_1 [V]')
 subplot(2,2,3);
    plot(U0,U1,'b .'); grid;
    xlabel('U_0 [V]'); ylabel('U_1 [V]')
 
figure % Eingangsgrößen untereinander
 subplot(2,2,1);
    plot(R1/1000,R2/1000,'b .'); grid;
    xlabel('R_1 [kOhm]'); ylabel('R_2 [kOhm]')
 subplot(2,2,2);
    plot(R1/1000,U0,'b .'); grid;
    xlabel('R_1 [kOhm]'); ylabel('U_0 [V]')
 subplot(2,2,3);
     plot(R2/1000,U0,'b .'); grid;
    xlabel('R_2 [kOhm]'); ylabel('U_0 [V]')
 
% Berechnungsschritte für die stat. Sensitivität
%-----------------------------------------------

% Schritt 1

%  Umsortieren der U1-Werte > und < als der Mittelwert von U1 bezogen auf R1
%  Dafür müssen wir zuerst R1 umsortieren und die U1-Werte entsprechend der
%  neuen Positione von R1 umsortieren.

% Ausgangssituation
U1_mean=mean(U1); % Mittelwert von U1

figure 
subplot(2,1,1)
    xs_hist_c(U1,AnzKl,'U_1','Ausgangsgröße U_1','[V]','g',1)       
subplot(2,1,2)
    plot(R1,U1,'o',[min(R1) max(R1)],[U1_mean U1_mean],'r-.' ); grid
    xlabel(' R1 [Ohm]'); ylabel('U1 mit Mittelwert [V]')

% Umsortieren
[R1_sort, I]=sort(R1);
U1_sort=U1(I);

%  Schritt 2
%  Aufteilung in zwei Funktionen U1_min(R1_min): alle Werte < U1-mean und 
%                                U1_max(R1_max): alle Werte > U1-mean
n_max=0; n_min=0;

for i=1:n_s
    if U1_sort(i)>U1_mean
        n_max=n_max+1;
        U1_max(n_max)=U1_sort(i);
        R1_max(n_max)=R1_sort(i);
    else
        n_min=n_min+1;
        U1_min(n_min)=U1_sort(i);
        R1_min(n_min)=R1_sort(i);
    end
end

figure
subplot(2,1,1);
plot(R1_min,U1_min,'r.',R1_max,U1_max,'b.'); grid
xlabel('R1 [Ohm]'); ylabel('U1 [V]')
title('Separiert an der Mittelwertlinie')

%  Schritt 3
%  Berechnung der histogram-Werte von U1_min über R1_min (genauso  für max Werte) 
%   -> N_min, R_pass_pos and N_max, R_fail_pos 

R_pass=linspace(min(R1_min),max(R1_min),n_bins(n_min)); % pass meint größer als der Mittelwert
R_fail=linspace(min(R1_max),max(R1_max),n_bins(n_max)); % fail meint kleiner als der Mittelwert
[N_min, R_pass_pos]=hist(R1_min,R_pass);
[N_max, R_fail_pos]=hist(R1_max,R_fail);


subplot(2,1,2);
plot(R_pass_pos,N_min,'r',R_fail_pos,N_max,'b')
title('Zugehörige Histogramme')
xlabel('R1[Ohm]');

%  Schritt 4
% Diese Histogramme müssen Anzahl und bereichsmäßig angepasst werden
% damit beide über eine gemeinsame Basis aufgetragen werden können
% Und die Summe über diese Werte muss wieder 1 ergeben. Das erreicht man 
% dadurch, dass man über diese Werte integriert und durch diesen Integral-
% Wert teilt.
%   -> N_min_t and N_max_t over R_tot


R_tot=linspace(min(R1_min),max(R1_max),n_s); % Stützstellen für beide Verteilungen
N_min_t=interp1(R_pass_pos,N_min,R_tot);     % Interpolieren der Zwischenwerte
N_max_t=interp1(R_fail_pos,N_max,R_tot);

    for i=1:length(N_min_t)
        if isnan(N_min_t(i))
            N_min_t(i)=0;
        end
    end
    
    for i=1:length(N_max_t)
        if isnan(N_max_t(i))
            N_max_t(i)=0;
        end
    end
N_min_t=N_min_t/simpson(R_tot,N_min_t);  % normalisieren Summe =1
N_max_t=N_max_t/simpson(R_tot,N_max_t);

figure
subplot(2,1,1);
    plot(R_tot,N_min_t,'r',R_tot,N_max_t,'b'); grid;
    xlabel('R1 [Ohm]');
    title('Histogramme der normalisierten Werte über und unter dem Mittelwert')
    legend('über', 'unter')


%  Schritt 5
%  Integral über abs(N_max_t - N_min_t) = Statistische Sensitivität

deltaN=abs(N_max_t-N_min_t);
Sens_U1_R1=simpson(R_tot,deltaN); % Statistische Sensitivität U1 von R1

%  Schritt 6
% Die Differenz zwischen den Mittelwerten von N_max_t und N_min_t 
% entspricht dem Schwerpunkt 
CoG_U1_R1=mean(R1_min)-mean(R1_max);          % Centre of Gravity

subplot(2,1,2);
    plot(R_tot,deltaN,'r')
    xlabel(' R1 [Ohm]'); grid;
    title(['Statistische Sensitivität U1/R1= ' num2str(Sens_U1_R1) ' Schwerpunkt= ' num2str( CoG_U1_R1) 'Ohm' ])

% Werte mit der Toolbox-Funktion pfpareto
figure
pfpareto(U1,'U1 []',NaN,NaN,' ',1,0,U0,'Uo', R1,'R1', R2,'R2');

    case 3  
    % 3: Verteilungen bei verschiedenen Berechungen 
    % ---------------------------------------------

     n_s=10000;              % Number of simulations
     AnzKl = n_bins(n_s);	 % Number of bins

    % Parameters
    
    A1_nom=5;           A1_tol=0.2*A1_nom;    A1=rnd_vect(n_s,'uniform',[A1_nom A1_tol/3]);
    A2_nom=3;           A2_tol=0.5*A2_nom;    A2=rnd_vect(n_s,'uniform',[A2_nom A2_tol/3]); 
    A3_nom=2;           A3_tol=0.5*A3_nom;    A3=rnd_vect(n_s,'uniform',[A3_nom A3_tol/3]); 
    A4_nom=2;           A4_tol=1;             A4=rnd_vect(n_s,'uniform',[A4_nom A4_tol]); 
    
    % Functions
    
    Y1=A1+A2+A3+A4;             % Sum
    Y2=A1.*A2.*A3.*A4;          % Product
    Y3=sin(A4);                 % Sin
    Y4=A1.*exp(-A4);            % Exponetional
    
    figure % Parameters
    subplot(2,2,1);
        hist_txt(A1,AnzKl,'A1','',0); grid;
    subplot(2,2,2);
        hist_txt(A2,AnzKl,'A2',' ',0); grid;
    subplot(2,2,3);
        hist_txt(A3,AnzKl,'A3',' ',0); grid;
    subplot(2,2,4);
        hist_txt(A4,AnzKl,'A4',' ',0); grid;
    
     figure  % Functions
    subplot(2,2,1);
        hist_txt(Y1,AnzKl,'Y1',' Y1=A1+A2+A3+A4',0); grid;
    subplot(2,2,2);
        hist_txt(Y2,AnzKl,'Y2',' Y2=A1*2*A3*A4',0); grid;
    subplot(2,2,3);
        hist_txt(Y3,AnzKl,'Y3','Y3=sin(A4)',0); grid;
    subplot(2,2,4);
        hist_txt(Y4,AnzKl,'Y4','Y4=A1*exp(-A4)',0); grid;
        
    case 4
    % 4: Verteilungen der rnd_vect function

    %              type='delta'         : delta distribution (all the same value)
    %              type='uniform'       : uniform distribution
    %              type='discrete'      : uniform discrete distribution
    %              type='normal'        : normal distribution
    %              type='lognormal'     : lognormal distribution
    %              type='large_extreme1': extreme value distr, largest value type I
    %              type='large_extreme2': extreme value distr, largest value type II
    %              type='large_extreme3': extreme value distr, largest value type III
    %              type='small_extreme1': extreme value distr, smallest value type I
    %              type='small_extreme2': extreme value distr, smallest value type II
    %              type='small_extreme3': extreme value distr, smallest value type III
    %              type='weibull'       : weibull distribution

    n_s=10000;              % Number of simulations
    AnzKl = n_bins(n_s);    % Number of bins

    lsl=[];
    usl=12;
x1=rnd_vect(n_s,'delta',10,[],[]);      
x2=rnd_vect(n_s,'uniform',[10 1],[],[]);      
x3=rnd_vect(n_s,'discrete',[1 2],[],[]);      
x4=rnd_vect(n_s,'normal',[10 1],lsl,usl);      
x5=rnd_vect(n_s,'lognormal',[1 1],[],[]);      
x6=rnd_vect(n_s,'large_extreme1',[5 0.5],[],[]);     
x7=rnd_vect(n_s,'large_extreme2',[1 1 5],[],[]);      
x8=rnd_vect(n_s,'large_extreme3',[5 0.5 1],[],[]);      
x9=rnd_vect(n_s,'small_extreme1',[5 0.5],[],[]);      
x10=rnd_vect(n_s,'small_extreme2',[1 1 5],[],[]);      
x11=rnd_vect(n_s,'small_extreme3',[5 0.5 1],[],[]);      
x12=rnd_vect(n_s,'weibull',[1 1 2],[],[]);      


figure 
    subplot(3,4,1);
        hist_txt(x1,AnzKl,'','delta',0); grid;
    subplot(3,4,2);
        hist_txt(x2,AnzKl,'',' uniform',0); grid;    
    subplot(3,4,3);
        hist_txt(x3,AnzKl,'',' discrete',0); grid;    
    subplot(3,4,4);
        hist_txt(x4,AnzKl,'','normal with upper limit',0); grid;    
    subplot(3,4,5);
        hist_txt(x5,AnzKl,'','lognormal',0); grid;
    subplot(3,4,6);
        hist_txt(x6,AnzKl,'','large extreme 1',0); grid;
    subplot(3,4,7);
        hist_txt(x7,AnzKl,'','large extreme 2',0); grid;
    subplot(3,4,8);
        hist_txt(x8,AnzKl,'','large extreme 3',0); grid;
    subplot(3,4,9);
        hist_txt(x9,AnzKl,'','small extreme 1',0); grid;
    subplot(3,4,10);
        hist_txt(x10,AnzKl,'','small extreme 2',0); grid;
    subplot(3,4,11);
        hist_txt(x11,AnzKl,'','small extreme3',0); grid;
    subplot(3,4,12);
        hist_txt(x12,AnzKl,'','weibull',0); grid;
   
    case 5        
    %% 5: Summe von Rechteckverteilungen 
    %-----------------------------------
    n_s=1e4;                        % Number of simulations
    AnzKl = n_bins(n_s);	        % Number of bins 
    N=12;                           % Number of summation-loops
    
     A1_nom=0;                       % mean value
    A1_tol=1;                       % max value
    
     A(1,:)=rnd_vect(n_s,'uniform',[A1_nom A1_tol],[],[]);  
     hist_txt(A(1,:),AnzKl,'','Summe',0); grid;
    for i=2:N
        A(i,:)=A(i-1,:)+rnd_vect(n_s,'uniform',[A1_nom A1_tol],[],[]); 
        figure
        hist_txt(A(i,:),AnzKl,'','Summe',0); grid;
    end
        
    case 6  
    %% 6: Wie findet man die notwendige Werte-Anzahl? 
    %--------------------------------------------------
    % Die Idee ist:
    %  4 Verteilungen A1 bis A4 werden mit steigender Anzahl von Werten n_s addiert
    %  Man wiederholt die Rechnung n-mal und sieht sich die Streuung des
    %  Mittelwertes und der Standard-Abweichung an. Ist die Streuung dieser
    %  Werte sehr klein, dann hat man genügend Werte in der Simulation
    %  Als Mass der Abweichung wird folgende Berechnung benutzt
    %  (max(Werte)-min(Werte))/Mittelwert (Werte)
    
    n_s_1=[5 10 20 40 80 1.2e2 1e3 1e4 1e5 1e6];
    Nns=length(n_s_1);
    n_repeate=100;

for i=1:Nns
     n_s=n_s_1(i);          % Number of simulations
     AnzKl = n_bins(n_s);   % Number of bins

    for k=1:n_repeate
        % Parameters
    
        A1_nom=5;           A1_tol=0.2*A1_nom;    A1=rnd_vect(n_s,'normal',[A1_nom A1_tol/3]);
        A2_nom=3;           A2_tol=0.5*A2_nom;    A2=rnd_vect(n_s,'normal',[A2_nom A2_tol/3]); 
        A3_nom=2;           A3_tol=0.5*A3_nom;    A3=rnd_vect(n_s,'normal',[A3_nom A3_tol/3]); 
        A4_nom=2;           A4_tol=1;             A4=rnd_vect(n_s,'uniform',[A4_nom A4_tol]); 
    
        % Functions
    
        Y1=A1+A2+A3+A4;             % Sum
          
        Ymean(k,i)=mean(Y1);        % mean value
        Ystd(k,i)=std(Y1);          % standard diviation
    end
    
    Ymean_diff(i)=max(Ymean(1:n_repeate,i))-min(Ymean(1:n_repeate,i)); % max spread of mean values
    Ystd_diff(i)= max(Ystd(1:n_repeate,i))-min(Ystd(1:n_repeate,i));    % max spread of standard deviation values
end

dP_mean=100*Ymean_diff./mean(Ymean(1:n_repeate,Nns));   % Relative error of mean values related to each mean value
dP_std=100*Ystd_diff./mean(Ystd(1:n_repeate,Nns));      % Relative error of standard values related to each mean value

figure; 
    semilogx(n_s_1,10*dP_mean,'b*-',n_s_1,dP_std,'r*-'); grid
    xlabel('Number of simulation [-]'); ylabel('rel. Error [%]')
    legend('10*mean value', 'Standard Deviation')

case 7  
    %% 7: Korrelationsmatix Spannungsteiler
    %-------------------------------------
        n_s=1e5;                        % Anzahl Werte
        AnzKl = n_bins(n_s);            % Anzahl Klassen
        nSigma=3;                       % Die Toleranzwerte entsprechen n*Sigama

        % R1
        %---
        R1nom=5000;                     % R1 nominal    [Ohm]
        R1_tol=10/100;                  % Toleranz      [1/100]
        R1std=R1nom*R1_tol/nSigma;      % R1 nominal    [Ohm]

        % R2
        %---
        R2nom=15000;                     % R2 nominal   [Ohm]
        R2_tol=5/100;                    % Toleranz     [1/100]
        R2std=R2nom*R2_tol/nSigma;       % R2 nominal   [Ohm]

        % U0
        %---
        U0nom=10;                       % U0 nominal  [V]
        U0_tol=10/100;                  % Toleranz    [1/100]
        U0std=U0nom*U0_tol/nSigma;      % U0 nominal  [V]

        
            R1=rnd_vect(n_s,'normal',[R1nom R1std],[],[]);
            R2=rnd_vect(n_s,'normal',[R2nom R2std],[],[]);
            U0=rnd_vect(n_s,'normal',[U0nom U0std],[],[]);
            
        U1=R1./(R1+R2).*U0; % Ausgangsspannung
        D=[U1' U0' R1' R2'];
        Corr_D=corrcoef(D)*100;
        figure; 
        XlabelWerte = {'U1';'U0';'R1';'R2'};
        imagesc(Corr_D);
        colormap jet
        caxis([min(min(Corr_D))  max(max(Corr_D))])
        title('Korrelationsmatrix:Spannungsteiler')

        set(gca,'XTick',[1 2 3 4],'XTickLabel',XlabelWerte,'yTick',[1 2 3 4],'YTickLabel',XlabelWerte)
        colorbar;

end % switch
