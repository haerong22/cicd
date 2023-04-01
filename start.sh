#!/bin/bash
sudo ansible-playbook -i ./ansible/hosts ./ansible/web-server-playbook.yml --private-key=./web-server.pem -u ec2-user;
