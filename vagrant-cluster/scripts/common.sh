#!/bin/bash
# Common setup for all servers 
sudo apt-get update -y && sudo apt-get upgrade -y
sudo ufw disable

# disable swap
sudo swapoff -a

# add into /etc/hosts
sudo echo "192.168.0.10 cplane.kube" >> /etc/hosts
sudo echo "192.168.0.11 worker01.kube" >> /etc/hosts
sudo echo "192.168.0.12 worker02.kube" >> /etc/hosts
