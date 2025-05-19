#!/bin/bash

#we will use colors

echo "vsvicky printig with colors"

echo -e " your name is \e[31m vs \e[32m vicky"

echo -e " \e[33m mysql\e[0m is \e[32minstalled \e[31msucesffully\e[0m bro..!"

red="\e[31m"
green="\e[32m"
yellow="\e[33m"
megenta="\e[36m"

echo -e "$red wipro $green is $yellow good $megenta company"

echo -e "$red vicky $green is $yellow good $megenta boy"