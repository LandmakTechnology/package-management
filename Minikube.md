## Minikube
Introduction

Minikube is an open source tool that allows you to set up a single-node Kubernetes cluster on your local machine. The cluster is run inside a virtual machine and includes Docker, allowing you to run containers inside the node.

This is an excellent way to test in a Kubernetes environment locally, without using up too much resources.

This tutorial will show you how to install Minikube on Ubuntu 18.04 or 20.04.

## How to install Miikube on Ubuntu.
Prerequisites

A system running Ubuntu 18.04 Bionic Beaver or Ubuntu 20.04
A user account with sudo privileges
Access to a terminal window / command line (Ctrl+Alt+T, search > terminal)
How to Install Minikube on Ubuntu
To install Minikube on Ubuntu, follow the steps outlined below. Besides installation instructions, you can also find some basic commands for working inside your local single-node cluster.

## Step 1: Update System and Install Required Packages
Before installing any software, you need to update and upgrade the system you are working on. To do so, run the commands:
```
sudo apt-get update -y

sudo apt-get upgrade -y
```
Updating the software package list on Ubuntu.
Also, make sure to install (or check whether you already have) the following required packages:
```
sudo apt-get install curl

sudo apt-get install apt-transport-https
```
In the image below, the output informs that the packages are already installed.

Install dependencies for installing Minikube.
Step 2: Install VirtualBox Hypervisor
As mentioned above, you need a virtual machine in which you can set up your single node cluster with Minikube. Depending on your preference, you can use VirtualBox or KVM.

## This guide will show you how to install Minikube with VirtualBox.

1. To install VirtualBox on Ubuntu, run the command:
```
sudo apt install virtualbox virtualbox-ext-pack
```
Terminal VirtualBox installation process in the Linux terminal.
2. Confirm the installation with y and hit Enter.

3. Next, the licence agreement appears on the screen. Press Tab and then Enter to continue.

VirtualBox licence agreement.
4. The installer asks you to agree with the terms of the VirtualBox PUEL license by selecting Yes.

Setting up virtualbox-ext-pack.
5. Wait for the installation to complete and then move on to the next step.

Note: For the VirtualBox hypervisor to work, hardware virtualization must be enabled in your system BIOS.

## Step 3: Install Minikube
With VirtualBox set up, move on to installing Minikube on your Ubuntu system.

1. First, download the latest Minikube binary using the wget command:
```
wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
```
Downloading the Minikube binary to install Minikube on Ubuntu 18.04.
2. Copy the downloaded file and store it into the /usr/local/bin/minikube directory with:
```
sudo cp minikube-linux-amd64 /usr/local/bin/minikube
```
There will be no output if the command was executed correctly.

3. Next, give the file executive permission using the chmod command:
```
sudo chmod 755 /usr/local/bin/minikube
```
Again, there will be no output.

Move Minikube file and give it executive permission.
4. Finally, verify you have successfully installed Minikube by checking the version of the software:
```
minikube version
```
The output should display the version number of the software, as in the image below.

Check Minikube version.
## Step 4: Install Kubectl
To deploy and manage clusters, you need to install kubectl, the official command line tool for Kubernetes.

1. Download kubectl with the following command:
```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
```
Download Kubectl binary on Ubuntu.
2. Make the binary executable by typing:
```
chmod +x ./kubectl
```
3. Then, move the binary into your path with the command:
```
sudo mv ./kubectl /usr/local/bin/kubectl
```
4. Verify the installation by checking the version of your kubectl instance:
```
kubectl version -o json
```
Step 5: Start Minikube
Once you have set up all the required software, you are ready to start Minikube.

Run the following command:
```
minikube start
```
First, the system downloads the Minikube ISO file from an online source and the localkube binary. Then, it creates a virtual machine in VirtualBox within which it starts and configures a single node cluster.

The command to start Minikube on Ubuntu.
Managing Kubernetes with Minikube
Common Minikube Commands
To see the kubectl configuration use the command:
```
kubectl config view
```
Image of using the kubectl config view command.
To show the cluster information:
```
kubectl cluster-info
```
Obtaining kubectl cluster information via the terminal.
To check running nodes use the following command:
```
kubectl get nodes
```
Get information on all active kubectl node.
To see a list of all the Minikube pods run:
```
kubectl get pod
```
To ssh into the Minikube VM:
```
minikube ssh
```
How to SSH into your Minikube node.
To exit out of the shell run:
```
exit
```
To stop running the single node cluster type:
```
minikube stop
```
Command to stop Minikube and the expected terminal output.
To check its status use:
```
minikube status
```
Check the status of your Minikube node cluster.
To delete the single node cluster:
```
minikube delete
```
To see a list of installed Minikube add-ons:
```
minikube addons list
```
A list of installed Minikube addons.
Access Minikube Dashboard
Minikube comes with a dashboard add-on by default. The web dashboard provides a way to manage your Kubernetes cluster without actually running commands in the terminal.

To enable and access the Minikube dashboard via terminal, run the following command:
```
minikube dashboard
```
Enabling and accessing the Minikube dashboard.
Once you exit the terminal, the process will end and the Minikube dashboard will shut down.

Alternatively, you can access the dashboard directly via browser.

To do so, acquire the dashboard’s IP address:
```
minikube dashboard --url
```
Terminal command to get the Minikube dashboard URL for accessing it via browser.
Access your Minikube dashboard by browsing to your dashboard’s IP address.

Conclusion

By following this article, you should have successfully installed and configured Minikube on Ubuntu 18.04 or 20.04. You can now test and master the art of Kubernetes on your local machine with the help of a single Minikube node.
