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

V(){
    if [ "$1" -eq 0 ]
    then
        echo " $2 is installed successfully " | tee -a "log_files"
    else
        echo " $2 installation failed " | tee -a "log_files"
        exit 1
    fi
}


log_folder="/var/log/shell-scripting-logs"
script_name="(echo $0 | cut -d "." -f1)"
log_files="$log_folder/$script_name.log"
all_packages=("MySQL" "JAVA" "nginx" "python3")
# Now we are writing script for package installation mysql,nginx


mkdir -p log_folder
echo "printing the current time $(date)" &>> log_files



for package in ${all_packages[@]} 
do
    dnf list installed $package
    if [ "$?" -eq 0 ]
then
    echo -e "$packageis ${y}already installed, ${g}no need to do anything${set}" &>> log_files
    exit 0
else
    echo -e "$package is ${r}not installed, ${g}so we are going to install it${set}" &>> log_files
    dnf install mysql -y
    V $? "$package" 
fi
done



dnf list installed mysql
if [ "$?" -eq 0 ]
then
    echo -e "MySQL is ${y}already installed, ${g}no need to do anything${set}" &>> log_files
    exit 0
else
    echo -e "MySQL is ${r}not installed, ${g}so we are going to install it${set}" &>> log_files
    dnf install mysql -y
    V $? "MySQL" 
fi

# instead of &== use tee comamnd


dnf list installed nginx &>> log_files
if [ "$?" -eq 0 ]
then
    echo "nginx installed alreday no need do anything" | tee -a log_files
    exit 0
else
    cho "nginx not installed ,wait for few sec , installing in prgress " | tee -a "log_files"
    dnf install nginx -y
    v $? "nginx"

fi

    




