# 208-lab-test
Shell scripts to test labs for CSC-208

DLTest.SH
---------

dltest.sh allows for quick shell testing of a given function for Datalab.
First, get it in your Datalab directory. 
Then, from that directory you can just run:

sh dltest.sh <FUNCTION_NAME>

Where <FUNCTION_NAME> is the non-case sensitive name of the function in bits.c
to test. eg:

sh dltest.sh logicalshift

or:

sh dltest.sh Float_I2F

Every test case is an array element because I'm tired and lazy, 
so mess around with them if you want. 
You can also use chmod to make it feel like a nice, reasonable program as per:
https://askubuntu.com/questions/229589/how-to-make-a-file-e-g-a-sh-script-executable-so-it-can-be-run-from-a-termi
