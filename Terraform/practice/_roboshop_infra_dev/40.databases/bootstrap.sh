#!/bin/bash

dnf install ansible -y
anisble  pull -U  https://github.com/daws-84s/ansible-roboshop-roles.git -e component = mongodb main.yml