#  **<span style="color:green">Rondus Technologies, Auburn, WA.</span>**
### **<span style="color:green">Contacts: +1832 335 7561<br> WebSite : <http://rondustech.com/></span>**
### **Email: rondusllc@gmail.com**

## Apache Maven Installation And Setup In AWS EC2 Ubuntu Instance.
##### Prerequisite
+ AWS Acccount.
+ Create Security Group and open Required ports.
   + 22 ..etc
+ Create ubuntu EC2 T2.medium Instance with 4GB of RAM.
+ Attach Security Group to EC2 Instance.
+ Install java openJDK 1.8+

### Install Java JDK 1.8+  and other softares (GIT, wget and tree)
```sh
sudo hostnamectl set-hostname maven
sudo su - ubuntu
sudo chown -R ubuntu:ubuntu /opt   
cd /opt
sudo apt-get install wget vim tree unzip git-all -y
sudo apt update
sudo apt install openjdk-8-jdk -y
java -version
```
### Set the JAVA_HOME environment variable by opening the .bashrc file:
```sh
vim ~/.bashrc
```

## Add the following line to the file:
```sh
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
```

## Load the updated .bashrc file to apply the changes:
```sh
source ~/.bashrc
```

## Verify that the JAVA_HOME environment variable is set correctly:
```sh
echo $JAVA_HOME
```

## 2. Update the package lists: and Install Maven
``` sh
sudo apt update
sudo apt install maven -y
mvn --version
```


## Apache Maven Installation And Setup In AWS EC2 Redhat Instance.
##### Prerequisite
+ AWS Acccount.
+ Create Security Group and open Required ports.
   + 22 ..etc
+ Create Redhat EC2 T2.medium Instance with 4GB of RAM.
+ Attach Security Group to EC2 Instance.
+ Install java openJDK 1.8+

### Install Java JDK 1.8+  and other softares (GIT, wget and tree)

``` sh
# install Java JDK 1.8+ as a pre-requisit for maven to run.

sudo hostnamectl set-hostname maven
sudo su - ec2-user
cd /opt
sudo yum install wget nano tree unzip git-all -y
sudo yum install -y java-1.8.0-openjdk-devel
java -version
git --version
```

## 2. Download, extract and Install Maven
``` sh
#Step1) Download the Maven Software
#sudo wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.zip
#sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.3/binaries/apache-maven-3.9.3-bin.zip
sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip
sudo unzip apache-maven-3.9.3-bin.zip
sudo rm -rf apache-maven-3.9.3-bin.zip
sudo mv apache-maven-3.9.3/ maven
```

## .#Step3) Set Environmental Variable  - For Specific User eg ec2-user
```sh
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk" >> ~/.bashrc  # Add the appropriate path for your installed Java version
source ~/.bashrc   # Reload the shell configuration to apply the changes

mvn -version
```
## Alternatively, use this script to install java and maven
--------------------------------------------------------
```
#!/bin/bash

# Update the package manager
sudo yum update -y

# Install Java Development Kit (JDK)
sudo yum install -y java-1.8.0-openjdk-devel

# Set Java environment variables
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk" >> ~/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc
source ~/.bashrc

# Install Apache Maven
sudo yum install -y maven

# Verify Java and Maven installations
java -version
mvn --version
```


