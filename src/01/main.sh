#!/bin/bash
input=$1
if [ $# = 1 ]; then
    check="^[+-]?[0-9]+([.][0-9]+)?$"
    if [[ $1 =~ $check ]]; then
        echo "Invalid input!";
    else
        echo $1;
    fi
elif [ $# \> 1 ]; then
    echo "Empty input!";
else
    echo should be input;
fi
