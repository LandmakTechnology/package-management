### Update and install the required dependencies
### Step 1: Update the Linux packages and Install Dependency and Install Java 17
```sh
sudo yum update -y
sudo yum install wget unzip -y
sudo yum install java-17-openjdk-devel
```
### 2:Install and Setup PostgreSQL 14 Database For SonarQube
### Step 1: Install the PostgreSQL Repository
```sh
sudo yum install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm
```
### Step 2: Disable the default PostgreSQL module once the repository is added.
```sh
sudo yum -qy module disable postgresql
```
### Step 3: Now, install the PostgreSQL 14 database server
```sh
sudo yum -y install postgresql14 postgresql14-server
```
### Step 4: Initialize the Postgres database.
```sh
sudo /usr/pgsql-14/bin/postgresql-14-setup initdb
```
### Step 5: Start and Enable the PostgreSQL Database server to start automatically after the system reboot.
```sh
sudo systemctl enable --now postgresql-14
```
### Step 6: Change the default password for the PostgreSQL user.
```sh
sudo passwd postgres
```
### Step 7: Switch to the Postgres user.
```sh
sudo su - postgres
```
### Step 8: Create the sonar user by the following command:
```sh
createuser sonar
```
### Step 9: Switch to the PostgreSQL shell.
```sh
psql
```
### Step 10: Set a password for the sonar user for the SonarQube database.
```sh
ALTER USER sonar WITH ENCRYPTED password 'sonar';
```
### Step 11: Create a new database for PostgreSQL database by running:
```sh
CREATE DATABASE sonarqube OWNER sonar;
```
### Step 12: Grant all privileges to the sonar user on sonarqube Database.
```sh
GRANT ALL PRIVILEGES ON DATABASE sonarqube to sonar; 
```
### Step 13: Exit from the psql shell.
```sh
\q
```
### Step 14: Switch back to the sudo user by the following command:
```sh
exit
```
## 2:Create user for SonarQube
### Step 1: Create a user for the sonarqube
```sh
sudo useradd sonar
```
### Step 2: Set password for the user:
```sh
sudo passwd sonar
```
### 3:Download and Install SonarQube on Linux
### Step 1: Download the sonaqube binary files To download the latest version go to the SonarQube download page
---sh
cd /opt
```
```sh
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.3.79811.zip
```
### Step 2:Unzip the archive file by the following command:
```sh
sudo unzip sonarqube-9.9.3.79811.zip
sudo rm -rf sonarqube-9.9.3.79811.zip
```
### Step 3: Change the sonarqube extracted directory name to sonarqube.
```sh
sudo mv sonarqube-9.9.3.79811 sonarqube
```
### 4:Configure SonarQube
### Step 1: Create a group name sonar
```sh
sudo groupadd sonar
```
### Step 2: Give ownership permission to the sonar user and group.
```sh
sudo chown -R sonar:sonar /opt/sonarqube
```
### Step 4: Open the SonarQube configuration file in the vim editor.
```sh
$ sudo vi /opt/sonarqube/conf/sonar.properties
```
### Step 5: Find the following lines uncomment and type the PostgreSQL Database username and password which we have created in the above steps.
```sh
sonar.jdbc.username=sonar
sonar.jdbc.password=sonar
```
### Step 5: Edit the sonar script file and set RUN_AS_USER
```sh
sudo vi /opt/sonarqube/bin/linux-x86-64/sonar.sh
```
```sh
RUN_AS_USER=sonar
```
### 5:Configure Systemd service
### Step 1: Create a systemd service file for SonarQube to run as System Startup.
```sh
sudo vi /etc/systemd/system/sonar.service
```

### Add the below lines, then save and close the file
```sh
[Unit] 
Description=SonarQube service 
After=syslog.target network.target 
[Service] 
Type=forking 
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start 
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop 
User=sonar 
Group=sonar 
Restart=always 
[Install] 
WantedBy=multi-user.target
```
### Step 2: Restart the daemon services to load the sonar service.
```sh
sudo systemctl daemon-reload
```
### Start 3: Start and enable the Sonarqube service to automatically run at the boot time:
```sh
sudo systemctl enable --now sonar
```
### Step 4: To check if the sonarqube service is running, run the following command:
```sh
sudo systemctl status sonar
```
### 6:Access SonarQube
### To access the SonarQube go to the browser and use the server IP on port 9000.

### http://server_IP:9000 OR http://localhost:9000
### Login to the SonarQube with the default administrator username and password which is admin.
