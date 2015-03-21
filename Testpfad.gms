*Testfile für Gams

set
t        Test /Erfolg/;

file test / 'test.txt'/;
put test
loop(t,
put t.tl);

putclose test;