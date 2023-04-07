#!/bin/bash
sudo ansible-playbook -i ./ansible/jenkins-hosts ./ansible/jenkins-server-playbook.yml \
 --extra-vars "bucket_name=cicd-bucket-dev" \
 --private-key=./cicd.pem -u ec2-user
