#!/bin/bash
# Common stages for both master and worker nodes
# This can be use as user data in launch template or launch configutions
sudo -i 
sudo hostnamectl set-hostname master
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

sudo apt update -y
sudo apt install -y apt-transport-https -y

sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt update -y
sudo apt install -y kubelet kubeadm  containerd kubectl
# apt-mark hold will prevent the package from being automatically upgraded or removed.

sudo apt-mark hold kubelet kubeadm kubectl containerd

sudo cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

sudo cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

sudo mkdir -p /etc/containerd
sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo systemctl restart containerd

# Enable and start kubelet service
sudo systemctl daemon-reload
sudo systemctl start kubelet
sudo systemctl enable kubelet.service

# common for master and worker nodes commands ends
# $ kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
#sudo kubeadm init 
# worker nodes to join cluster

#sudo kubeadm join 10.0.0.14:6443 --token 3d1m08.73dpoc0mm2jicyk6 \
 #       --discovery-token-ca-cert-hash sha256:49b5466547744e26ac3813045e9e2258f89c7896846db9e236bd9d52b64a8dcb

sudo kubeadm join 10.0.0.6:6443 --token 1w3csw.osfyugncoyjvj87z \
        --discovery-token-ca-cert-hash sha256:479e547922276eea2084e7726f89aef5dc6528c1e1238f5d038d2111f08333f6

sudo kubeadm join 10.0.0.6:6443 --token x1cckb.qkqp1qs0gv09rtkx \
--discovery-token-ca-cert-hash sha256:479e547922276eea2084e7726f89aef5dc6528c1e1238f5d038d2111f08333f6


kubeadm token create --print-join-command