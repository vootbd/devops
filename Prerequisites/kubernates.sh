#!/bin/bash

# 1) Update host entries, disable swap, and add kernel parameters
echo "192.168.1.190   k8smaster.example.com k8smaster" >> /etc/hosts
echo "192.168.1.191   k8sworker.example.com k8sworker" >> /etc/hosts
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo "overlay" | sudo tee /etc/modules-load.d/containerd.conf
echo "br_netfilter" | sudo tee -a /etc/modules-load.d/containerd.conf
sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system

# 2) Install Containerd and Enable Kubernetes repository
sudo apt-get install -y curl software-properties-common apt-transport-https ca-certificates

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y

sudo apt-get update -y && sudo apt-get install -y containerd.io

containerd config default | sudo tee /etc/containerd/config.toml
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml
sudo systemctl restart containerd && sudo systemctl enable containerd

# 3) Install kubeadm, kubectl, and kubelet
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main" -y
sudo apt-get update -y && sudo apt-get install -y kubelet kubeadm kubectl && sudo apt-mark hold kubelet kubeadm kubectl

# 4) Initialize Kubernetes cluster
sudo kubeadm init --control-plane-endpoint=k8smaster.example.com
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 5) Add worker node to cluster & install Calico CNI
# (Run this section on the worker node)
sudo kubeadm join k8smaster.example.net:6443

# (Run the rest on the master node)
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/master/manifests/calico.yaml
kubectl get pods -n kube-system
kubectl get nodes

# 6) Test Kubernetes cluster installation
kubectl create deployment nginx-app --image=nginx --replicas=2
kubectl get deployment nginx-app
kubectl get pods
kubectl expose deployment nginx-app --type=NodePort --port=80
kubectl get svc nginx-app && kubectl describe svc nginx-app

# Access the Nginx application (replace with actual worker IP and nodeport)
curl http://worker-ip-address:nodeport