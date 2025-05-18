#!/bin/bash

#check wheather the user is root or not 

if [ "$(id -u)" -eq 0 ]
then
    echo "your are root user"
else
    echo "your are not a root ,use sudo or root user for exctution"
    exit 1
fi