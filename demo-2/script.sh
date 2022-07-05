#!/bin/bash

# sleep until instance is ready

#until [[ -f /var/lib/cloud/instance/boot-finished ]]; do
#  sleep 1
#done

# install epel repo and nginx
sudo amazon-linux-extras enable epel
sudo yum -y install epel-release
sudo yum -y update 
sudo yum -y install nginx

# make sure nginx is started
systemctl start nginx
systemctl enable nginx
