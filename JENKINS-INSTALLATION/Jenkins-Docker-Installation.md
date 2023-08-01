
# Jenkins Installation And Setup In AWS EC2 Ubuntu or Amazon Linux Instnace Using Docker.

#### Prerequisite
 + AWS Acccount.
 + Create Ubuntu or Amazon Linux EC2 t2.medium Instance with 4GB RAM.
 + Create Security Group and open Required ports.
    + 8080 got Jenkins, ..etc
 + Attach Security Group to EC2 Instance.


## Step 1
### A. Install Docker on Ubuntu
``` sh
sudo apt-get update
sudo apt-get install docker.io -y
```
--------OR---------

### B. Install Docker on Amazon Linux
``` sh
sudo yum install docker-io
sudo service docker start
```

## Step 2
## Run Jenkins Using Docker
``` sh
sudo docker run --name jenkins -p 8080:8080 -d --restart=on-failure jenkins/jenkins:lts-jdk11
```


## Step 3
## Retrieve Jenkins Password
``` sh
sudo docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```
password will be display, copy the password and use to login to Jenkins server on the browser




## Step 4 
## Access Jenkins from the browser
```sh
public-ip:8080
curl ifconfig.co 
```



## Jenkins Nexus Integration (WIP) 
## Access Jenkins from the browser

In your Jenkins docker server, run these commands:

```sh
docker exec -u 0 -it jenkins bash
```


```sh
apt-get update
apt-get install nano 
nano jenkins_home/tools/hudson.tasks.Maven_MavenInstallation/maven3.*.*/conf/settings.xml
```
Add nexus repo url to the distributionManagement tag in Pom.xml (in your GitHub repo)

(Replace * with the version of maven tool you installed in Jenkins)
