# Jenkins Installation And Setup In AWS EC2 ubuntu 22.04 Instance.
# Installation of Java
sudo apt update   # Update the repositories
sudo apt install default-jre #This installs Java 11 whcih is the default on Ubuntu 22.04
java -version

#installation of jenkins via package manager
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl status jenkins

#if needed install docker then add jenkins user to docker group
#sudo apt install docker.io -y
#sudo usermod -aG docker jenkins
#sudo systemctl restart jenkins
