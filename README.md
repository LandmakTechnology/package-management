#  **<span style="color:green">Landmark Technologies.</span>**
### **<span style="color:green">Contacts: +1437 215 2483<br> WebSite : <http://mylandmarktech.com/></span>**
### **Email: mylandmarktech@gmail.com**



## Kubernetes Setup Using Kubeadm In AWS EC2 Ubuntu Serverse.
##### Prerequisite
+ AWS Acccount.
+ Create 3 - Ubuntu Servers -- 18.04.
+ 1 Master (4GB RAM , 2 Core)  t2.medium
+ 2 Workers  (1 GB, 1 Core)     t2.micro
+ Create Security Group and open required ports for kubernetes.
   + Open all port for this illustration
+ Attach Security Group to EC2 Instance/nodes.



## Assign hostname &  login as ‘root’ user because the following set of commands need to be executed with ‘sudo’ permissions.

sudo hostname k8s
sudo -i

``` sh
# run the following below as a script
# This will Install Required packages and apt keys.
#!/bin/bash
udo apt-get update -y
sudo apt-get install -y apt-transport-https
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update -y
#Turn Off Swap Space
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
#Install kubeadm, Kubelet And Kubectl containerd
sudo apt-get install -y kubelet containerd kubeadm kubectl kubernetes-cni 
# apt-mark hold will prvent the package from being authomatically upgraded or removed
sudo apt-mark hold kubelet containerd kubeadm kubectl kubernetes-cni 
# 
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

# Setup required sysctl params, these persist across reboots.
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system
# Configure containerd:
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
# Restart containerd:
sudo systemctl restart containerd
# If you get error releated to kubernetes-cni if alreay exists install with out kubernetes-cni
apt-get install -y kubelet kubeadm kubectl 
# Enable and start kubelet service
sudo systemctl daemon-reload 
sudo systemctl start kubelet 
sudo systemctl enable kubelet.service
```
