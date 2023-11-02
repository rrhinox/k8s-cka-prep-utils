#!/bin/bash
# Common setup for all servers 
sudo apt-get update -y && sudo apt-get upgrade -y

# Add other dependencies and sw
sudo apt-get install apt-transport-https gnupg2 uidmap -y

# Load modules
sudo modprobe overlay
sudo modprobe br_netfilter

# Disable firewall
sudo ufw disable

# Turn off swap
sudo swapoff -a

# add into /etc/hosts
sudo echo "192.168.0.10 cplane" >> /etc/hosts
sudo echo "192.168.0.11 worker01" >> /etc/hosts
sudo echo "192.168.0.12 worker02" >> /etc/hosts

# Update kernel networking to allow necessary traffic.
sudo cat << EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Ensure the changes
sudo sysctl --system

# ----- Install keys and repo for containerd ----- #
sudo mkdir -m 755 /etc/apt/keyrings
# ----- #
curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
| sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# ----- #
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# ----- Containerd ----- #
sudo apt-get update && sudo apt-get install containerd -y
sudo mkdir /etc/containerd
sudo containerd config default >> /etc/containerd/config.toml
# ---- Tell Containerd use systemd as cgroup driver (reccomended if you use cgroup v2) ----- #
# doc: https://kubernetes.io/docs/setup/production-environment/container-runtimes/#containerd-systemd
# check cgroup : https://kubernetes.io/docs/concepts/architecture/cgroups/#check-cgroup-version
sudo sed -e 's/SystemdCgroup = false/SystemdCgroup = true/g' -i /etc/containerd/config.toml
sudo systemctl restart containerd

# ----- Install Kubernetes SW ----- #
# doc: 
#   - https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
#   - https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl

# ----- Add repo for k8s ----- #
# OLD REPO URL :
# sudo echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
# ----- Download gpg key ----- #
# OLD REPO GPG KEY
# curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# NEW REPO URL : 
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.27/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

# ----- Download gpg key ----- #
# NEW REPO GPG KEY
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.27/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

sudo apt-get update -y

sudo apt-get install -y kubeadm kubelet kubectl

# ----- Hold the software at the recent but stable version we install ----- #
sudo apt-mark hold kubeadm kubelet kubectl

# kubeadm init --apiserver-advertise-address="192.168.0.10" --service-cidr=172.68.0.10/12 --pod-network-cidr=10.255.0.0/16 --upload-certs | tee kubeadm-init.out

# Copy containerd file example into containerd folder
cp /home/vagrant/10-containerd-net.conflist /etc/cni/net.d/

# ----- Copy config file for kubectl > .kube/config ----- #
#   mkdir -p $HOME/.kube
#   sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#   sudo chown $(id -u):$(id -g) $HOME/.kube/config

# ----- Enable bash completion ----- #
# sudo apt-get install bash-completion -y
# <exit and log back in>
# source <(kubectl completion bash)
# echo "source <(kubectl completion bash)" >> $HOME/.bashrc

# ----- CNI Example for containerd configuration file in ../files folder ----- #
# doc : https://kubernetes.io/docs/tasks/administer-cluster/migrating-from-dockershim/troubleshooting-cni-plugin-related-errors/#an-example-containerd-configuration-file