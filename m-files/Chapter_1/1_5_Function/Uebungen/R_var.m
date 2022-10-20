% Die Function R=R_var(U,ParamVar), ParamVar=[G0,B,n] berechnet den 
%spannungsabhängigen Widerstand eines Varistors.
% Normal wird der Strom als Funktion der Spannung angegeben: I=(U/B)^n*[A]
% siehe Varistor_fkt.m
%
% Hier ist B genau die Spannung, bei der 1 A fließt. n bestimmt die
% Kennliniensteigung und kann Werte bis zu n=20 annehmen.
% In der umgeformten Fassung ist R=U/I=1/(|U|^(n-1)*1/B^n). Damit der
% Widerstand bei U=0 nicht Null ergibt wurde der Leitwert G0 addiert 
% R=U/I=1/(G0+|U|^(n-1)*1/B^n) 1/B^n wurde als K2 bezeichnet
%
% Das wurde so gemacht um eine "einfache nichtlineare" Komponente zu bekommen 
%
% Eingabe:          
%                   ParamVar    : Vektor mit Komponentenparameter
%                   ParamVar(1) : U  Spannungswerte    [V] 	
%                   ParamVar(2) : G0 Konstante         [1/Ohm=S]
%                   ParamVar(3) : B  Konstante         [V]
%                                 Spannung bei der 1A fließt (mit G0=0S)
%
% Ausgabe:          R :	Spannungsabhäniger Widerstand [Ohm]
%
% Autor:	Horst Rumpf
%
%           Dieser m-File wurde im Rahmen der Vorlesung Strukturelle und
%           funktionale Systemsimulation SS 2017 erstellt.
%
% Datum:    2017-04-14
%
% Änderung: 
%
% siehe auch: test_DGL_1; Varistor_fkt.m
%--------------------------------------------------------------------------

function R=R_var(U,ParamVar)

G0=ParamVar(1);
B=ParamVar(2);
n=ParamVar(3);
K2=1/B^n;
R=1./(G0+K2*abs(U).^(n-1));









