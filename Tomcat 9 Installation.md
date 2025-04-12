Here is a **step-by-step guide to install Apache Tomcat 9** on an Ubuntu server (works for Ubuntu 18.04, 20.04, 22.04):

---

## ✅ **Step-by-Step Installation of Tomcat 9 on Ubuntu**

---

### **Step 1: Update System Packages**
```bash
sudo apt update
sudo apt upgrade -y
```

---

### **Step 2: Install Java (OpenJDK)**
Tomcat requires Java to run.

```bash
sudo apt install default-jdk -y
```

> 🔍 Confirm Java version:
```bash
java -version
```

---

### **Step 3: Create a Tomcat User (for security)**
It's best to run Tomcat as its own user.

```bash
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
```

---

### **Step 4: Download and Extract Tomcat 9**
Check the latest version from [Apache Tomcat 9 Download Page](https://tomcat.apache.org/download-90.cgi).

```bash
cd /tmp

wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.104/bin/apache-tomcat-9.0.104.tar.gz
```

Extract and move to `/opt/tomcat`:

```bash
sudo tar -xvzf apache-tomcat-9.0.104.tar.gz -C /opt/tomcat --strip-components=1
```

---

### **Step 5: Set Permissions**
Give the `tomcat` user ownership of the directory.

```bash
cd /opt/tomcat
sudo chown -R tomcat:tomcat /opt/tomcat
sudo chmod +x /opt/tomcat/bin/*.sh
```

---

### **Step 6: Create a Systemd Service for Tomcat**

```bash
sudo nano /etc/systemd/system/tomcat.service
```

Paste this configuration:

```ini
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_BASE=/opt/tomcat"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
Environment="JAVA_OPTS=-Djava.security.egd=file:/dev/./urandom"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

Restart=on-failure

[Install]
WantedBy=multi-user.target
```

Save and exit `Ctrl+O`, `Enter`, `Ctrl+X`.

---

### **Step 7: Reload Daemon and Start Tomcat**
```bash
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat
```

Check status:
```bash
sudo systemctl status tomcat
```

---

### **Step 8: Open Firewall (Optional)**
If UFW is active:

```bash
sudo ufw allow 8080
```

---

### **Step 9: Access Tomcat Web UI**
Open your browser and go to:

```
http://<your-server-ip>:8080
```

If everything went well, you'll see the **Tomcat welcome page**.

---

### ✅ (Optional) Step 10: Enable Tomcat Manager UI

1. Edit users file:

```bash
sudo nano /opt/tomcat/conf/tomcat-users.xml
```

2. Add the following **inside `<tomcat-users>`**:

```xml
<role rolename="manager-gui"/>
<user username="admin" password="admin123" roles="manager-gui"/>
```

3. Save and restart Tomcat:

```bash
sudo systemctl restart tomcat
```

Then visit:

```
http://<your-server-ip>:8080/manager/html
```

Log in using `admin / admin123`.

---

Would you like a bash script to automate all this? Or want to install multiple Tomcat instances on the same server?
