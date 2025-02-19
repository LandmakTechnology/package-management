#  **<span style="color:green">Landmark Technologies, Ontario, Canada.</span>**
### **<span style="color:green">Contacts: +1437 215 2483<br> WebSite : <http://mylandmarktech.com/></span>**
### **Email: mylandmarktech@gmail.com**



## SonarQube Installation And Setup In AWS EC2 Redhat Instance.
##### Prerequisite
+ AWS Acccount.
+ Create Redhat EC2 T2.medium Instance with 4GB RAM.
+ Create Security Group and open Required ports.
   + 9000 ..etc
+ Attach Security Group to EC2 Instance.
+ Install java openJDK 1.8+ for SonarQube version 7.8

## 1. Create sonar user to manage the SonarQube server
```sh
#As a good security practice, SonarQuber Server is not advised to run sonar service as a root user, 
# create a new user called sonar and grant sudo access to manage sonar services as follows

sudo useradd sonar
# Grand sudo access to sonar user
sudo echo "sonar ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/sonar
# set hostname for the sonarqube server
sudo hostnamectl set-hostname sonar 
sudo su - sonar
```
## 1b. Assign password to sonar user
```sh
sudo passwd sonar
```
## 2. Enable PasswordAuthentication in the server
```sh
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart
```
### 3. Install Java JDK 1.8+ required for sonarqube to start

``` sh
cd /opt
sudo yum -y install unzip wget git
sudo yum remove java* -y
sudo yum install fontconfig java-17-openjdk -y
2. install sonarqube 9.9 
   https://www.sonarsource.com/products/sonarqube/downloads/
   https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.0.59551.zip


```
### 4. Download and extract the SonarqQube Server software.
```sh
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.0.59551.zip
sudo unzip sonarqube-9.9.0.59551.zip
sudo mv sonarqube-9.9.0.59551.zip sonarqube
sudo rm -rf *zip
```

## 5. Grant file permissions for sonar user to start and manage sonarQube
```sh
sudo chown -R sonar:sonar /opt/sonarqube/
sudo chmod -R 775 /opt/sonarqube/
```
### 6. start sonarQube server
```sh
sh /opt/sonarqube/bin/linux-x86-64/sonar.sh start 
sh /opt/sonarqube/bin/linux-x86-64/sonar.sh status
```

### 7. Ensure that SonarQube is running and Access sonarQube on the browser
# sonarqube default port is = 9000
# get the sonarqube public ip address 
# publicIP:9000
```sh
curl -v localhost:9000
54.236.232.85:9000
default USERNAME: admin
default password: admin
```
