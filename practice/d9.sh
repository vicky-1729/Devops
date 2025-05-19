#!/bin/bash

# Check whether the user is root or not
# Define colors
r="\033[31m"
g="\033[32m"
y="\033[33m"
m="\033[36m"
set="\033[0m"

#checking user has sudo user or not

if [ "$(id -u)" -eq 0 ]
then
    echo -e "You are ${m}root user${set}"
else
    echo -e "You are ${r}not ${m}root user${set}, use sudo or root user for execution"
    exit 1
fi

# Now we are writing script for package installation
dnf list installed mysql
if [ "$?" -eq 0 ]
then
    echo -e "MySQL is ${y}already installed, ${g}no need to do anything${set}"
    exit 1
else
    echo -e "MySQL is ${r}not installed, ${g}so we are going to install it${set}"

    dnf install mysql -y
    if [ "$?" -eq 0 ]
    then
        echo "MySQL is installed successfully"
    else
        echo "MySQL installation failed"
        exit 1
    fi
fi
