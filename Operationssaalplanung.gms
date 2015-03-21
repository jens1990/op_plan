*Ein gemischt ganzzahliger Optimierungsansatz zur Zuweisung von Operationssaelen

sets
         i       Art des Operationssaals
         j       medizinisches Fachgebiet
         k       Tage;

alias (k,l);
alias (j,j1);

set
IJ (i,j)         Operationssaal-Fachgebiet Relation


parameters
         s               Anzahl verfuegbarer Arbeitsstunden pro Tag
         a(i)            Anzahl Operationsraeume von Typ i
         e(j,k)          Operationsbedarf der durch Notfallpatienten des Fachgebiets j an Tag k entsteht
         n(j,k)          Operationsbedarf der durch stationaere Patienten des Fachgebiets j an Tag k entsteht
         o(j,k)          Operationsbedarf der durch ambulante Patienten des Fachgebiets j an Tag k entsteht
         c(j,k)          Maximale Anzahl an Operationssaelen die fuer Fachgebiet j an Tag k genutzt werden kann
         rho(k,l)        Bestrafungsfaktor fuer die Verschiebung stationaerer Operationsnachfrage von Tag k nach Tag l
         lambda(k,l)     Bestrafungsfaktor fuer die Verschiebung von ambulanter Operationsnachfrage von Tag k nach Tag l
         tetaIPT         Bestrafungsrate fuer nicht erfuellte Nachfrage stationaerer Patienten
         tetaOPT         Bestrafungsrate fuer nicht erfuellte Nachtfrage ambulanter Patienten
         Beta            Bestrafungsrate fuer Unterversorgung einer medizinischen Fachrichtung mit Operationssaalstunden

variables
         Ziel            Zielfunktionswert;

integer variable
         x(i,j,k)        Anzahl von Operationssaelen des Typs i die Fachgebiet j an Tag k zugeordnet sind;

positive variables
         y(j,k)          Erfuellte Notfalloperationszeit des Fachgebiets j im Notfalloperationssaal an Tag k
         z(j,k,l)        Operationsbedarf stationaerer Patienten des Fachgebiets j der von k nach l verschoben wird
         w(j,k,l)        Operationsbedarf ambulanter Patienten des Fachgebiets j der von k nach l verschoben wird
         u(j,k)          Nicht erfuellter Operationsbedarf stationaerer Patienten des Fachgebiets j an Tag k
         v(j,k)          Nicht erfuellter Operationsbedarf ambulanter Patienten des Fachgebiets j an Tag k
         b(j,k)          Ungenutzte verfuegbare Operationszeit des dem Fachgebiet j zugeordneten Operationssaals an Tag k
         h               Gesamte ungenutzte Operationszeit aller nicht Notfalloperationssaele
         p(j)            Ueberschuss an Fachgebiet j zugeordneter Operationszeit in Relation zum Sollzustand
         q(j)            Unterversorgung an Fachgebiet j zugeordneter Operationszeit in Relation zum Sollzustand;


$include Operationsplan_Input.inc
*$include "C:\Sites\omapps2\Operationsplan_Input.inc";
*$include "C:\Users\Andre\Dropbox\UNI\7. Semester\GAMS\SeminararbeitDaten1.inc";



equations
         Zfkt            Zielfunktion
         Saalzuw(i,k)    Garantiert dass alle Operationssaele einem Fachgebiet an Tag k zugeordnet sind
         Kap(j,k)        Kapazitaetsrestriktion bzgl der Operationsnachfrage
         Zeitraum(j,k)   Restriktion ueber die maximale Zeit die eine Operation verschoben werden darf
         Verstat(j,k)    Restriktion dass hoechstens so viel stationaere Operationszeit verschoben wird wie vorhanden
         Veramb(j,k)     Restriktion dass hoechstens so viel ambulante Operationszeit verschoben wird wie vorhanden
         unmetstat(j,k)  Menge nicht durchgefuehrter stationaerer Operationen kann vorhandene Operationsmenge nicht uebersteigen
         unmetamb(j,k)   Menge nicht durchgefuehrter ambulanter Operationen kann vorhandene Operationsmenge nicht uebersteigen
         Inakt           Gesamte Inaktivitaet von Operationssaelen
         Effizienz(j)    Vergleich auftretender inaktiver Zeit des Operationssaals der Gebiet j zugeordnet ist mit Sollwert
         Arbeit(k)       Restriktion ueber maximale verfuegbare Arbeitszeit
         Zuord(j,k)      Fachgebietspatient j soll moeglichst dem jeweiligen Operationssaal zugeordnet werden
         Notf(j,k)       Verfuegbarer Notfalloperationsraum soll Bedarf nicht uebersteigen;


Zfkt             ..      Ziel  =e= sum(k,sum(l,rho(k,l)*sum(j,z(j,k,l))))
                       + sum(k,sum(l,lambda(k,l)*sum(j,w(j,k,l))))
                       + tetaIPT*sum(j,sum(k,u(j,k)))
                       + tetaOPT*sum(j,sum(k,v(j,k)))
                       + Beta*sum(j,q(j));


Saalzuw(i,k)     ..      sum(j$IJ(i,j),x(i,j,k)) =e= a(i);
Kap(j,k)         ..      s*sum(i$IJ(i,j),x(i,j,k)) =g= e(j,k) - y(j,k) + sum(l,z(j,l,k)+w(j,l,k));
Zeitraum(j,k)    ..      s*sum(i$IJ(i,j),x(i,j,k)) - (e(j,k) - y(j,k) + sum(l,z(j,l,k)+w(j,l,k)))
                         - b(j,k) + sum(l,z(j,k,l)+w(j,k,l)) + (u(j,k)+v(j,k))
                         =e= n(j,k) + o(j,k);
Verstat(j,k)     ..      sum(l,z(j,k,l)) =l= n(j,k);
Veramb(j,k)      ..      sum(l,w(j,k,l)) =l= o(j,k);
unmetstat(j,k)   ..      u(j,k) =l= n(j,k);
unmetamb(j,k)    ..      v(j,k) =l= o(j,k);
Inakt            ..      h =e= sum(j,sum(k,b(j,k)));
Effizienz(j)     ..      sum(k,b(j,k)) - (h*sum(k,n(j,k)+o(j,k)))/sum(j1,sum(k,n(j,k)+o(j,k)))
                         =e= p(j) - q(j);
Arbeit(k)        ..      sum(j,y(j,k)) =l= s;
Zuord(j,k)       ..      sum(i$IJ(i,j),x(i,j,k)) =l= c(j,k);
Notf(j,k)        ..      y(j,k) =l= e(j,k);



model Operationssaal /all/;

solve Operationssaal minizing Ziel using MIP;

file result /result.gdx/;

execute_unload 'Result'x.l x.m;
execute 'gdxxrw.exe result.gdx var=x.l';


file outputfile1 / 'Saalzuordnung.txt'/;
put outputfile1;

loop(k,
         loop(i,
                 loop(j$IJ(i,j),
                         put  cal, ';', k.tl:0, ';',  i.tl:0, ';' j.tl:0, ';', x.l(i,j,k):0 /
         );
     );
);

 putclose outputfile1;


file outputfile2 / 'Saalzuordnung_Statistik.txt'/;
put outputfile2;

loop(j,
         loop(k,
                         put  cal, ';', j.tl:0';', k.tl:0, ';',  u.l(j,k):0, ';' v.l(j,k):0, ';', b.l(j,k):0 /
         );
     );


putclose outputfile2;


file outputfile3 / 'Success.txt'/;
put outputfile3;

put cal;

putclose outputfile3;