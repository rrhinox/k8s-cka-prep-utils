# ☸️📋K8s CKA Preparation Utils
Notes of Kubernetes CKA Certification Exam Preparation

## 🥅 Main Goal!
The goal of this repository is to pin utilities and notes to prepare me for The Linux Foundation CKA exam, by providing an environment of some virtual machines on a local computer to have a lab available without some public cloud provider.  

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

