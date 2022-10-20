%  Test_Test_fkt.m
%
% In diesem m-file werden verschiedene Testfunktionen für die Untersuchung
% von realen Systemen vorgestellt. 
% Diese Funktionen sind auch hilfreich bei der Untersuchung von DGls.
%
%  1. Pulsförmige Funktionen
%     Die pulsförmigen Fkten wurden in einer function zusammengefasst
%     Puls_fkt(t,t_ein,t_aus,form)
%               form:     1: Rechteck Puls
%                         2: Cos-Puls
%                         3: Dreieck-Puls
%                         4: Sägezahn-Puls
%     Zwei mittelwertfreie Pulsfunktionen können mit folgenden functions
%     erstellt werden:
%                       Pulse1(Amp,T,samplingrate): Sin-Puls mit Pre-Puls
%                       (Pulse2(Amp,T,samplingrate): nicht überprüft!)
%
% 	2. Periodische Funktionen	
%       Sinus
%       Rechteck
%       Dreieck
%       PWM (Pulsweitenmodulation oder Pulse Width Modulation)
%
%   3. Lineare Sweep-Funktion
%       
%   4. Power Density Funktion
%
%
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-16
%
% Änderung: 
%
% siehe auch: 
%--------------------------------------------------------------------------
close all;  % Alle plots schliessen
clearvars;  % workspace löschen
 
% Zeitwerte für die Darstellung von pulsförmigen Signalen
 N=400;
 t1=0;
 t2=50;
 t_ein=20;
 t_aus=40;
 t=linspace(t1,t2,N);
 
 % Pulsfunktionen 1
 P1=Puls_fkt(t,t_ein,t_aus,1);
 P2=Puls_fkt(t,t_ein,t_aus,2);
 P3=Puls_fkt(t,t_ein,t_aus,3);
 P4=Puls_fkt(t,t_ein,t_aus,4);
 
 figure
 ymax=1.05;
 subplot(2,2,1)
  plot(t,P1,'b','linewidth',2);
  set(gca,'ylim',[0 ymax]);  
  title('Rechteck - Puls');
  grid;
 subplot(2,2,2)
  plot(t,P2,'b','linewidth',2);
  set(gca,'ylim',[0 ymax]);  
  title('Cos - Puls');
  grid;
 subplot(2,2,3)
  plot(t,P3,'b','linewidth',2);
  set(gca,'ylim',[0 ymax]);  
  title('Dreieck - Puls');
  xlabel('t [s]')
  grid;
 subplot(2,2,4)
  plot(t,P4,'b','linewidth',2);
  set(gca,'ylim',[0 ymax]);  
  title('Sägezahn - Puls');
  xlabel('t [s]')
  grid;
  
 % Pulsfunktionen 2
  Amp=1;
  T=10;
  samplingrate=100;
  [tp1,y1]=Pulse1(Amp,T,samplingrate);
  [tp2,y2]=Pulse2(Amp,T,samplingrate);
 
  figure
  subplot(2,2,1)
    plot(tp1,y1,'b','linewidth',2);
    set(gca,'ylim',ymax*[min(y1) max(y1)]);  
    title('Sin-Puls mit Pre-Puls');
    xlabel('t [s]')
    grid;
  subplot(2,2,2)
    plot(tp2,y2,'b','linewidth',2);
    set(gca,'ylim',ymax*[min(y2) max(y2)]);  
    title('Sin-Puls mit Pre-Puls');
    xlabel('t [s]')
    grid;
    
 % Periodische Funktionen
 
 % Sinus
 f_sin=0.08;
 w=2*pi*f_sin;
 A_sin=sin(w*t);
 
 % Rechteck
 A_rect=sign(sin(w*t));
 
 % Dreieck
 A_tri=2/pi*asin(sin(w*t));
 
 % PWM
 f_pwm=f_sin  ;         % PWM Frequenz  [Hz]
 DutyCycle=0.8;         % Duty Cycle    [1/100]
 A_pwm=pwm_t(t,f_pwm,DutyCycle);
 
 figure
  subplot(2,2,1)
    plot(t,A_sin,'b','linewidth',2);
    set(gca,'ylim',ymax*[min(A_sin) max(A_sin)]);  
    title('Sin-Funktion');
    grid;
  subplot(2,2,2)
    plot(t,A_rect,'b','linewidth',2);
    set(gca,'ylim',ymax*[min(A_rect) max(A_rect)]);  
    title('Rechteck-Funktion');
    grid;
 subplot(2,2,3)
    plot(t,A_tri,'b','linewidth',2);
    set(gca,'ylim',ymax*[min(A_tri) max(A_tri)]);  
    title('Dreieck-Funktion');
    xlabel('t [s]')
    grid;
 subplot(2,2,4)
    plot(t,A_pwm,'b','linewidth',2);
    set(gca,'ylim',ymax*[min(A_pwm) max(A_pwm)]);  
    title('PWM Pulse Width Modulation');
    xlabel('t [s]')
    grid;   
 
 % Linearer Sweep
 t0=0;
 t1=10;
 f0=0.01;
 f1=0.1;
 dt_max=1/(2*f1);
 
 [A_sweep,f_sweep] = lin_sweep(t,f0,f1,t0,t1);
 
  figure
  
  subplot(2,1,1)
    plot(t,f_sweep,'b','linewidth',2);
    title('Frequenzänderung über der Zeit');
    xlabel('t [s]')
    ylabel('f [Hz]')
    grid;
  subplot(2,1,2)
    plot(t,A_sweep,'r','linewidth',2);
    set(gca,'ylim',ymax*[min(A_sweep) max(A_sweep)]);  
    title('Zeitsignal');
    xlabel('t [s]')
    grid;  
    
% Power Density Mode
Dfr	    = [10,20,40,800,1000];
DPSD	= [ 0.01,0.025,0.025,0.0005,0.0005];
[t_psd,A_psd] = Psd_rnd(Dfr,DPSD,400,2000,1.0);

 figure
  subplot(2,1,1)
    semilogx(Dfr,DPSD,'b','linewidth',2);
    title('Power Densitiy Signal ');
    ylabel('A [V²/Hz]') 
    xlabel('f [Hz]')
    grid;
  subplot(2,1,2)
    plot(t_psd,A_psd,'r','linewidth',2);
    title('Zugehöriges Zeitsignal ');
    ylabel('A [V]') 
    xlabel('t [s]')
    grid;
