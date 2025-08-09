1. Create a nexus user 
sudo useradd nexus

# 2. Grant sudo access to nexus user
sudo echo "nexus ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/nexus

## 3. Enable PasswordAuthentication
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart 

sudo su nexus

4. Install wget
sudo yum install wget -y

5. Install java

sudo wget https://github.com/adoptium/temurin17-binaries/releases/download/jdk-17.0.9%2B9/OpenJDK17U-jdk_x64_linux_hotspot_17.0.9_9.tar.gz
sudo mkdir -p /usr/lib/jvm
sudo tar -xzf OpenJDK17U-jdk_x64_linux_hotspot_17.0.9_9.tar.gz -C /usr/lib/jvm
export JAVA_HOME=/usr/lib/jvm/jdk-17.0.9+9
export PATH=$JAVA_HOME/bin:$PATH
java -version

6. Install nexus

 sudo wget https://download.sonatype.com/nexus/3/nexus-3.82.0-08-linux-x86_64.tar.gz
 sudo tar xvz -f nexus-3.82.0-08-linux-x86_64.tar.gz
 sudo chown -R nexus:nexus /opt/nexus-3.82.0-08
 sudo chown -R nexus:nexus /opt/sonatype-work/

7. Start nexus

cd nexus-3.82.0-08
cd bin
sh nexus start

Access nexus on the browser @ ip:8081
