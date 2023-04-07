#!/bin/bash
sudo ansible-playbook -i ./ansible/web-hosts ./ansible/web-server-playbook.yml \
 --extra-vars "bucket_name=cicd-bucket-dev file_name=id_rsa.pub" \
 --private-key=./cicd.pem -u ec2-user;
