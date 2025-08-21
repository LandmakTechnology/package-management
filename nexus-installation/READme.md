#  **<span style="color:green">Landmark Technologies.</span>**
### **<span style="color:green">Contacts: +1437 215 2483<br> WebSite : <http://mylandmarktech.com/></span>**
### **Email: mylandmarktech@gmail.com**



## Nexus Installation And Setup In AWS EC2 Redhat Instance.
##### Pre-requisite
+ AWS Acccount.
+ Create Redhat EC2 t2.medium Instance with 4GB RAM.
+ Create Security Group and open Required ports.
   + 8081 ..etc
+ Attach Security Group to EC2 Instance.
+ Install java openJDK 1.8+ for Nexus version 3.15

## Create nexus user to manage the Nexus server
```sh
#As a good security practice, Nexus is not advised to run nexus service as a root user, 
# so create a new user called nexus and grant sudo access to manage nexus services as follows.
# # change  the timezone sonarqube server
sudo timedatectl set-timezone America/New_York
sudo hostnamectl set-hostname nexus
sudo useradd nexus
# Grand sudo access to nexus user
sudo echo "nexus ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/nexus
## 3. Enable PasswordAuthentication
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart 
sudo su - nexus
```

### Install Java as a pre-requisit for nexus and other softwares

``` sh
cd /opt
sudo yum install wget git nano unzip -y
sudo wget https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.9%2B9/OpenJDK17U-jdk_x64_linux_hotspot_17.0.9_9.tar.gz
sudo mkdir -p /usr/lib/jvm
sudo tar -xzf OpenJDK17U-jdk_x64_linux_hotspot_17.0.9_9.tar.gz -C /usr/lib/jvm
export JAVA_HOME=/usr/lib/jvm/jdk-17.0.9+9
export PATH=$JAVA_HOME/bin:$PATH
java -version
```
### Download nexus software and extract it (unzip).
```sh
 cd /opt 
 sudo wget https://download.sonatype.com/nexus/3/nexus-3.82.0-08-linux-x86_64.tar.gz
 sudo tar xvz -f nexus-3.82.0-08-linux-x86_64.tar.gz
 sudo rm -rf /opt/nexus-3.82.0-08-linux-x86_64.tar.gz
 sudo mv /opt/nexus-3.82.0-08 nexus  
```

## Grant permissions for nexus user to start and manage nexus service
```sh
# Change the owner and group permissions to /opt/nexus and /opt/sonatype-work directories.
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo chmod -R 775 /opt/nexus
sudo chmod -R 775 /opt/sonatype-work
```
##  start nexus SERVICE 
```sh
sh /opt/nexus/bin/nexus start
sh /opt/nexus/bin/nexus status
```
##  CONFIGURE NEXUS TO RUN AS A SERVICE 
sudo ln -s /opt/nexus/bin/nexus /etc/init.d/nexus
```sh
#9 Enable and start the nexus services
sudo systemctl enable nexus
sudo systemctl start nexus
sudo systemctl status nexus
echo "end of nexus installation"
```
