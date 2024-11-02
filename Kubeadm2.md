Deploy Kubernetes
With the necessary tools installed, proceed to deploy the cluster. Follow the steps below to make the necessary system adjustments, initialize the cluster, and join worker nodes.

## Step 1: Prepare for Kubernetes Deployment
This section shows you how to prepare the servers for a Kubernetes deployment. Execute the steps below on each server node:

1. Disable all swap spaces with the swapoff command:
```
sudo swapoff -a
```

Then use the sed command below to make the necessary adjustments to the /etc/fstab file:
```
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
```
2. Load the required containerd modules. Start by opening the containerd configuration file in a text editor, such as nano:
```
sudo nano /etc/modules-load.d/containerd.conf
```
3. Add the following two lines to the file:
```
overlay
br_netfilter
```
Editing containerd configuration.
Save the file and exit.

4. Next, use the modprobe command to add the modules:
```
sudo modprobe overlay

sudo modprobe br_netfilter
```
5. Open the kubernetes.conf file to configure Kubernetes networking:
```
sudo nano /etc/sysctl.d/kubernetes.conf
```
6. Add the following lines to the file:
```
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
```
Editing Kubernetes configuration.
Save the file and exit.

7. Reload the configuration by typing:
```
sudo sysctl --system
```
Reloading system configuration.
## Step 2: Assign Unique Hostname for Each Server Node
1. Decide which server will be the master node. Then, enter the command on that node to name it accordingly:
```
sudo hostnamectl set-hostname master-node
```
2. Next, set the hostname on the first worker node by entering the following command:
```
sudo hostnamectl set-hostname worker01
```
If you have additional worker nodes, use this process to set a unique hostname on each.

3. Edit the hosts file on each node by adding the IP addresses and hostnames of the servers that will be part of the cluster.

Editing the hosts file.
4. Restart the terminal application to apply the hostname change.

## Step 3: Initialize Kubernetes on Master Node
Once you finish setting up hostnames on cluster nodes, switch to the master node and follow the steps to initialize Kubernetes on it:

1. Open the kubelet file in a text editor.
```
sudo nano /etc/default/kubelet
```
2. Add the following line to the file:
```
KUBELET_EXTRA_ARGS="--cgroup-driver=cgroupfs"
```
Save and exit.

3. Reload the configuration and restart the kubelet:
```
sudo systemctl daemon-reload && sudo systemctl restart kubelet
```
4. Open the Docker daemon configuration file:
```
sudo nano /etc/docker/daemon.json
```
5. Append the following configuration block:
```
    {
      "exec-opts": ["native.cgroupdriver=systemd"],
      "log-driver": "json-file",
      "log-opts": {
      "max-size": "100m"
   },

       "storage-driver": "overlay2"
       }
```
Editing the daemon.json file.
Save the file and exit.

6. Reload the configuration and restart Docker:
```
sudo systemctl daemon-reload && sudo systemctl restart docker
```
7. Open the kubeadm configuration file:
```
sudo nano /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
```
8. Add the following line to the file:
```
Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false"
```
Kubeadm configuration.
Save the file and exit.

9. Reload the configuration and restart the kubelet:
```
sudo systemctl daemon-reload && sudo systemctl restart kubelet
```
10. Finally, initialize the cluster by typing:
```
sudo kubeadm init --control-plane-endpoint=master-node --upload-certs
```
Once the operation finishes, the output displays a kubeadm join command at the bottom. Make a note of this command, as you will use it to join the worker nodes to the cluster.

Master node joins the cluster.
11. Create a directory for the Kubernetes cluster:
```
mkdir -p $HOME/.kube
```
12. Copy the configuration file to the directory:
```
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
```
13. Change the ownership of the directory to the current user and group using the chown command:
```
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
## Step 4: Deploy Pod Network to Cluster
A pod network is a way to allow communication between different nodes in the cluster. This tutorial uses the Flannel node network manager to create a pod network.

Apply the Flannel manager to the master node by executing the steps below:

1. Use kubectl to install Flannel:
```
kubectl apply -f https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
```
2. Untaint the node:
```
kubectl taint nodes --all node-role.kubernetes.io/control-plane-
```
## Step 5: Join Worker Node to Cluster
Repeat the following steps on each worker node to create a cluster:

1. Stop and disable AppArmor:
```
sudo systemctl stop apparmor && sudo systemctl disable apparmor
```
2. Restart containerd:
```
sudo systemctl restart containerd.service
```
3. Apply the kubeadm join command from Step 3 on worker nodes to connect them to the master node. Prefix the command with sudo:
```
sudo kubeadm join [master-node-ip]:6443 --token [token] --discovery-token-ca-cert-hash sha256:[hash]
```
Worker node joins the cluster.
Replace [master-node-ip], [token], and [hash] with the values from the kubeadm join command output.

4. After a few minutes, switch to the master server and enter the following command to check the status of the nodes:
```
kubectl get nodes
```
Viewing deployed nodes.
The system displays the master node and the worker nodes in the cluster.

## Conclusion

After following the steps presented in this article, you should have Kubernetes installed on Ubuntu. The article included instructions on installing the necessary packages and deploying Kubernetes on all your nodes.
