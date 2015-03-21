* Einfachstes Seminarzuordnungsmodell mit Links
* Autor: SH
* Stand: 27.1.2015

* Annahme: Möglichst gleichmäßige Verteilung der Studenten auf die Themen!!!!!


set  i Studenten
     j Themen
     l Link
     LI(l,i),LJ(l,j);

parameter
     c(l)  Leid fuer Link l;


$include Seminar_Test_Input.inc

variables Z  Zielfunktionswert;
integer variables x Zuordnung;

Equations
Zielfunktion         Minimierung des Leids
JederEinThema(i)     Jeder Student muss ein Thema erhalten
MaximaleZahlStudentenJeThema(j)
MinimaleZahlStudentenJeThema(j)  ;

Zielfunktion..
     Z =e=   sum(l,c(l)*x(l));

JederEinThema(i)..
     sum(l$LI(l,i), x(l)) =g= 1;

MaximaleZahlStudentenJeThema(j)..
     sum(l$LJ(l,j), x(l)) =l= ceil(card(i)/card(j));

MinimaleZahlStudentenJeThema(j)..
     sum(l$LJ(l,j), x(l)) =g= ceil(card(i)/card(j))-1;

model seminar_v1 /
                 Zielfunktion
                 , JederEinThema
                 , MaximaleZahlStudentenJeThema
                 , MinimaleZahlStudentenJeThema
                 /;


display c;

solve seminar_v1 minimizing Z using mip;

display x.l;


file outputfile1 / 'Seminarzuordnung.txt'/;
put outputfile1;


loop(l,
     loop(i$LI(l,i),
         loop(j$LJ(l,j),
             put l.tl:0, ' ; ' i.tl:0, ' ; ' j.tl:0, ' ; ', x.l(l) /
         );
     );
);

putclose outputfile1;



file outputfile2 / 'Seminar-Zielfunktionswert.txt'/;
put outputfile2;


put 'Zielfunktionswert:  ',z.l /
put '**************************'

putclose outputfile2;






