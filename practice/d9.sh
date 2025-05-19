#!/bin/bash

# Check whether the user is root or not
# Define colors
r="\e[31m"
g="\e[32m"
y="\e[33m"
m="\e[36m"
set="\e[0m"

#checking user has sudo user or not

if [ "$(id -u)" -eq 0 ]
then
    echo "You are ${m}root user${set}"
else
    echo "You are ${r}not ${m}root user${set}, use sudo or root user for execution"
    exit 1
fi

# Now we are writing script for package installation
dnf list installed mysql
if [ "$?" -eq 0 ]
then
    echo "MySQL is already installed, no need to do anything"
    exit 1
else
    echo "MySQL is not installed, so we are going to install it"

    dnf install mysql -y
    if [ "$?" -eq 0 ]
    then
        echo "MySQL is installed successfully"
    else
        echo "MySQL installation failed"
        exit 1
    fi
fi
