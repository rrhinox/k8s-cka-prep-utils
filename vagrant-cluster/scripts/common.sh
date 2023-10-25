#!/bin/bash
# Common setup for all servers 
sudo apt-get update -y && sudo apt-get upgrade -y

# Add other dependencies 
sudo apt-get install apt-transport-https gnupg2 uidmap -y

# Load modules
sudo modprobe overlay
sudo modprobe br_netfilter

# Disable firewall
sudo ufw disable

# Turn off swap
sudo swapoff -a

# add into /etc/hosts
sudo echo "192.168.0.10 cplane.kube" >> /etc/hosts
sudo echo "192.168.0.11 worker01.kube" >> /etc/hosts
sudo echo "192.168.0.12 worker02.kube" >> /etc/hosts

# Update kernel networking to allow necessary traffic.
sudo cat << EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

# Ensure the changes
sudo sysctl --system

# ----- Install keys and repo for containerd ----- #
# sudo mkdir -p /etc/apt/keyrings
# ----- #
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
# | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# sudo apt-get update && sudo apt-get install containerd.io -y
# ----- #
# echo \
# "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
# https://download.docker.com/linux/ubuntu \
# $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# ----- Containerd ----- #
# sudo apt-get update && sudo apt-get install containerd.io -y
# sudo containerd config default | sudo tee /etc/containerd/config.toml
# sudo sed -e 's/SystemdCgroup = false/SystemdCgroup = true/g' -i /etc/containerd/config.toml
# sudo systemctl restart containerd

# ----- Install Kubernetes SW ----- #
# echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
# curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# sudo apt-get update
# sudo apt-get install -y kubeadm=1.25.1-00 kubelet=1.25.1-00 kubectl=1.25.1-00

# ----- Hold the software at the recent but stable version we install ----- #
# sudo apt-mark hold kubeadm kubelet kubectl

# ----- Using Calico as a Network plugin will allow to use Network Policy later ----- #
# wget https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml
# grep -A4 -B3 CALICO_IPV4POOL_CIDR calico.yaml
    # The default IPv4 pool to create on startup if none exists. Pod IPs will be
    # chosen from this range. Changing this value after installation will have
    # no effect. This should fall within `--cluster-cidr`.
    # - name: CALICO_IPV4POOL_CIDR
    #   value: "192.168.0.0/16"
    # Disable file logging so `kubectl logs` works.

# ----- kubeadm-config.yaml ----- #
# apiVersion: kubeadm.k8s.io/v1beta3
# kind: ClusterConfiguration
# kubernetesVersion: 1.25.1 #<-- Use the word stable for newest version
# controlPlaneEndpoint: "k8scp:6443" #<-- Use the alias we put in /etc/hosts not the IP
# networking:
#   podSubnet: 192.168.0.0/16 #<-- Match the IP range from the Calico config file

# sudo kubeadm init --config kubeadm-config.yaml --upload-certs | tee /tmp/kubeadm-init.out

