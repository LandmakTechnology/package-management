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
+ Minimum 4 VCPU & 8 GB Memory
+ Server firewall opened for port 22 & 8081 
+ OpenJDK 8
+ Java 11
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

### Download nexus software and extract it (unzip).
```sh
sudo wget https://download.sonatype.com/nexus/3/nexus-unix-x86-64-3.78.2-04.tar.gz
sudo tar -zxvf nexus-unix-x86-64-3.78.2-04.tar.gz
sudo mv /opt/nexus-3.78.2-04 /opt/nexus
sudo rm -rf nexus-unix-x86-64-3.78.2-04.tar.gz
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

## 🔧 Step-by-Step: Run Nexus as a Systemd Service

### ✅ 1. Create a Nexus service file:

```bash
sudo nano /etc/systemd/system/nexus.service
```

Paste the following (edit paths if your Nexus is installed elsewhere):

```ini
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
```

> Replace `User=nexus` with the user who owns the Nexus process, or create one using:
> ```bash
> sudo adduser nexus
> sudo chown -R nexus:nexus /opt/nexus
> ```

---

### ✅ 2. Reload systemd and enable service:

```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable nexus
```

---

### ✅ 3. Start and check Nexus status:

```bash
sudo systemctl start nexus
sudo systemctl status nexus
```

---


