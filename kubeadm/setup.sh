
=============================================================================================================================
Landmark Technologies 
==============================================================================================================================

Agenda: Kubernetes Setup Using Kubeadm In AWS EC2 Ubuntu Servers Container-D As Runtime
=======

Prerequisite:
=============

3 - Ubuntu Serves

1 - Manager  (4GB RAM , 2 Core) t2.medium

2 - Workers  (1 GB, 1 Core)     t2.micro


Note: Open Required Ports In AWS Security Groups. For now we will open All trafic.

==========COMMON FOR MASTER & SLAVES START ====

1) Switch to root user
   
sudo su -


2) Disable swap & add kernel settings

swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab


3) Add  kernel settings & Enable IP tables(CNI Prerequisites)

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF


modprobe overlay
modprobe br_netfilter



cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF


sysctl --system

4) Install containerd run time

#To install containerd, first install its dependencies.

apt-get update -y 
apt-get install ca-certificates curl gnupg lsb-release -y



Note: We are not installing Docker Here.Since containerd.io package is part of docker apt repositories hence we added docker repository & it's key to download and install containerd.


# Add Docker’s official GPG key:
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

#Use follwing command to set up the repository:

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
  
# Install containerd

apt-get update -y
apt-get install containerd.io -y

# Generate default configuration file for containerd

Note: Containerd uses a configuration file located in /etc/containerd/config.toml for specifying daemon level options.
The default configuration can be generated via below command.

containerd config default > /etc/containerd/config.toml

# Run following command to update configure cgroup as systemd for contianerd.

sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

# Restart and enable containerd service

systemctl restart containerd
systemctl enable containerd


5) Installing kubeadm, kubelet and kubectl 

# Update the apt package index and install packages needed to use the Kubernetes apt repository:

apt-get update
apt-get install -y apt-transport-https ca-certificates curl

# Download the Google Cloud public signing key:

curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

# Add the Kubernetes apt repository:

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list


# Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:

apt-get update
apt-get install -y kubelet kubeadm kubectl

# apt-mark hold will prevent the package from being automatically upgraded or removed.

apt-mark hold kubelet kubeadm kubectl


# Enable and start kubelet service

systemctl daemon-reload 
systemctl start kubelet 
systemctl enable kubelet.service


==========COMMON FOR MASTER & SLAVES END ====

kubeadm join 10.0.0.6:6443 --token xmzufh.e0nu3kb5ohijfxyh \
        --discovery-token-ca-cert-hash sha256:579b6a53bd00c8483f5150b9fb521b6431fc38b1ac716b8b9a5f668928a93771

	
===========In Master Node Start====================
# Steps Only For Kubernetes Master

# Switch to the root user.

sudo su -

# Initialize Kubernates master by executing below commond.

kubeadm init

# If you want to initialize kubernetes on Public EndPoint(Not recommended in real time). You can use below option Replace PUBLIC_IP with actual public ip of your kubernetes master node (Recommended to use Elastic(Create and assign elastic IP to master node and use that Elastic IP below)).Replace PORT with 6443 (API Server Port). 

kubeadm init --control-plane-endpoint "PUBLIC_IP:PORT"

IF Error
sudo kubeadm init --cri-socket /run/containerd/containerd.sock


# Configure kubectl  exit as root user & exeucte as normal ubuntu user
exit

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


# To verify, if kubectl is working or not, run the following command.

kubectl get pods -o wide -n kube-system

#You will notice from the previous command, that all the pods are running except one: ‘core-dns’. For resolving this we will install a # pod network addon like Calico or Weavenet ..etc. 


Note: Install any one network addon don't install both. Install either weave net or calico.

To install Weaven net run the following command.

kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

Or To install the calico network addon, run the following command:

kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml 


kubectl get nodes

kubectl get pods 
kubectl get pods --all-namespaces


# Get token

kubeadm token create --print-join-command

=========In Master Node End====================


Add Worker Machines to Kubernates Master
=========================================

Copy kubeadm join token from and execute in Worker Nodes to join to cluster



kubectl commonds has to be executed in master machine.

Check Nodes 
=============

kubectl get nodes


Deploy Sample Application
==========================

kubectl run nginx-demo --image=nginx --port=80 

kubectl expose pod nginx-demo --port=80 --target-port=80 --type=NodePort


Get Node Port details 
=====================
kubectl get services


===========================================
install-kubectl.sh
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO https://dl.k8s.io/release/v1.26.0/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
chmod +x kubectl
mkdir -p ~/.local/bin
mv ./kubectl ~/.local/bin/kubectl
# and then append (or prepend) ~/.local/bin to $PATH
kubectl version --client




