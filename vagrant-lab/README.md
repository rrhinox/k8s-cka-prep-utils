# 🧪 Vagrant Lab Prerequisites
The lab requires the installation and use of the following tools
+ VirtualBox
+ Vagrant
+ IDE or preferred editor (e.g. Visual Studio Code, vim..) 
+ Git for cloning repositories
+ kubectl 

## 📜 Official useful doc
+ [kubectl cheatsheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
+ [Vagrant Prerequisites](https://developer.hashicorp.com/vagrant/tutorials/getting-started/getting-started-index#prerequisites)
+ [Vagrant Tutorial](https://developer.hashicorp.com/vagrant/tutorials/getting-started)

## Vagrant basics to start Lab VMs
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
> + if you use git-bash.exe the Ctrl + C exit from ssh session opened  via `vagrant ssh` command, see this [issue](https://github.com/hashicorp/vagrant/issues/12908). You can simply use powershell to jump in the ubuntu host as workaround.
> + Vagrant create 2 network interface (eth0 and eth1) this needs to be taken into account at cluster init via kubeadm configuration file, see vagrant-cluster/scripts/common.sh and search to kubeadm init command (with podSubnet).
> + If you install VBox on Windows10 you can incurr in Error and you need this to install VBox correctly : [MS Visuial C++](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170)


## :hammer_and_wrench: 🐜 Precaution In-progress project

⚠️ The lab, files, and scripts are continually being updated and for personal study purpose, so you may run into errors or problems when starting vm's or installing the cluster.