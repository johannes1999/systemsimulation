%  function Diode_fkt.m 
%
% Erklärung 
%
% Berechnet die Diodenkennline nach der Shockley-Gleichung
% I_d=I_s(T)*(exp(U_f/(n*U_T))-1)
%
% Anoden-Kathoden-Spannung oder Flussspannung: U_f
% Strom durch die Diode: I_d   
% Sättigungssperrstrom (kurz: Sperrstrom): I_s(T) ? 10^12 … 10^6 A     
% Emissionskoeffizient: n = 1 … 2
% Temperaturspannung  : U_T   = k*T/q   (ca 25mV bei 20°C)
% T: absoluten Temperatur T_abs    (Absoluter Nullpunkt 273,15 K)
% k: Boltzmannkonstante 1.38064852*10^-23 J/K
% q: Elementarladung    1.6021766208*10^-19 C
%
% Eingabe:          U_f     : Flusspannung [V]
%                   T       : Temperatur [°C]
%
%                   n       : Emissionskoeff.      [-]            
% 		            I_s     : Sättigungssperrstrom [A]
%	
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-03
%
% Änderung: 
%
% siehe auch: test_Diode_fkt
%--------------------------------------------------------------------------
function I_d=Diode_fkt(U_f,T,n,I_s)

% Konstanten
k= 1.38064852*10^-23;   % Boltzmannkonstante  [J/K]
q= 1.6021766208*10^-19; % Elementarladung     [C]
Tabs=273.15;            % Absoluter Nullpunkt [K]

switch nargin
    case 1
        T=20;       % [°C]
        n=1.5;
        I_s=1e-9;   % [A]
    case 2
        n=1.5;
        I_s=1e-9;   % [A]
    case 3
        I_s=1e-9;   % [A]
end
U_T=k*(Tabs+T)/q;
I_d=I_s*(exp(U_f/(n*U_T))-1);
