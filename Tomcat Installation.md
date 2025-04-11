Here's a step-by-step guide to installing Apache Tomcat on an Ubuntu server:

---

### Step 1: Update and Upgrade Ubuntu Packages

Run these commands to ensure your system packages are up-to-date:

```bash
sudo apt update
sudo apt upgrade -y
```

---

### Step 2: Install OpenJDK (Java)

Tomcat requires Java, so install the latest version of OpenJDK:

```bash
sudo apt install openjdk-17-jdk -y
```

> Check the Java installation:

```bash
java -version
```

---

### Step 3: Create a User for Tomcat

It’s best practice to run Tomcat as a non-root user for security purposes:

```bash
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
```

---
```Explanation
Here's a detailed breakdown of the command:

```bash
sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat
```

---

 🔍 Step-by-Step Explanation:

- **`sudo`**  
  Runs the command as the root user, required to create system users.

- **`useradd`**  
  A Linux command used to create a new user account on the system.

- **`-m` (Create Home Directory)**  
  Automatically creates a home directory for the user if it doesn't exist.  
  By default, it would be `/home/username`, but we specify a custom location below.

- **`-U` (Create User Group)**  
  Automatically creates a new group with the same name as the username (`tomcat`), and assigns this user to that group.  
  This helps manage file permissions neatly.

- **`-d /opt/tomcat` (Home Directory)**  
  Specifies a custom home directory for the user. In this case, Tomcat-related files will live in `/opt/tomcat`.

- **`-s /bin/false` (Disable Login Shell)**  
  Sets the user's shell to `/bin/false`. This prevents login and direct shell access for security reasons.  
  A user with `/bin/false` cannot log in via SSH or the console.  
  It's a common security measure to restrict access for service accounts.

- **`tomcat` (Username)**  
  The name of the new user being created.  
  It's typical to create a dedicated user for running services like Tomcat, enhancing security and simplifying management.

---

### 📌 **Summary of the Command's Purpose:**

This command creates a dedicated system-level user called **`tomcat`**, sets its home directory as `/opt/tomcat`, assigns a dedicated group also named **`tomcat`**, and disables shell access for improved security.

- **Security Best Practice:**  
  Running Tomcat (and other similar services) as a dedicated user account helps prevent unauthorized access and limits the potential impact of vulnerabilities.

---

### ✅ **Verify User Creation:**

After running the command, you can verify the creation by:

```bash
id tomcat
```

This will output the user's information, confirming creation and assigned groups:

```bash
uid=1001(tomcat) gid=1001(tomcat) groups=1001(tomcat)
```

---

### Step 4: Download and Extract Tomcat

Find the latest stable Tomcat version from the [official website](https://tomcat.apache.org/download-10.cgi). Here, I'll use Tomcat 10.1 as an example:

```bash
sudo wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.40/bin/apache-tomcat-10.1.40.tar.gz -P /tmp
```

Extract Tomcat to `/opt/tomcat`:

```bash
sudo mkdir /opt/tomcat
sudo tar xf /tmp/apache-tomcat-10.1.20.tar.gz -C /opt/tomcat --strip-components=1
```

---

### Step 5: Set Permissions

Assign permissions to the Tomcat user:

```bash
sudo chown -R tomcat:tomcat /opt/tomcat
sudo chmod -R u+x /opt/tomcat/bin
```

---

### Step 6: Create Systemd Service File

To manage Tomcat easily, create a Systemd service file:

```bash
sudo vi /etc/systemd/system/tomcat.service
```

Paste the following content:

```ini
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_BASE=/opt/tomcat"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
```

> Save and close the file: `Ctrl + O`, `Ctrl + X`

---

### Step 7: Reload Systemd and Start Tomcat

Reload the daemon and start Tomcat:

```bash
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl enable tomcat
```

Check the Tomcat service status:

```bash
sudo systemctl status tomcat
```

---

### Step 8: Allow Firewall Access (Optional)

If you have UFW enabled, allow access to Tomcat's default port (8080):

```bash
sudo ufw allow 8080/tcp
```

---

### Step 9: Test Tomcat Installation

Open your browser and enter your server’s IP or domain name:

```
http://your-server-ip:8080
```

You should see the default Apache Tomcat landing page.

---

### **Tomcat Installation Completed!**
---
Additional recommended configurations and best practices you should consider before deploying Apache Tomcat to a production environment. These configurations enhance security, performance, and usability.

Here's a comprehensive overview of key configurations:

---

### ✅ **1. Configure the Tomcat Web Management Interface**

Tomcat comes with a web-based manager app (`Manager App`). Enable secure access to manage applications through the UI:

**Edit `tomcat-users.xml`:**

```bash
sudo vi /opt/tomcat/conf/tomcat-users.xml
```

Add users with appropriate roles:

```xml
<tomcat-users>
    <user username="admin" password="your_secure_password" roles="manager-gui,admin-gui"/>
