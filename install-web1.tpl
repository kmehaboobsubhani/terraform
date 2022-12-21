#!/bin/bash

hostnamectl set-hostname "web1.skDiamond.io"
echo "`hostname -I | awk '{ print $1}'` `hostname`" >> /etc/hosts
sudo apt-get update
sudo apt-get install git curl wget unzip tree -y 
sudo apt-get install software-properties-common -y 
apt install awscli -y 
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo "Welcome to AWS Devops WebPage1" | sudo tee /var/www/html/index.html
