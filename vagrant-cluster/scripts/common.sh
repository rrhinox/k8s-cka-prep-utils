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

# ----- Containerd START ----- #
sudo apt-get update && sudo apt-get install containerd -y
sudo mkdir /etc/containerd
sudo containerd config default >> /etc/containerd/config.toml

# ---- Tell Containerd use systemd as cgroup driver (reccomended if you use cgroup v2) ----- #
# doc: https://kubernetes.io/docs/setup/production-environment/container-runtimes/#containerd-systemd
# check cgroup : https://kubernetes.io/docs/concepts/architecture/cgroups/#check-cgroup-version
sudo sed -e 's/SystemdCgroup = false/SystemdCgroup = true/g' -i /etc/containerd/config.toml

# Copy containerd file example into containerd folder
sudo cp /home/vagrant/10-containerd-net.conflist /etc/cni/net.d/

# restart containerd service
sudo systemctl restart containerd

# ----- Containerd END ----- #

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

# Run init for control-plane node
# kubeadm init --apiserver-advertise-address="192.168.0.10" --service-cidr=172.68.0.10/12 --pod-network-cidr=10.255.0.0/16 --upload-certs --kubernetes-version=stable-1.27 | tee kubeadm-init.out

# ----- If token expire use kubeadm to create it and check the expiration ----- # 
## ----- sudo kubeadm token list
## ----- sudo kubeadm token create
# ----- Run openssl to get discovery-token-ca-cert-hash on controlplane and use in kubeadm join on worker node: ----- #
## ----- openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'"
## -----> example output: 807805fa347262143e39bc97a6d835907aeb5aec30f19d8d9d09c55fe4f27154

# ----- Run join for worker node ----- #
# kubeadm join --token 1gvlxo.a2o1yyyygwlbxxx8 192.168.0.10:6443 --discovery-token-ca-cert-hash sha256:807805fa347262143e39bc97a6d835907aeb5aec30f19d8d9d09c55fe4f27154

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

# ----- Add / Remove Role label to worker ----- #
# kubectl label nodes worker01 node-role.kubernetes.io/worker=worker # (output: node/worker01 labeled)
# kubectl label nodes worker01 node-role.kubernetes.io/worker- # (output: node/worker01 unlabeled )


#################### NOTES AND TOOLS AFTER INSTALLATION ###############################
# https://kubernetes.io/docs/tasks/debug/debug-cluster/crictl/
# crictl is a command-line interface for CRI-compatible container runtimes. 
# You can use it to inspect and debug container runtimes and applications on a Kubernetes node. 
# crictl and its source are hosted in the cri-tools repository.

# ----- Example of crictl config file ----- #
# sudo cat /etc/crictl.yaml 
# runtime-endpoint: unix:///var/run/containerd/containerd.sock
# image-endpoint: unix:///var/run/containerd/containerd.sock
# timeout: 10
# debug: true

# ----- Find out the correct endpoint ----- #
# ps -ef | grep container-runtime-endpoint
# example of output : --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock

# ----- Some basic commands ----- #
# Run endpoint on command line : 
# sudo crictl -r unix:///var/run/containerd/containerd.sock ps -a
