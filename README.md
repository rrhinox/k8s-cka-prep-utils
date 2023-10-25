# ☸️📋K8s CKA Preparation Utils
Notes of Kubernetes CKA Certification Exam Preparation

## 🥅 Main Goal!
The goal of this repository is to pin utilities and notes to prepare me for The Linux Foundation CKA exam, by providing an environment of some virtual machines on a local computer to have a lab available without some public cloud provider. 

<img src="https://kubernetes.io/images/kubeadm-stacked-color.png" align="right" width="150px"> 

The idea is to use the kubeadm tools offered by the official documentation :
+ <https://kubernetes.io/docs/tasks/tools/>
+ <https://kubernetes.io/docs/reference/setup-tools/kubeadm/>
+ <https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/>
+ <https://kubernetes.io/docs/home/>

## Kubernetes Updates

[ChangePackageRepo](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/change-package-repository/#before-you-begin)

> ⚠️ **For kubeadm,kubelet and kubectl installation Note:** The legacy package repositories (apt.kubernetes.io and yum.kubernetes.io) have been deprecated and frozen starting from September 13, 2023. ***Using the new package repositories hosted at pkgs.k8s.io is strongly recommended*** and required in order to install Kubernetes versions released after September 13, 2023. The deprecated legacy repositories, and their contents, might be removed at any time in the future and without a further notice period. The new package repositories provide downloads for Kubernetes versions starting with v1.24.0.

## 🧪 Lab Prerequisites
The lab requires the installation and use of the following tools
+ VirtualBox
+ Vagrant
+ IDE or preferred editor (e.g. Visual Studio Code, vim..) and Git 

### 📜 Official Docs
+ [Vagrant Prerequisites](https://developer.hashicorp.com/vagrant/tutorials/getting-started/getting-started-index#prerequisites)
+ [Vagrant Tutorial](https://developer.hashicorp.com/vagrant/tutorials/getting-started)

## 🪄 Vagrant basics to start Lab VMs
+ `vagrant up` - Turn on all the VMs and run Vagrantfile (please enter into vagrant-cluster/ folder before run this command)
+ `vagrant status` - Check the status of the VM's
+ `vagrant ssh worker01.kube` - Open ssh on target VM
+ `vagrant destroy worker01.kube` - Destroy specific instance or destroy all instances, without VM name

## 🕵️ Lab versions tested
The Vagrantfile has been tested for now only with :
+ Windows 11 Pro - 22H2 22621.2283 with Windows Feature Experience Pack 1000.22662.1000.0
+ Virtual box 7.0.10 r158379 (Qt5.15.2)
+ Vagrant 2.4.0

> 🐛 (i) Known problem with gitbash fo Vagrant : 
> + if you use git-bash.exe the Ctrl + C exit from ssh session opened  via `vagrant ssh` command. You can simply use powershell to jump in the ubuntu host.
> + Vagrant create 2 network interface (eth0 and eth1) this needs to be taken into account at cluster init via kubeadm configuration file, see vagrant-cluster/scripts/common.sh:line:76 (podSubnet).

## 🦮 Guides that I highly recommend to follow!

This guides help me a lot to understand all the aspects of the CKA Exam and also inspire me to create a Vagrantfile to follow step by step all the labs manually of course offered by The Linux Foundation [LFS258](https://training.linuxfoundation.org/training/kubernetes-fundamentals/)

+ [DevOpsCube - Exam Guide](https://devopscube.com/cka-exam-study-guide/)
+ [DevOpsCube - Automated Vagrant Cluster](https://devopscube.com/kubernetes-cluster-vagrant/)
+ [Troubleshooting kubeadm all topics](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/troubleshooting-kubeadm/)
+ [Vagrant topic for troubleshooting kubeadm](https://jhooq.com/kubernetes-error-execution-phase-preflight-preflight/)


## :hammer_and_wrench: 🐜 Precaution In-progress project

⚠️ The lab, files, and scripts are continually being updated and for study purposes so you may run into errors or problems when starting vm's or installing the cluster.