% Puls_fkt.m 
% ist ein function die verschiedene Pulsformen erzeugt. Der Puls kan
% zeitlich verschoben sein. Als Zeitwert können eine einzelwert oder
% ein Zeit-Vektor eingegeben werden. 
%
% Testsignale
% Parameter 
% t           : Zeit Einzelwert oder Vektor   [s] 
% t_ein       : Anfang des Pulses             [s]
% t_aus       : Ende des Pulses               [s]
%                         
% form        :   1: Rechteck Puls
%                 2: Cos-Puls
%                 3: Dreieck-Puls
%                 4: Sägezahn-Puls
%
% Ausgabe
% P : Pulsform [-]
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-03-29
%
% Änderung: 
%
% siehe auch: Test_Test_fkt.m
%--------------------------------------------------------------------------
 
function P = Puls_fkt(t,t_ein,t_aus,form)

% Der Rechteckimpuls dient aus Ausgangsform für die anderen Pulsformen
T_2=t_aus-t_ein;
w=pi/T_2;
S=w*(t_aus+t_ein)/2;
Po=1/2*((sign(t-t_ein))-sign(t-t_aus));

 if form==1
 % Rechteck-Puls    
   P=Po;
 elseif form==2
 % cos-Puls
   P=cos(w*t-S).*Po;
 elseif form==3 
 % Dreieck-Puls    
   P=-2/pi*asin(sin(w*t-(S+pi/2))).*Po;
 elseif form==4 
 % Zägezahn-Puls
   P=1/(T_2)*(max((t-t_ein),0)-max((t-t_aus),0))-sign(max((t-t_aus),0));  
 end   