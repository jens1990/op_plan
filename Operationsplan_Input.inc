sets i / 
OP1
OP2
/

j / 
ORT
MOV
NEU
ONC
/

k / 
Mon 
Tue 
Wed 
Thu 
Fri 
/;

IJ(i,j) = no;

IJ('OP1','MOV') = yes;

IJ('OP2','ORT') = yes;

IJ('OP2','MOV') = yes;

IJ('OP2','ONC') = yes;

IJ('OP1','NEU') = yes;



parameters
a(i) /
OP1 2
OP2 3
/

tetaIPT /100/ 
tetaOPT /100/ 
Beta /0.5/ 
;
scalar 
s /6/

table 
e(j,k) 
		Mon		Tue		Wed		Thu		Fri		
ORT		0		0		0		0		0
MOV		0		7		0		0		0
NEU		0		0		0		0		0
ONC		0		0		0		0		0

table 
n(j,k) 
		Mon		Tue		Wed		Thu		Fri		
ORT		50		0		0		0		0
MOV		0		0		0		0		0
NEU		0		0		0		0		0
ONC		0		0		0		0		34

table 
o(j,k) 
		Mon		Tue		Wed		Thu		Fri		
ORT		0		0		0		0		0
MOV		0		0		45		0		0
NEU		0		0		0		52		0
ONC		0		0		0		0		0

table 
c(j,k) 

		Mon		Tue		Wed		Thu		Fri		
ORT		3		3		3		3		3		
MOV		5		5		5		5		5		
NEU		2		2		2		2		2		
ONC		3		3		3		3		3		


table 
rho(k,l) 

              Mon        Tue        Wed        Thu        Fri        
 Mon          7          1          2          3          4
 Tue          6          7          1          2          3
 Wed          5          6          7          1          2
 Thu          4          5          6          7          1
 Fri          3          4          5          6          7

table 
lambda(k,l) 

              Mon        Tue        Wed        Thu        Fri        
 Mon          7          1          2          3          4
 Tue          6          7          1          2          3
 Wed          5          6          7          1          2
 Thu          4          5          6          7          1
 Fri          3          4          5          6          7

scalar 
cal /2/

