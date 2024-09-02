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
### Where Jenkins is installed
On a Linux server, Jenkins is typically installed in the following locations:

Jenkins Home Directory:

The Jenkins home directory, which stores configuration files, plugins, and build artifacts, is usually located at /var/lib/jenkins/.
You can find this location specified in the Jenkins configuration file, typically located at /etc/default/jenkins or /etc/sysconfig/jenkins.
Jenkins Configuration Files:

The main Jenkins configuration file is usually found at /etc/jenkins/jenkins.xml or /etc/default/jenkins.
Additional configuration files, like the default settings and environment variables, may be found in /etc/default/jenkins or /etc/sysconfig/jenkins.
Jenkins Executable:

The Jenkins service executable is generally located in /usr/bin/jenkins or /usr/share/jenkins/.
Log Files:

Jenkins logs are often stored in /var/log/jenkins/jenkins.log.
You can also check where Jenkins is installed by using the following command:

```
ps aux | grep jenkins
```
This command will show you the Jenkins process and the paths being used. Additionally, you can use the command:

```
sudo systemctl status jenkins
```
This will display the status of the Jenkins service, including its home directory and other relevant paths.

These are typical locations, but the exact paths may vary depending on how Jenkins was installed (using package managers like apt or yum, or manually).
