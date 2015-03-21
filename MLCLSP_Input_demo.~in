Sets
            k               index of products       / Prod1*Prod5 /
            j               index of resources      / Res1*Res2 /
            t               index of periods        / Per1*Per4 /

Parameters
            h(k)            holding cost of product k per unit and period
             /        Prod1          40.00000000
                      Prod2          35.00000000
                      Prod3          15.00000000
                      Prod4           4.00000000
                      Prod5           3.00000000  /

            z(k)            minimal lead time of product k
             /        Prod1           1.00000000
                      Prod2           1.00000000
                      Prod3           1.00000000
                      Prod4           1.00000000
                      Prod5           1.00000000  /


            s(k)            setup cost of product k
             /        Prod1        200.00000000
                      Prod2        500.00000000
                      Prod3        300.00000000
                      Prod4       1000.00000000
                      Prod5        300.00000000 /

            tp(k)         production time per unit of product k
             /           Prod1         1.0000
                         Prod2         1.0000
                         Prod3         1.0000
                         Prod4         1.0000
                         Prod5         1.0000 /

            ts(k)         setup time of product k
             /           Prod1        20.0000
                         Prod2        30.0000
                         Prod3        10.0000
                         Prod4        20.0000
                         Prod5        10.0000 /


            y_0(k)          inventory of product k in start period
             /        Prod1         50.00000000
                      Prod2        120.00000000
                      Prod3        100.00000000
                      Prod4        110.00000000
                      Prod5         80.00000000 / ;

Table
            a(k,i)          number of units of product k required to produce one unit of product i
                            Prod1          Prod2          Prod3          Prod4          Prod5
             Prod1         0.0000         0.0000         0.0000         0.0000         0.0000
             Prod2         0.0000         0.0000         0.0000         0.0000         0.0000
             Prod3         1.0000         1.0000         0.0000         0.0000         0.0000
             Prod4         1.0000         0.0000         0.0000         0.0000         0.0000
             Prod5         0.0000         0.0000         1.0000         1.0000         0.0000

Table
            C(j,t)          available capacity of resource j in period t
                            Per1           Per2           Per3           Per4
              Res1       150.0000       150.0000       150.0000       150.0000
              Res2       150.0000       150.0000       150.0000       150.0000
Table
            D(k,t)          external demand of product k in period t
                             Per1           Per2           Per3           Per4
             Prod1         10.0000        20.0000        30.0000        80.0000
             Prod2         20.0000        80.0000        50.0000        90.0000
             Prod3          0.0000         0.0000        30.0000         0.0000
             Prod4          0.0000         0.0000         0.0000        80.0000
             Prod5          0.0000         0.0000         0.0000         0.0000;



KJ('Prod1','Res1')=yes;
KJ('Prod2','Res1')=yes;
KJ('Prod3','Res2')=yes;
KJ('Prod4','Res2')=yes;
KJ('Prod5','Res1')=yes;