</tomcat-users>
```

**Restrict remote access:**

For security, allow access only from your IP.  
Edit `/opt/tomcat/webapps/manager/META-INF/context.xml`:
Edit `/opt/tomcat10/webapps/host-manager/META-INF/context.xml`:
Replace:
```xml
<Context antiResourceLocking="false" privileged="true">
```

With:
```xml
<Context antiResourceLocking="false" privileged="true">
  <Valve className="org.apache.catalina.valves.RemoteAddrValve" allow="127\\.0\\.0\\.1|your_ip_regex" />
```

---
When configuring the Tomcat manager to restrict access by IP, the setting uses a regular expression to represent allowed IP addresses. 

For instance, if your public IP is:

```
44.247.47.124
```

You should represent it in the `context.xml` file like this:

**Example configuration:**

```xml
<Context antiResourceLocking="false" privileged="true">
  <Valve className="org.apache.catalina.valves.RemoteAddrValve" allow="127\.0\.0\.1|44\.247\.47\.124" />
</Context>
```

**Explanation:**

- Use `\.` (backslash-dot) to represent literal dots (`.`) since a single dot has special meaning in regular expressions.
- The pipe symbol (`|`) separates multiple allowed IP addresses (here it allows local access from `127.0.0.1` and your IP address).

If you later need to allow an IP range, you would use a pattern like:

```xml
allow="127\.0\.0\.1|44\.247\.47\.\d{1,3}"
```

This would allow any IP from `44.247.47.0` to `44.247.47.255`.


---
### ✅ **2. Increase Security (Remove Default Applications)**

Remove default applications you do not use (examples, documentation, etc.):

```bash
sudo rm -rf /opt/tomcat/webapps/docs
sudo rm -rf /opt/tomcat/webapps/examples
sudo rm -rf /opt/tomcat/webapps/ROOT
```

---

### ✅ **3. Configure Port and Connector Settings**

You may wish to use standard HTTP ports (e.g., `80`, or secure port `443`).

Edit the server configuration file:

```bash
sudo vim /opt/tomcat/conf/server.xml
```

Change default connector:

```xml
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" />
```

To use port 80 (HTTP):

- You must run Tomcat with root privileges or use port forwarding/proxy (recommended):
  - Apache HTTPD or Nginx reverse proxy setup is recommended.

---

### ✅ **4. Configure SSL/TLS (HTTPS)** *(Highly recommended for production)*

Generate or obtain an SSL certificate and configure Tomcat to use HTTPS:

Example configuration (self-signed certificate):

```xml
<Connector port="8443" protocol="org.apache.coyote.http11.Http11NioProtocol"
           maxThreads="150" SSLEnabled="true">
    <SSLHostConfig>
        <Certificate certificateKeystoreFile="conf/keystore.jks"
                     certificateKeystorePassword="yourpassword"
                     type="RSA" />
    </SSLHostConfig>
