#  **<span style="color:green">Rondus Technologies.</span>**
### **<span style="color:green">Contacts: +1832 335 7561<br> WebSite : <http://rondustech.com/></span>**
### **Email: rondusllc@gmail.com**



## Kubernetes Setup Using Kubeadm In AWS EC2 Ubuntu Servers.
##### Prerequisite
+ AWS Acccount.
+ Create 3 - Ubuntu Servers -- 18.04.
+ 1 Master (4GB RAM , 2 Core)  t2.medium
+ 2 Workers  (1 GB, 1 Core)     t2.micro
+ Create Security Group and open required ports for kubernetes.
   + Open all port for this illustration
+ Attach Security Group to EC2 Instance/nodes.

## Step 1. Assign hostname &  login as ‘root’ user because the following set of commands need to be executed with ‘sudo’ permissions.
```sh
sudo hostnamectl set-hostname master
sudo -i
```
## Step 2.
``` sh
# run the following below as a script
# This will Install Required packages and apt keys.
#!/bin/bash
sudo apt update -y
sudo apt install -y apt-transport-https
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt update -y
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
## exit as root user & execute the below commands as normal ubuntu user
```sh
sudo su - ubuntu
```

## Step 3. Initialised the control plane.
``` sh
# Initialize Kubernates master by executing below commond.
sudo modprobe br_netfilter
sudo kubeadm init
```

## Step 4. Make .kube directory and copy to $HOME/.kube/config
```sh
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

## Step 5. To verify, if kubectl is working or not, run the following command.
```sh
kubectl get pods -A
```
## Step 6. Deploy the network plugin - weave network
```sh
wget https://github.com/weaveworks/weave/releases/download/v2.6.0/weave-daemonset-k8s-1.11.yaml
kubectl get pods -A
kubectl get node
```
```sh
##deploy the network plugin - weave network
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
kubectl get pods -A
kubectl get node
```
## Step 7. Copy kubeadm join token from the master and execute in Worker Nodes to join to cluster
```sh
kubeadm join 172.31.10.12:6443 --token cdm6fo.dhbrxyleqe5suy6e \
        --discovery-token-ca-cert-hash sha256:1fc51686afd16c46102c018acb71ef9537c1226e331840e7d401630b96298e7d
```
## Step 8. If you have a pre-flight check error when you run "sudo kubeadm init", run this first command
```sh
sudo modprobe br_netfilter
```
---
##What is the Kubernetes Node Not Ready Error?
A Kubernetes node is a physical or virtual machine participating in a Kubernetes cluster, which can be used to run pods. When a node shuts down or crashes, it enters the NotReady state, meaning it cannot be used to run pods. All stateful pods running on the node then become unavailable.

Common reasons for a Kubernetes node not ready error include lack of resources on the node, a problem with the kubelet (the agent enabling the Kubernetes control plane to access and control the node), or an error related to kube-proxy (the networking agent on the node).

To identify a Kubernetes node not ready error: run the kubectl get nodes command. Nodes that are not ready will appear like this:

NAME                   STATUS    ROLES   AGE      VERSION
master.example.com     Ready     master  5h       v1.17
node1.example.com      NotReady  compute 5h       v1.17
node2.example.com      Ready     compute 5h       v1.17
We’ll provide best practices for diagnosing simple cases of the node not ready error, but more complex cases will require advanced diagnosis and troubleshooting, which is beyond the scope of this article.

##The 4 Kubernetes Node States
At any given time, a Kubernetes node can be in one of the following states:

##Ready—able to run pods.
NotReady—not operating due to a problem, and cannot run pods.
SchedulingDisabled—the node is healthy but has been marked by the cluster as not schedulable.
Unknown—if the node controller cannot communicate with the node, it waits a default of 40 seconds, and then sets the node status to unknown.
If a note is in the NodeReady state, it indicates that the kubelet is installed on the node, but Kubernetes has detected a problem on the node that prevents it from running pods.

##Troubleshooting Node Not Ready Error
Common Causes and Diagnosis
Here are some common reasons that a Kubernetes node may enter the NotRead state:

##Lack of System Resources
Why It Prevents the Node from Running Pods
A node must have enough disk space, memory, and processing power to run Kubernetes workloads.

If non-Kubernetes processes on the node are taking up too many resources, or if there are too many processes running on the node, it can be marked by the control plane as NotReady.

##How to Diagnose
Run kubectl describe node and look in the Conditions section to see if resources are missing on the node:

MemoryPressure—node is running out of memory.
DiskPressure—node is running out of disk space.
PIDPressure—node is running too many processes.

##kubelet Issue
Why It Prevents the Node from Running Pods
The kubelet must run on each node to enable it to participate in the cluster. If the kubelet crashes or stops on a node, it cannot communicate with the API server and the node goes into a not ready state.

##How to Diagnose
Run kubectl describe node [name] and look in the Conditions section—if all the conditions are unknown, this indicates the kubelet is down.

kube-proxy Issue
Why It Prevents the Node from Running Pods
kube-proxy runs on every node and is responsible for regulating network traffic between the node and other entities inside and outside the cluster. If kube-proxy stops running for any reason, the node goes into a not ready state.

##How to Diagnose
Run kubectl get pods -n kube-system to show pods belonging to the Kubernetes system.

#Connectivity Issue
Why It Prevents the Node from Running Pods
Even if a node is configured perfectly, but it has no network connectivity, Kubernetes treats the node as not ready. This could be due to a disconnected network cable, no Internet access, or misconfigured networking on the machine.

##How to Diagnose
Run kubectl describe node [name] and look in the Conditions section—if the NetworkUnavailable flag is True, this means the node has a connectivity issue.

Resolving Node Not Ready Issues
Resolving Lack of System Resources
Here are a few ways to resolve a system resource issue on the node:

Identify which non-Kubernetes processes are running on the node. If there are any, shut them down or reduce them to a minimum to conserve resources.
Run a malware scan—there may be hidden malicious processes taking up system resources.
Upgrade the node.
Check for hardware issues or misconfigurations and resolve them.
Resolving kubelet Issues
To resolve a kubelet issue, SSH into the node and run the command systemctl status kubelet

Look at the value of the Active field:

active (running) means the kubelet is actually operational, look for the problem elsewhere.
active (exited) means the kubelet was exited, probably in error. Restart it.>
inactive (dead) means the kubelet crashed. To identify why, run the command journalctl -u kubelet and examine the kubelet logs.
Resolving kube-proxy Issues
Try looking in the following places to identify what is the issue with kube-proxy:

Run the command kubectl describe pod using the name of the kube-proxy pod that failed, and check the Events section in the output.
Run the command kubectl logs [pod-name] -n kube-system to see a full log of the failing kube-proxy pod.
Run the command kubectl describe daemonset kube-proxy -n kube-system to see the status of the kube-proxy daemonset, which is responsible for ensuring there is a kube-proxy running on every Kubernetes node.
Please note that these procedures can help you gather more information about the problem, but additional steps may be needed to resolve the problem. If one of the quick fixes above did not work, you’ll need to undertake a more complex, non-linear diagnosis procedure to identify which parts of the Kubernetes environment contribute to the node not ready problem and resolve it.
---
The following error indicates a possible certificate mismatch.
# kubectl get pods
Unable to connect to the server: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "kubernetes")

Run this script
set it to the default KUBECONFIG location:

export KUBECONFIG=/etc/kubernetes/admin.conf

OR

Overwrite the existing kubeconfig for the "admin" user:

mv  $HOME/.kube $HOME/.kube.bak
mkdir $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

