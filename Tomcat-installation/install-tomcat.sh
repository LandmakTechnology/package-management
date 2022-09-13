#!/bin/bash
# Use this script to install tomcat in rehat servers
echo delete the failed version of tomcat
sudo rm -rf /opt/tomcat9
echo assign a hostname to your server 
sudo hostname tomcat
# install Java JDK 1.8+ as a pre-requisit for tomcat to run.
cd /opt 
sudo yum install git wget -y
sudo yum install java-1.8.0-openjdk-devel -y
# Download tomcat software and extract it.
sudo yum install wget unzip -y

sudo wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.23/bin/apache-tomcat-10.0.23.tar.gz
sudo tar -xvf apache-tomcat-10.0.23.tar.gz
sudo rm apache-tomcat-10.0.23.tar.gz
sudo mv apache-tomcat-10.0.23 tomcat10
sudo chmod 777 -R /opt/tomcat10
sudo chown ec2-user -R /opt/tomcat10
sh /opt/tomcat10/bin/startup.sh
# create a soft link to start and stop tomcat
sudo ln -s /opt/tomcat10/bin/startup.sh /usr/bin/starttomcat
sudo ln -s /opt/tomcat10/bin/shutdown.sh /usr/bin/stoptomcat
sudo yum update -y
starttomcat
echo "end on tomcat installation"
#========

#2. Start of tomcat configuration 


#Tomcat server configuration:
find / -name server.xml context.xml
vim /opt/tomcat10/conf/server.xml
vi /opt/tomcat10/webapps/manager/META-INF/context.xml
vi /opt/tomcat10/conf/tomcat-user.xml  # to add user

	<user username="landmark" password="admin" roles="manager-gui,admin-gui"/>
	<user username="landmark" password="admin123" roles="manager-gui,admin-gui, manager-script"/>

/opt/tomcat10/conf/context.xml

 vi /opt/tomcat10/webapps/manager/META-INF/context.xml
  
  vi /opt/tomcat10/conf/tomcat-user.xml  # to add user
  
	
	username YourName password=PassWord   roles=manager-gui
	
	
