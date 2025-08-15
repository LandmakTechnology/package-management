##1. Create a nexus user and  Grant sudo access to nexus user
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

#4. Install wget
sudo yum install wget tree vim nano zip unzip -y

#5. Install java OpenJDK17U a pre-requisite for nexus to run 

sudo wget https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.9%2B9/OpenJDK17U-jdk_x64_linux_hotspot_17.0.9_9.tar.gz
sudo mkdir -p /usr/lib/jvm
sudo tar -xzf OpenJDK17U-jdk_x64_linux_hotspot_17.0.9_9.tar.gz -C /usr/lib/jvm
export JAVA_HOME=/usr/lib/jvm/jdk-17.0.9+9
export PATH=$JAVA_HOME/bin:$PATH
java -version

#6. Install nexus
 cd /opt 
 sudo wget https://download.sonatype.com/nexus/3/nexus-3.82.0-08-linux-x86_64.tar.gz
 sudo tar xvz -f nexus-3.82.0-08-linux-x86_64.tar.gz
 sudo rm -rf /opt/nexus-3.82.0-08-linux-x86_64.tar.gz
 sudo mv /opt/nexus-3.82.0-08 nexus   
 sudo chown -R nexus:nexus /opt/nexus 
 sudo chown -R nexus:nexus /opt/sonatype-work/

#7. Start nexus using the absolute path to the nexus start-up script
sh /opt/nexus/bin/nexus start
sh /opt/nexus/bin/nexus status

Access nexus on the browser @ ip:8081
