#  **<span style="color:green">Rondus Technologies.</span>**
### **<span style="color:green">Contacts: +18323357561<br> WebSite : <http:///rondustech.com/></span>**
### **Email: rondusllc@gmail.com**



## Nexus Installation And Setup In AWS EC2 Redhat Instance.
##### Pre-requisite
+ AWS Acccount.
+ Create Redhat EC2 t2.medium Instance with 4GB RAM.
+ Create Security Group and open Required ports.
   + 8081 ..etc
+ Attach Security Group to EC2 Instance.
+ Install java openJDK 1.8+ for Nexus version 3.15
## New Prerequisite
+ Minimum 1 VCPU & 2 GB Memory
+ Server firewall opened for port 22 & 8081 
+ OpenJDK 8
+ All Nexus processes should run as a non-root nexus user.

## Create nexus user to manage the Nexus server

#As a good security practice, Nexus is not advised to run nexus service as a root user, 
#so create a new user called nexus and grant sudo access to manage nexus services as follows.
```sh
sudo yum update && sudo yum upgrade
sudo hostnamectl set-hostname nexus
sudo useradd nexus
```
# Grand sudo access to nexus user
```sh
sudo echo "nexus ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/nexus

sudo passwd nexus
sudo su - nexus
```

### Install Java as a pre-requisit for nexus and other softwares

``` sh

cd /opt
sudo yum install wget git nano unzip -y
sudo yum install java-11-openjdk-devel 
```
#Alternatively - This is for java 17
```sh
sudo yum install java-17-openjdk-devel -y
```
### Download nexus software and extract it (unzip).
```sh
sudo wget https://download.sonatype.com/nexus/3/nexus-unix-x86-64-3.78.2-04.tar.gz
sudo tar -zxvf nexus-3.78.2-04-unix.tar.gz
sudo mv /opt/nexus-3.78.2-04 /opt/nexus
sudo rm -rf nexus-3.78.2-04-unix.tar.gz
```

## New (don't use this - just for learning purpose)
```sh
sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz
sudo tar -xvf nexus.tar.gz
```

## Grant permissions for nexus user to start and manage nexus service
```sh
# Change the owner and group permissions to /opt/nexus and /opt/sonatype-work directories.
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo chmod -R 775 /opt/nexus
sudo chmod -R 775 /opt/sonatype-work
```
##  Open /opt/nexus/bin/nexus.rc file and  uncomment run_as_user parameter and set as nexus user.
## # change from #run_as_user="" to [ run_as_user="nexus" ]

```sh
echo  'run_as_user="nexus" ' > /opt/nexus/bin/nexus.rc
```

##  CONFIGURE NEXUS TO RUN AS A SERVICE 
```sh
sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
```

## Enable and start the nexus services
```sh
sudo systemctl enable nexus
sudo systemctl start nexus
sudo systemctl status nexus
echo "end of nexus installation"
```