</Connector>
```

> Ideally, use trusted certificates (e.g., Let's Encrypt).

---

### ✅ **5. Configure JVM Memory Settings (Performance tuning)**

Adjust JVM memory for optimal performance by editing the file:

```bash
sudo vim /opt/tomcat/bin/setenv.sh
```

Insert this content (adjust sizes according to your server RAM):

```bash
export CATALINA_OPTS="-Xms512M -Xmx1024M"
```

> Make script executable:
```bash
sudo chmod +x /opt/tomcat/bin/setenv.sh
```

---

### ✅ **6. Enable Logging**

Configure logs effectively by editing:

```bash
sudo vim /opt/tomcat/conf/logging.properties
```

Set logging levels, log rotation, and formats as needed.

---

### ✅ **7. Implement Reverse Proxy (Recommended)**

Use Nginx or Apache HTTPD as a reverse proxy in front of Tomcat. This approach provides:

- Improved performance (serving static files)
- SSL/TLS termination (easy HTTPS configuration)
- Load balancing and high availability

**Example (Nginx reverse proxy):**

```bash
sudo apt install nginx
```

Create `/etc/nginx/sites-available/tomcat`:

```nginx
server {
    listen 80;
    server_name your_domain.com;

    location / {
        proxy_pass http://localhost:8080/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Enable this configuration:

```bash
sudo ln -s /etc/nginx/sites-available/tomcat /etc/nginx/sites-enabled/
sudo systemctl restart nginx
```

---

### ✅ **8. Backup and Restore Strategy**

Implement regular backup for:

- `/opt/tomcat/conf` (configuration files)
- Application data (`webapps`, databases)

---

### ✅ **9. Regular Maintenance and Updates**

- Schedule regular patching and updates of Tomcat and JVM.
- Keep track of security advisories and vulnerabilities.

---

### ✅ **10. Monitor Tomcat (Recommended Tools)**

Use monitoring tools to keep your server healthy:

- **JConsole/JVisualVM:** JVM monitoring tools.
- **Prometheus/Grafana:** Advanced metrics and monitoring.
- **NewRelic/AppDynamics:** Commercial application monitoring.

---

### ✅ **11. Firewall Security**

Ensure your firewall (UFW) allows only required ports:

```bash
sudo ufw allow ssh
sudo ufw allow 8080/tcp  # or only port 80/443 if proxying
sudo ufw enable
```

---

### ✅ **12. File Permissions**

Ensure file permissions are secure:

```bash
sudo chown -R tomcat:tomcat /opt/tomcat
sudo chmod -R o-rwx /opt/tomcat/conf
```

---

## 🔐 **Security Best Practices Recap:**
- Use HTTPS in production.
- Disable unused services and applications.
- Regularly update software.
- Secure management interfaces.
- Limit network access.

---

After completing these configurations, your Apache Tomcat installation will be secure, performant, and production-ready.
---
Here's a clear, **step-by-step guide** on how to **directly transfer** the JAR file from your Maven server (`xx.xxx.xx.xxx`, `sonar.pem`) to your Tomcat server (`yy.yyy.yy.yyy`, `tomcat.pem`) without using your local machine as an intermediate step:

---

## ✅ **Step 1: Prepare PEM Files and Permissions on Maven Server**

First, log in to your Maven server from your local machine:

```bash
ssh -i sonar.pem ubuntu@xx.xxx.xx.xxx
```

Once logged in, create (or upload) your `tomcat.pem` private key file on your Maven server.

You can do this quickly using a text editor (`vim` or `nano`):

```bash
vim ~/tomcat.pem
```

Paste the content of your `tomcat.pem` file into this file. Then set secure permissions:

```bash
chmod 400 ~/tomcat.pem
```

---

## ✅ **Step 2: Verify SSH Connectivity from Maven to Tomcat**

Check SSH connectivity from Maven server to Tomcat server:

```bash
ssh -i ~/tomcat.pem ubuntu@yy.yyy.yy.yyy
```

- **Accept** the SSH host fingerprint if prompted.
- Ensure successful login, then exit:

```bash
exit
```

---

## ✅ **Step 3: Transfer JAR file from Maven Server directly to Tomcat Server**

On your Maven server, use `scp` to transfer the file:

```bash
scp -i ~/tomcat.pem /path/to/your/jarfile/myapp-1.0.0.jar ubuntu@yy.yyy.yy.yyy:/tmp/
scp -i ~/sonar.pem /home/ec2-user/maven-web-application/target/maven-web-application.war ubuntu@35.94.253.224:/tmp/


```

Replace `/path/to/your/jarfile/myapp-1.0.0.jar` with your actual JAR file path.

- **Confirm** the transfer completes successfully.

---

## ✅ **Step 4: SSH into Tomcat Server and move JAR file**

Connect to your Tomcat server from Maven server (still logged in):

```bash
ssh -i ~/tomcat.pem ubuntu@yy.yyy.yy.yyy
```

Move the JAR file to Tomcat’s `webapps` directory:

```bash
sudo mv /tmp/myapp-1.0.0.jar /opt/tomcat/webapps/
```

Set proper permissions:

```bash
sudo chown tomcat:tomcat /opt/tomcat/webapps/myapp-1.0.0.jar
```

---

## ✅ **Step 5: Restart Tomcat Service**

Restart Tomcat to recognize and deploy the new JAR file:

```bash
sudo systemctl restart tomcat
```

Check Tomcat status to confirm everything is running correctly:

```bash
sudo systemctl status tomcat
```

Review deployment logs:

```bash
tail -f /opt/tomcat/logs/catalina.out
```

---

## ✅ **Quick Reference Commands (Summarized):**

On Maven Server:

```bash
# Add tomcat.pem key to Maven server
nano ~/tomcat.pem   # Paste content & save
chmod 400 ~/tomcat.pem

# Transfer JAR directly from Maven server to Tomcat server
scp -i ~/tomcat.pem /path/to/your/jarfile/myapp-1.0.0.jar ubuntu@yy.yyy.yy.yyy:/tmp/

# SSH into Tomcat server from Maven server
ssh -i ~/tomcat.pem ubuntu@yy.yyy.yy.yyy
```

On Tomcat Server:

```bash
sudo mv /tmp/myapp-1.0.0.jar /opt/tomcat/webapps/
sudo chown tomcat:tomcat /opt/tomcat/webapps/myapp-1.0.0.jar
sudo systemctl restart tomcat
```

---

### 🔐 **Security Recommendation:**
- After completing your transfer, **delete or securely store** the `tomcat.pem` key from your Maven server if you don't regularly perform this action, to minimize security risks.

```bash
rm ~/tomcat.pem
```

---
```deploy
http://your-server-ip:8080/maven-web-application/
```
Your JAR file should now be successfully deployed directly from your Maven server to your Tomcat server!
