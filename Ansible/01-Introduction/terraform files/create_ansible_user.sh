#!/bin/bash
sudo useradd -d /home/ansible -s /bin/bash -m ansible
sudo echo "ansible:ansible" | chpasswd
sudo echo "ansible  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart
