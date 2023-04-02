#!/bin/bash
sudo ansible-playbook -i ./ansible/web-hosts ./ansible/web-server-playbook.yml --private-key=./cicd.pem -u ec2-user;
