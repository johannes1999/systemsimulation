%  	M-File: function T=rotation(theta, ebene)
%
%	Rotation eines lokalen Koordinatensystems
%	
%			
%  input:	theta	Drehwinkel [Rad]			
%		    ebene	ebene=[] oder 
%           ebene=0                     Zweidimensionaler Fall 
%           ebene=1                     Drehen in der x-y Ebene
%			ebene=2			            Drehen in der x-z Ebene
%			ebene=3			            Drehen in der y-z Ebene
%                        
%
%  output:	rotation(theta)*Object mit Object=[x1 x2 x3
%						                       y1 y2 y3
%						                       z1 z2 z3] 
%			
%  example:	rotation(pi)*[ 1  2  3; 1  2  3; 1 2 3]
%			=    [-1 -2 -3;-1 -2 -3; 1 2 3]
%		
%  copyright:	Philips GmbH, Automotive Playback Modules, (c) 2000
%  author:	    APM-IP, Horst Rumpf
%  version:	    0.0.1 (MATLAB 4.0)
%  date:	    95-04-07
%		        2000-03-02 drehen in x-z und y-z zugefügt
%               2011-12-02 zweidimensionaler Fall zugefügt
%  See also: 	trlate


function T=rotation(theta, ebene)

if nargin==1	% Ist keine Ebene definiert so wird um xy-Ebene gedreht
 ebene=1;
end

if ebene==0

T=[cos(theta) -sin(theta) 
   sin(theta)  cos(theta)];
    
elseif ebene==1
T=[cos(theta) -sin(theta) 0
   sin(theta)  cos(theta) 0
   0           0          1];

elseif ebene==2

T=[cos(theta)	0	-sin(theta)
   0   		1	0
   sin(theta)	0	cos(theta)]; 

elseif ebene==3

T=[1	0		0	
   0   	cos(theta)	-sin(theta)
   0	sin(theta)	cos(theta)]; 


end