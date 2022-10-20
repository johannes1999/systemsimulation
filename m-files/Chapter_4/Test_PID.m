%  Test_PID.m
%
% Die Reglerantwort auf verschiedene Testfunktionen
% Dieser File ist noch in Arbeit!
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
clearvars;  % workspace löschen. Neue matlab-Version nutzt clearvars!
 
% Zeitwerte für die Darstellung von pulsförmigen Signalen
 N=1000;
 t1=0;
 t2=50;
 t_ein=20;
 t_aus=40;
 t=linspace(t1,t2,N);
 dt=t(2)-t(1);
 % Reglerparameter
 Kp=1;      % 
 Ki=0.5;    %
 Kd=1;      %
 Td=0.4;
 Io=0;      % Anfangswert Integrator
 DT1=0;
 % Pulsfunktionen 1
 P1=Puls_fkt(t,t_ein,t_aus,1);
 P2=Puls_fkt(t,t_ein,t_aus,2);
 P3=Puls_fkt(t,t_ein,t_aus,3);
 P4=Puls_fkt(t,t_ein,t_aus,4);
 PID=zeros(N,1);
 PIDT1=zeros(N,1);
 e=P1;
 for i=2:N
 Io=Io+(e(i-1)+e(i))/2*dt;
 P=Kp*e(i-1);
 I=Ki*Io;
 D=(e(i)-e(i-1))/dt;
 DT1=Kd/Td*(e(i)-e(i-1))+DT1*(1-1/Td*dt);
 PID(i)=P+I+D;
 PIDT1(i)=P+I+DT1;
 end
 
 figure

  plot(t,e,'k',t,PID,'r',t,PIDT1,'b');
  %set(gca,'ylim',[0 ymax]);  
  title('PID und PIDT1-Regler');
  grid;
 
%  % Pulsfunktionen 2
%   Amp=1;
%   T=10;
%   samplingrate=100;
%   [tp1,y1]=Pulse1(Amp,T,samplingrate);
%   [tp2,y2]=Pulse2(Amp,T,samplingrate);
%  
%   figure
%   subplot(2,2,1)
%     plot(tp1,y1,'b','linewidth',2);
%     set(gca,'ylim',ymax*[min(y1) max(y1)]);  
%     title('Sin-Puls mit Pre-Puls');
%     xlabel('t [s]')
%     grid;
%   subplot(2,2,2)
%     plot(tp2,y2,'b','linewidth',2);
%     set(gca,'ylim',ymax*[min(y2) max(y2)]);  
%     title('Sin-Puls mit Pre-Puls');
%     xlabel('t [s]')
%     grid;
%     
%  % Periodische Funktionen
%  
%  % Sinus
%  f_sin=0.08;
%  w=2*pi*f_sin;
%  A_sin=sin(w*t);
%  
%  % Rechteck
%  A_rect=sign(sin(w*t));
%  
%  % Dreieck
%  A_tri=2/pi*asin(sin(w*t));
%  
%  % PWM
%  f_pwm=f_sin  ;         % PWM Frequenz  [Hz]
%  DutyCycle=0.8;         % Duty Cycle    [1/100]
%  A_pwm=pwm_t(t,f_pwm,DutyCycle);
%  
%  figure
%   subplot(2,2,1)
%     plot(t,A_sin,'b','linewidth',2);
%     set(gca,'ylim',ymax*[min(A_sin) max(A_sin)]);  
%     title('Sin-Funktion');
%     grid;
%   subplot(2,2,2)
%     plot(t,A_rect,'b','linewidth',2);
%     set(gca,'ylim',ymax*[min(A_rect) max(A_rect)]);  
%     title('Rechteck-Funktion');
%     grid;
%  subplot(2,2,3)
%     plot(t,A_tri,'b','linewidth',2);
%     set(gca,'ylim',ymax*[min(A_tri) max(A_tri)]);  
%     title('Dreieck-Funktion');
%     xlabel('t [s]')
%     grid;
%  subplot(2,2,4)
%     plot(t,A_pwm,'b','linewidth',2);
%     set(gca,'ylim',ymax*[min(A_pwm) max(A_pwm)]);  
%     title('PWM Pulse Width Modulation');
%     xlabel('t [s]')
%     grid;   
%  
%  % Linearer Sweep
%  t0=0;
%  t1=10;
%  f0=0.01;
%  f1=0.1;
%  dt_max=1/(2*f1);
%  
%  [A_sweep,f_sweep] = lin_sweep(t,f0,f1,t0,t1);
%  
%   figure
%   
%   subplot(2,1,1)
%     plot(t,f_sweep,'b','linewidth',2);
%     title('Frequenzänderung über der Zeit');
%     xlabel('t [s]')
%     ylabel('f [Hz]')
%     grid;
%   subplot(2,1,2)
%     plot(t,A_sweep,'r','linewidth',2);
%     set(gca,'ylim',ymax*[min(A_sweep) max(A_sweep)]);  
%     title('Zeitsignal');
%     xlabel('t [s]')
%     grid;  
%     
% % Power Density Mode
% Dfr	    = [10,20,40,800,1000];
% DPSD	= [ 0.01,0.025,0.025,0.0005,0.0005];
% [t_psd,A_psd] = Psd_rnd(Dfr,DPSD,400,2000,1.0);
% 
%  figure
%   subplot(2,1,1)
%     semilogx(Dfr,DPSD,'b','linewidth',2);
%     title('Power Densitiy Signal ');
%     ylabel('A [V²/Hz]') 
%     xlabel('f [Hz]')
%     grid;
%   subplot(2,1,2)
%     plot(t_psd,A_psd,'r','linewidth',2);
%     title('Zugehöriges Zeitsignal ');
%     ylabel('A [V]') 
%     xlabel('t [s]')
%     grid;
