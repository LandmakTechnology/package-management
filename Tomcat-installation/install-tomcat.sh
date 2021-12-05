#!/bin/bash
# TOMCAT.SH
# Steps for Installing tomcat9 on rhel7&8
# install Java JDK 1.8+ as a pre-requisit for tomcat to run.
# https://github.com/LandmakTechnology/package-management/tree/main/Tomcat-installation
cd /opt 
sudo yum install git wget -y

sudo yum install java-1.8.0-openjdk-devel -y

# Download tomcat software and extract it.


# dowanload and extract tomcat software
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.55/bin/apache-tomcat-9.0.55.tar.gz
sudo tar -xvf apache-tomcat-9.0.55.tar.gz
sudo rm apache-tomcat-9.0.55.tar.gz

sudo chmod 777 -R /opt/tomcat9
sudo sh /opt/tomcat9/bin/startup.sh
# create a soft link to start and stop tomcat from anywhere 
sudo ln -s /opt/tomcat9/bin/startup.sh /usr/bin/starttomcat
sudo ln -s /opt/tomcat9/bin/shutdown.sh /usr/bin/stoptomcat
sudo starttomcat
echo "end on tomcat installation"
#========

#2. Start of tomcat configuration 


#Tomcat server configuration:
find / -name server.xml context.xml
vim /opt/tomcat9/conf/server.xml
vi /opt/tomcat9/webapps/manager/META-INF/context.xml
vi /opt/tomcat9/conf/tomcat-user.xml  # to add user

	<user username="landmark" password="admin" roles="manager-gui,admin-gui"/>
	

/opt/tomcat9/conf/context.xml

 vi /opt/tomcat9/webapps/manager/META-INF/context.xml
  
  vi /opt/tomcat9/conf/tomcat-user.xml  # to add user
  
	
	username YourName password=PassWord   roles=manager-gui
	
	
