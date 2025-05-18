#!/bin/bash
number=$1
echo "number is $number"
if [ $number -gt 10 ]; 
then
    echo "number is greater than 10"
else
    echo "number is less than 10"
fi
