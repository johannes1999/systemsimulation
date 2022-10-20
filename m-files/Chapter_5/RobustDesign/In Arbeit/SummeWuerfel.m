% Summe_verteilung.m   	
%
% Beispiel Würfel
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung strukturelle und
%           funktionale Systemsimulation SS 2020 erstellt.
%
% Datum:    2018-07-21
%
% Änderung: 
%
% siehe auch: 
%----------------------------------------------------------------------

clearvars;
close all;

Fall=1; % 1: Würfeln
        % 2: 10 Gleichverteilungen
        % 3: tan
switch Fall
    
    case 1
    %% Würfeln
        N_wuerfe=1e6;
        N_Wuerfel=10;
        W=randi([1 6],N_Wuerfel,N_wuerfe);
        figure; 
        for i=1:N_Wuerfel
            if i==1
                histogram(W(1,:),'Normalization','probability');
                title('Ein Würfel')
            else    
                histogram(sum(W(1:i,:)),'Normalization','probability');
                 % histogram(sum(W(1:i,:)),'Normalization','cdf');
                 
                title([num2str(i) ' Würfel'])
                
            end
            pause(0.1);
        end
    case 2
    %% 10 Gleichverteilungen addieren
    %---------------------------------
    
    n_s=1e6;                        % Number of simulations
    AnzKl =n_bins(n_s);	        % Number of bins 
    N=10;                           % Number of summation-loops
    
    A1_nom=10;                       % mean value
    A1_tol=1;                       % max value
    
     A=rnd_vect(n_s,'uniform',[A1_nom A1_tol],[],[]);  
     figure
     hist_txt(A,AnzKl,'R [k\Omega]','Summe',0); grid;
    for i=2:N
        A=A+rnd_vect(n_s,'uniform',[A1_nom A1_tol],[],[]); 
        
    end
    
    [N_h,x_h]=hist(A,AnzKl);
    N_h_rel=N_h/n_s;
     A_mean=mean(A);
     A_std= std(A);
        dx=0.01;
        x=90:0.01:110;
        p = p_gauss(x,A_std,A_mean);
        Sg=csimpson(x,p);
        Sd=cumsum(N_h_rel);
        x_h_n(1:2:2*AnzKl-1)=x_h;
        x_h_n(2:2:2*AnzKl)=x_h;
         y_h_n(1)=Sd(1);
        y_h_n(2:2:2*AnzKl-1)=Sd(2:end);
        y_h_n(3:2:2*AnzKl)=Sd(2:end);
        y_h_n(2*AnzKl)=Sd(end);
    
    figure
     subplot(2,1,1)
        bar(x_h,N_h_rel,0.5,'b');
        title('Wahrscheinlichkeitsfunktion') 
        xlabel('U [V]')
        ylabel('f(U)')
        grid
    subplot(2,1,2)
       
        plot(x_h_n,y_h_n,'r');
        title('Verteilungsfunktion') 
        xlabel('U [V]')
        ylabel('F(U)')
        grid
        
    figure
     subplot(2,1,1)
        plot(x,p,'b')
        title('Wahrscheinlichkeitsdichtefunktion') 
        xlabel('U [V]','FontSize',10)
        ylabel('f(U)','FontSize',10)
        grid
    subplot(2,1,2)
        %bar(x_h,cumsum(N_h_rel),0.5);
        plot(x,Sg,'r');
        title('Verteilungsfunktion') 
        xlabel('U [V]','FontSize',10)
        ylabel('F(U)','FontSize',10)
        grid    
    
    figure
      bar(x_h,N_h_rel,0.5);
      hold 
      plot(x,p*(x_h(2)-x_h(1)),'r')
      title('Wahrscheinlichkeits- und Dichte-Funktion') 
      xlabel('U [V]','FontSize',10)
      ylabel('F(U)','FontSize',10)
      grid
      
    figure
      bar(x_h,N_h_rel,0.5);
      hold 
      plot(x,p*(x_h(2)-x_h(1)),'r',A_mean+3*A_std*[-1 -1], 0.015*[0 1],'r -.',A_mean+3*A_std*[1 1], 0.015*[0 1],'r -.')
      title('Reihenschaltung von 10 Widerständen') 
      
      xlabel('R_{ges} [k\Omega]')
      ylabel('f(R)')
      grid  
      
      
    figure
    plot(x,Sg,x_h, cumsum(N_h_rel))
    case 3
    %% tan(a/b)
    %---------------------------------
     
    n_s=1e6;                        % Number of simulations
    AnzKl =n_bins(n_s);	        % Number of bins 

    a=rnd_vect(n_s,'normal',[5 0.5],[],[]);
    b=rnd_vect(n_s,'normal',[10 2],[],[]);
    Al=atan(a./b);
    figure
    subplot(2,2,1)
     hist_txt(a,AnzKl,'a [m]',' ',0); grid;
    subplot(2,2,2)
     hist_txt(b,AnzKl,'b [m]',' ',0); grid;
    subplot(2,2,3)
     hist_txt(Al*180/pi,AnzKl,'\alpha [°]',' ',0); grid;
end % case