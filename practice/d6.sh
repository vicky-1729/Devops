#!/bin/bash

echo "now we are going to install the packages of mysql"

if [ "$(id -u)" -ne 0 ]
then
    echo "Please run as root"
    exit 1
else
    echo "You are root"
fi

dnf list installed mysql
if [ "$?" -eq 0 ]
then
    echo "mysql is already installed"
else
    echo "mysql is not installed"
    echo "installing mysql"
    dnf install mysql-server -y

    if [ "$?" -eq 0 ]
    then
        echo "mysql is installed successfully"
    else
        echo "mysql installation failed"
        exit 1
    fi
fi



