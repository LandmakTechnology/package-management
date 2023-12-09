#  **<span style="color:green">Rondus Technology, Auburn, WA.</span>**
### **<span style="color:green">Contacts: +18323357561<br> WebSite : <http://rondustech.com/></span>**
### **Email: rondusllc@gmail.com**



## Apache Tomcat Installation And Setup In AWS EC2 Redhat Instance.
##### Prerequisite
+ AWS Acccount.
+ Create Redhat EC2 T2.micro Instance.
+ Create Security Group and open Tomcat ports or Required ports.
   + 8080 ..etc
+ Attach Security Group to EC2 Instance.
+ Install java openJDK 1.8+

### Install Java JDK 1.8+ 

``` sh
# install Java JDK 1.8+ as a pre-requisit for tomcat to run.
sudo hostnamectl set-hostname tomcat
cd /opt 
sudo yum install git wget -y
sudo yum install java-1.8.0-openjdk-devel -y
# install wget unzip packages.
sudo yum install wget unzip -y
```
## Install Tomcat version 9
### Download and extract the tomcat server
``` sh
sudo wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.83/bin/apache-tomcat-9.0.83.tar.gz
sudo tar -xvf apache-tomcat-9.0.83.tar.gz
sudo rm -rf apache-tomcat-9.0.83.tar.gz
sudo mv apache-tomcat-9.0.83 tomcat9
sudo chmod 777 -R /opt/tomcat9
```

### assign executable permissions to the tomcat home directory
```sh
sudo chmod 777 -R /opt/tomcat9
sudo chown ec2-user -R /opt/tomcat9
```

### start tomcat
```sh
sh /opt/tomcat9/bin/startup.sh
# create a soft link to start and stop tomcat
# This will enable us to manage tomcat as a service
sudo ln -s /opt/tomcat9/bin/startup.sh /usr/bin/starttomcat
sudo ln -s /opt/tomcat9/bin/shutdown.sh /usr/bin/stoptomcat
starttomcat
sudo su - ec2-user
```

