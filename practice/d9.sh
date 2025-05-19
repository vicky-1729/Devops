#!/bin/bash

# Check whether the user is root or not

if [ "$(id -u)" -eq 0 ]; then
    echo "You are root user"
else
    echo "You are not a root user, use sudo or root user for execution"
    exit 1
fi

# Define colors
r="\e[31m"
g="\e[32m"
y="\e[33m"
m="\e[36m"
reset="\e[0m"

# Check if mysql package is installed
rpm -q mysql &> /dev/null
if [ "$?" -eq 0 ]; then
    echo -e "MySQL is already ${g}installed${reset}, no need to do anything"
    exit 0
else
    echo "MySQL is not installed, so we are going to install it"
    dnf install mysql -y
    if [ "$?" -eq 0 ]; then
        echo -e "${g}MySQL is installed successfully${reset}"
    else
        echo -e "${r}MySQL installation failed${reset}"
        exit 1
    fi
fi
