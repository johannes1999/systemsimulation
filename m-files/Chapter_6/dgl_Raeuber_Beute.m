% description:		 function Yp = dgl_Raeuber_Beute(t,y,~,gx,ax,gy,ay)
%		 
% DGL-System 
%
% input:	 	t :  Zeit      
%             y(1):  x Beute
%             y(2):  y R�uber
%               gx:  Geburtenrate Beute
%               ax:  Sterberate Beute
%               gy:  Geburtenrate R�uber
%               ay:  Sterberate R�uber
%
% output:		Yp(1): �nderung  der Beute
% 		        Yp(2): �nderung der R�uber
%
% example:	    
%		        
% autor:	   	Horst Rumpf
%
% date:		    25.11.2008
%
% see also:	dynamic_T.m


function Yp = dgl_Raeuber_Beute(~,y,~,gx,ax,gy,ay)
% Erste ~ ist Platzhalter f�r die Zeit und zweite ~ ist Platzhalter f�r die
% options. Der Solver ruft diese function auf und erwartet diese Werte an
% diesen Stellen!
% 
% x'=gx*x-ax*x*y
% y'=-gy*y+ay*x*y

 Yp(1)=gx*y(1)-ax*y(1)*y(2);
 Yp(2)=-gy*y(2) +ay*y(1)*y(2);

Yp=Yp'; % Musss ein Spaltenvektor sein

