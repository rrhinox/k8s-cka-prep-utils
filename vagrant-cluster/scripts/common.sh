#!/bin/bash
# Common setup for all servers 
sudo apt update -y && sudo apt upgrade -y
sudo ufw disable

# disable swap
sudo swapoff -a

# add into /etc/hosts
sudo echo "192.168.0.0 cplane.kube" >> /etc/hosts
sudo echo "192.168.0.1 worker01.kube" >> /etc/hosts
sudo echo "192.168.0.2 worker02.kube" >> /etc/hosts
