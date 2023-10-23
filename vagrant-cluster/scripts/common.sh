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