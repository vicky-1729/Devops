#!/bin/bash

# Check whether the user is root or not

if [ "$(id -u)" -eq 0 ]
then
    echo "You are root user"
else
    echo "You are not a root user, use sudo or root user for execution"
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
