% Die Function I=Varistor_fkt(U,B,n) berechnet die Varistorkennline
%  I=sign(U)*(|U|/B)^n*1[A]
% Hier ist B genau die Spannung, bei der 1 A fließt. n bestimmt die
% Kennliniensteigung und kann Werte bis zu n=20 annehmen. 
%
% Eingabe:          
%                   U :  Spannungswerte    [V] 	
%                   B :  Konstante         [V]
%                        Spannung bei der 1A fließt
%                   n :  Kennliniensteigung [-]
%
% Ausgabe:          I :	Strom [A]
% 		
%	
% autor:	Horst Rumpf
%
% date:		2017-03-10
%           2018-02-26 Betrag und Vorzeichen eingeführt
%
% siehe auch: H_UE_01	

function I=Varistor_fkt(U,B,n)
I=sign(U).*(abs(U)/B).^n; % Strom [A]








