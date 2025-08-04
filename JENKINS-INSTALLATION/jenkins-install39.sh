#!/bin/bash
# Author: Prof Legah
# date: 14/04/2025
# Installing Jenkins on RHEL 7/8/9, CentOS 7/8/9 or Amazon Linux OS
# You can execute this script as user-data when launching your EC2 VM.
sudo timedatectl set-timezone America/New_York
sudo hostnamectl set-hostname jenkins
sudo yum install wget git nano tree vim unzip -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade -y 
# Add required dependencies for the jenkins package
sudo yum install fontconfig java-17-openjdk -y 
sudo yum install jenkins -y 
sudo systemctl daemon-reload
echo "end of jenkins installation"
sudo yum install net-tools -y 
# start jenkins 
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo su - ec2-user
