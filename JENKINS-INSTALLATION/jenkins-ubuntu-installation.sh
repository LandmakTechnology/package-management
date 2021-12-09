
# Jenkins Installation And Setup In AWS EC2 ubuntu Instance.
# Installation of Java
sudo apt update   # Update the repositories
sudo apt install openjdk-11-jdk
java -version
# Install Jenkins
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo dnf upgrade
# Add required dependencies for the jenkins package
sudo dnf install chkconfig java-devel
sudo dnf install jenkins
# Start Jenkins
sudo systemctl daemon-reload  # To Register the Jenkins service 
sudo systemctl start jenkins
systemctl status jenkins
