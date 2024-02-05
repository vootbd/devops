#!/bin/bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install software-properties-common gnupg2 curl unzip wget -y
curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg
sudo install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/
sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get install terraform
terraform --version
