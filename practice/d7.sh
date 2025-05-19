#!/bin/bash

#check wheather the user is root or not 

if [ "$(id -u)" -eq 0 ]
then
    echo "your are root user"
else
    echo "your are not a root ,use sudo or root user for exctution"
    exit 1
fi


# now we are weiring script for package installation
dnf list installed | grep mysql
if [ "$?" -eq 0 ]
then
    echo "mysql is already installed no need to anything"
    exit 1
else
    echo "mysql is not installed ,so we are going to install it"

    dnf install mysql -y
    if [ "$?" -eq 0 ]
    then
        echo "my sql is installed suceesfully"
    else
        echo "mysql is not installed"
        exit 1
    fi
fi
