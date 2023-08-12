#  **<span style="color:green">Rondus Technologies.</span>**
### **<span style="color:green">Contacts: +1437 215 2483<br> WebSite : <http://rondustech.com/></span>**
### **Email: rondusllc@gmail.com**



## Jenkins Installation And Setup In AWS EC2 Redhat Instnace.
##### Prerequisite
+ AWS Acccount.
+ Create Redhat EC2 t2.medium Instance with 4GB RAM.
+ Create Security Group and open Required ports.
   + 8080 got Jenkins, ..etc
+ Attach Security Group to EC2 Instance.
+ Install java openJDK 1.8+ for SonarQube version 7.8

### Install Java JDK 1.8+ as Jenkins pre-requisit
### Install other softwares - git, unzip and wget
# Add required dependencies for the jenkins package

``` sh
sudo hostname ci
sudo yum -y install unzip wget tree git
sudo yum install java-17-openjdk

```
###  Add Jenkins Repository and key
```sh
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
```
### Install Jenkins
```sh
sudo yum install jenkins
sudo systemctl daemon-reload
```
# start Jenkins  service and verify Jenkins is running
```sh
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
```
# Access Jenkins from the browser
```sh
public-ip:8080
curl ifconfig.co 
```
# get jenkins initial admin password
```sh
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

