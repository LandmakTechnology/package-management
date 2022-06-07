curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# java installation

sudo apt install openjdk-11-jre -y
sudo apt-get update -y
sudo apt-get install jenkins -y
# Grand sudo access to jenkins user
sudo echo "jenkins ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/jenkins

sudo apt-get install docker.io -y

# 2. Enable PasswordAuthentication in the server
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart
#
sudo usermod -aG docker jenkins

sudo hostname admin
sudo su - jenkins
