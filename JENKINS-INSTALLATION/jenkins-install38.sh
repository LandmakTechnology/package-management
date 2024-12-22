#!/bin/sh
#create a T2-MEDIUM REDHAT INSTANCE IN AWS and install Jenkins
sudo hostnamectl set-hostname auto
sudo yum -y install unzip wget tree git -y    
# Add required dependencies for the jenkins package
sudo yum install fontconfig java-17-openjdk -y
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key
sudo yum upgrade -y 
sudo yum install jenkins -y  
sudo systemctl enable jenkins
sudo systemctl start jenkins
sudo systemctl status jenkins
