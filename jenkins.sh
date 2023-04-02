#!/bin/bash
sudo ansible-playbook -i ./ansible/jenkins-hosts ./ansible/jenkins-server-playbook.yml --private-key=./cicd.pem -u ec2-user;
