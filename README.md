# ☸️ Kubernetes CKA Exam Preparation  📋

Notes of Certified Kubernetes Administrator Exam Preparation

## CNCF Foundation Curriculum
Study all topics as proposed in the curriculum till you feel comfortable with all.

Read the Curriculum and check here the updated CKA .pdf file:
<https://github.com/cncf/curriculum>

## Linux Foundation Instructions
Read the Handbook, the tips and the FAQ: 
+ <https://docs.linuxfoundation.org/tc-docs/certification/lf-handbook2>
+ <https://docs.linuxfoundation.org/tc-docs/certification/tips-cka-and-ckad>
+ <https://docs.linuxfoundation.org/tc-docs/certification/faq-cka-ckad>

## Kubernetes documentation
Get familiar with the Kubernetes documentation and be able to use the search. Allowed links are:

+ <https://kubernetes.io/docs>
+ <https://kubernetes.io/blog>

NOTE: Verify the allowed list [here](https://docs.linuxfoundation.org/tc-docs/certification/certification-resources-allowed#certified-kubernetes-administrator-cka-and-certified-kubernetes-application-developer-ckad)

## 🥅 Main Goal of the Repo-Lab!
The goal of this repository is to pin utilities, links, tips and notes to prepare me (and share with others) for The Linux Foundation CKA exam and providing an environment of some virtual machines on my local computer to have a lab available without some public cloud provider. 

<img src="https://kubernetes.io/images/kubeadm-stacked-color.png" align="right" width="150px"> 

The idea is to use the kubeadm tools offered by the official documentation :
+ <https://kubernetes.io/docs/tasks/tools/>
+ <https://kubernetes.io/docs/reference/setup-tools/kubeadm/>
+ <https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/>
 
## Kubernetes Important Updates

### [ChangePackageRepo](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/change-package-repository/#before-you-begin)

> ⚠️ **For kubeadm,kubelet and kubectl installation Note:** The legacy Linux package repositories (**apt.kubernetes.io and yum.kubernetes.io AKA packages.cloud.google.com**)
have been frozen starting from September 13, 2023 and are going away in January 2024, users must migrate.
Please read our announcement [for more details.](https://kubernetes.io/blog/2023/08/15/pkgs-k8s-io-introduction/)
Using the new package repositories hosted at **pkgs.k8s.io** is strongly recommended

## 🦮 Guides that I highly recommend to follow!

This guides help me a lot to understand all the aspects of the CKA Exam and also inspire me, to create a Vagrantfile to follow step by step all the labs manually, of course offered by The Linux Foundation [LFS258](https://training.linuxfoundation.org/training/kubernetes-fundamentals/) . 

+ [KodeKloud - CKA Repo](https://github.com/kodekloudhub/certified-kubernetes-administrator-course.git)
+ [DevOpsCube - Exam Guide](https://devopscube.com/cka-exam-study-guide/)
+ [DevOpsCube - Automated Vagrant Cluster](https://devopscube.com/kubernetes-cluster-vagrant/)
+ [Troubleshooting kubeadm all topics](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/troubleshooting-kubeadm/)
+ [Vagrant topic for troubleshooting kubeadm](https://jhooq.com/kubernetes-error-execution-phase-preflight-preflight/)
+ [TechiescampVagrant](https://github.com/techiescamp/vagrant-kubeadm-kubernetes/tree/main)

Just to help someone, I bought the course (LFS258) + CKA Exam bundle, at one of the times of the year when they have 50% discount; such as BlackFriday or black week which usually (in italy) the period is from November 22 to Cyber Monday on Monday, December 2!

In any case DevOps Cube (and other website) often offers temporary discount codes also [KodeKloud.com](https://kodekloud.com/) (at the moment the best platform for preparing CKA Exam)!

## Exercise and playground for the exam preparation

+ [CKA Simulator - killer.sh](https://killer.sh/cka)
+ [CKA Scenarios - killercoda.com](https://killercoda.com/killer-shell-cka)
+ [Learning Playground - by Docker](https://labs.play-with-k8s.com/)

## :hammer_and_wrench: 🐜 Precaution In-progress project

⚠️ The lab, files, and scripts are continually being updated and for personal study purpose, so you may run into errors or problems when starting vm's or installing the cluster.
