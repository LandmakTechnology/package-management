#  **<span style="color:green">Rondus Technologies, Auburn, WA.</span>**
### **<span style="color:green">Contacts: +1832 335 7561<br> WebSite : <http://rondustech.com/></span>**
### **Email: rondusllc@gmail.com**



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
sudo wget https://dlcdn.apache.org/maven/maven-3/3.8.6/binaries/apache-maven-3.8.6-bin.zip
sudo unzip apache-maven-3.8.6-bin.zip
sudo rm -rf apache-maven-3.8.6-bin.zip
sudo mv apache-maven-3.8.6/ maven
```
## .#Step3) Set Environmental Variable  - For Specific User eg ec2-user
``` sh
vi ~/.bash_profile  # and add the lines below
export M2_HOME=/opt/maven
export PATH=$PATH:$M2_HOME/bin
```
## .#Step4) Refresh the profile file and Verify if maven is running
```sh
source ~/.bash_profile
or source .bash_profile
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


