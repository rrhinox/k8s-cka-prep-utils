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

> 🐛 (i) Known issue with gitbash for windows and Vagrant : 
+ if you use git-bash.exe the Ctrl + C exit from ssh session opened via `vagrant ssh` command
+ Vagrant create 2 network interface (eth0 and eth1) this needs to be taken into account at cluster init via kubeadm configuration file, see vagrant-cluster/scripts/common.sh:line:76 (podSubnet).

## 🦮 Guides that I highly recommend to follow!

This guides help me a lot to understand all the aspects of the CKA Exam and also inspire me to create a Vagrantfile to follow step by step all the labs manually of course offered by The Linux Foundation [LFS258](https://training.linuxfoundation.org/training/kubernetes-fundamentals/)

+ [DevOpsCube - Exam Guide](https://devopscube.com/cka-exam-study-guide/)
+ [DevOpsCube - Automated Vagrant Cluster](https://devopscube.com/kubernetes-cluster-vagrant/)
+ [Vagrant Troubleshoot](https://jhooq.com/kubernetes-error-execution-phase-preflight-preflight/)
+ [Troubleshooting kubeadm all topics](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/troubleshooting-kubeadm/)
+ [Vagrant topic for troubleshooting kubeadm](https://jhooq.com/kubernetes-error-execution-phase-preflight-preflight/)
