#!/bin/bash

dnf install ansible -y
anisble  pull -U  https://github.com/daws-84s/ansible-roboshop-roles.git -e component = $1 main.yml