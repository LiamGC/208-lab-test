#!/bin/bash

# dltest.sh
# datalab test by Liam.
# i know this script is terrible. so what?

if [ $# -eq 0 ]
then
    echo "test.sh error: no function name called.";
    exit 1;
fi

# accept no params
functions[0]="tmin"
# accept (int x)
functions[1]="bitcount"
functions[2]="bang"
functions[3]="negate"
functions[4]="ispositive"
functions[5]="ilog2"
functions[6]="float_neg"
functions[7]="float_i2f"
functions[8]="float_twice"
# accept (int x, int n), where a <= n <= b
functions[9]="getbyte"
functions[10]="logicalshift"
functions[11]="fitsbits"
functions[12]="divpwr2"
# accept (int x, int y)
functions[13]="bitand"
functions[14]="islessorequal"

# identify number of function to test
F_NUM=-1
for i in {0..14}
do
    # compare lower(argument) to known names
    if [ ${1,,} = ${functions[${i}]} ]
    then
        F_NUM=$i;
    fi
done

if [ $F_NUM -eq -1 ]
then
    echo "test.sh error: function not found.";
    exit 2;
fi  

# setup btest
clear
make clean
make btest

# array of constant test args
A[0]=0
A[1]=-1
A[2]=2048
A[3]=-1000000000
A[4]=0xAAAAAAAA
A[5]=0x55555555
A[6]=0x22222222
A[7]=0x80000000
A[8]=0x12345678
A[9]=0x88664422
A[10]=0xBC637EFF

# array of constant test values for n
N_VALS[0]=0
N_VALS[1]=1
N_VALS[2]=2
N_VALS[3]=3
N_VALS[4]=4
N_VALS[5]=11
N_VALS[6]=24
N_VALS[7]=30
N_VALS[8]=31
N_VALS[9]=32

echo ;

# test function 0 with no params:
if [ $F_NUM -eq 0 ]
then
    ./btest bits.c -f tmin;
    echo ;
    ./dlc -e bits.c
    exit 0;
fi

# test functions 1-14.
# i hope you like magic numbers
for i in "${A[@]}"
do  
    if [ $F_NUM -lt 9 ]
    then

        # test functions 1-8 with (int) param
        echo $i;
        case $F_NUM in
            1) ./btest bits.c -f bitCount -1 $i;;
            #TODO
            2) ./btest bits.c -f bang -1 $i;;
            3) ./btest bits.c -f negate -1 $i;;
            #TODO
            4) ./btest bits.c -f isPositive -1 $i;;
            #TODO
            5) ./btest bits.c -f ilog2 -1 $i;;
            #TODO
            6) ./btest bits.c -f float_neg -1 $i;;
            #TODO
            7) ./btest bits.c -f float_i2f -1 $i;;
            #TODO
            8) ./btest bits.c -f fleat_twice -1 $i;;
        esac
        echo ;

    elif [ $F_NUM -lt 13 ]
    then

        # test #9-12 with (int x, int n) params
        for j in "${N_VALS[@]}"
        do

            if [ $F_NUM -eq 9 ] && [ $j -lt 4 ]
            then # 0 <= n <= 3
                echo $i $j;
                ./btest bits.c -f getByte -1 $i -2 $j;
                echo ;
            elif [ $F_NUM -eq 10 ] && [ $j -lt 32 ]
            then # 0 <= n <= 31
                echo $i $j;
                ./btest bits.c -f logicalShift $i -2 $j;
                echo ;
            elif [ $F_NUM -eq 11 ] && [ $j -gt 0 ]
            then # 1 <= n <= 32
                #TODO
                echo $i $j;
                ./btest bits.c -f fitsBits $i -2 $j;
                echo ;
            elif [ $F_NUM -eq 12 ] && [ $j -lt 31 ]
            then # 0 <= n <= 30
                #TODO
                echo $i $j;
                ./btest bits.c -f divpwr2 $i -2 $j;
                echo ;
            fi
        done

    else

        # test #13-14 with (int x, int y) params
        for j in "${A[@]}"
        do
            echo $i $j;
            case $F_NUM in
                13) ./btest bits.c -f bitAnd -1 $i -2 $j;;
                #TODO
                14) ./btest bits.c -f isLessOrEqual -1 $i -2 $j;;
            esac
            echo ;
        done

    fi
done

./dlc -e bits.c